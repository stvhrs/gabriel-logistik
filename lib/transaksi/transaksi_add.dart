import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/input_currency.dart';

class TransaksiAdd extends StatefulWidget {
  const TransaksiAdd({super.key});

  @override
  State<TransaksiAdd> createState() => _TransaksiAddState();
}

class _TransaksiAddState extends State<TransaksiAdd> {
  List<String> listSupir = [];
  List<String> listMobil = [];

  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false)
        .listSupir
        .map((e) => e.nama_supir)
        .toList()
        .forEach((element) {
      if (listSupir.contains(element)) {
      } else {
        listSupir.add(element);
      }
    });
    Provider.of<ProviderData>(context, listen: false)
        .listMobil
        .map((e) => e.nama_mobil)
        .toList()
        .forEach((element) {
      print(element);
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });

    super.initState();
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  Transaksi transaksi = Transaksi.fromMap({
    'id_transaksi': 1,
    'tgl_berangkat': DateTime.now().toIso8601String(),
    'keterangan': '',
    'supir': '',
    'tujuan': '',
    'mobil': '',
    'keluar': 0,
    'ongkos': 0,
    'perbaikan_transaksi': []
  });
  Widget _buildSize(widget, String ket, int flex) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.14 * flex,
      margin: EdgeInsets.only(right: ket == 'Tanggal' ? 0 : 50, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: Text(
                '$ket :',
                style: const TextStyle(fontSize: 13),
              )),
          widget
        ],
      ),
    );
  }

  Widget _buildSizeV2(
    widget,
    String ket,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 0, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 7),
                child: Text(
                  '$ket :',
                  style: const TextStyle(fontSize: 13),
                )),
            widget
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    transaksi.transaksiId = Provider.of<ProviderData>(context, listen: false)
            .backupTransaksi
            .length +
        1;
    return Container(
        margin: const EdgeInsets.only(right: 15, bottom: 15),
        child: ElevatedButton.icon(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text(
              'Tambah Transaksi',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        backgroundColor: Theme.of(context).primaryColor,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            const Text(
                              'Tambah Transaksi',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 13,
                                      color: Colors.red,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        titlePadding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        content: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    IntrinsicHeight(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20, top: 15),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(bottom: 50),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildSize(
                                                DropDownField(
                                                  onValueChanged: (val) {
                                                    transaksi.supir = val;
                                                  },
                                                  items: listSupir,
                                                ),
                                                'Pilih Supir',
                                                1),
                                            _buildSize(
                                                DropDownField(
                                                  onValueChanged: (val) {
                                                    transaksi.mobil = val;
                                                  },
                                                  items: listMobil,
                                                ),
                                                'Pilih Mobil',
                                                1),
                                            _buildSize(TextFormField(
                                              onChanged: (va) {
                                                transaksi.tujuan = va;
                                              },
                                            ), 'Ketik Tujuan', 1),
                                            _buildSizeV2(
                                              WebDatePicker(
                                                width: double.infinity,
                                                height: 60,
                                                initialDate: DateTime.now(),
                                                dateformat: 'dd/MM/yyyy',
                                                onChange: (value) {
                                                  if (value != null) {
                                                    transaksi.tanggalBerangkat =
                                                        value.toIso8601String();
                                                  }
                                                },
                                              ),
                                              'Tanggal',
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [  _buildSize(
                                              TextFormField(
                                                onChanged: (va) {
                                                  if (va.isNotEmpty &&
                                                      va.startsWith('Rp')) {
                                                    transaksi.ongkos =
                                                        Rupiah.parse(va);
                                                  } else {
                                                    transaksi.ongkos = 0;
                                                  }
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  CurrencyInputFormatter()
                                                ],
                                              ),
                                              'Biaya Ongkos',
                                              1),
                                          _buildSize(
                                              TextFormField(
                                                onChanged: (va) {
                                                  if (va.isNotEmpty &&
                                                      va.startsWith('Rp')) {
                                                    transaksi.keluar =
                                                        Rupiah.parse(va);
                                                  } else {
                                                    transaksi.keluar = 0;
                                                  }
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  CurrencyInputFormatter()
                                                ],
                                              ),
                                              'Biaya Keluar',
                                              1),
                                        
                                          _buildSizeV2(
                                            TextFormField(onChanged: (val) {
                                              transaksi.keterangan = val;
                                            }),
                                            'Keterangan',
                                          ),
                                        ],
                                      ),
                                      RoundedLoadingButton(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 10,
                                        successColor: Colors.green,
                                        errorColor: Colors.red,
                                        controller: _btnController,
                                        onPressed: () async {
                                          if (transaksi.keluar == 0 ||
                                              transaksi.keluar >=
                                                  transaksi.ongkos ||
                                              transaksi.ongkos == 0 ||
                                              transaksi.mobil == '' ||
                                              transaksi.tujuan == '' ||
                                              transaksi.supir == '' ||
                                              transaksi.tanggalBerangkat ==
                                                  '') {
                                            _btnController.error();
                                            await Future.delayed(
                                                const Duration(seconds: 1));
                                            _btnController.reset();
                                            return;
                                          }

                                          await Future.delayed(
                                              const Duration(seconds: 3), () {
                                            Provider.of<ProviderData>(context,
                                                    listen: false)
                                                .addTransaksi(transaksi);
                                            _btnController.success();
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 1), () {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Tambah',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  });
            }));
  }
}
