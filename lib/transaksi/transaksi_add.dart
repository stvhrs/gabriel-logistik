import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.only(
            right: ket == 'Tanggal' || ket == 'Keterangan' ? 0 : 70,
            bottom: 50),
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
        .length+1;
    return Container(margin: EdgeInsets.only(right: 15,bottom: 15),
        child: ElevatedButton.icon(icon: Icon(Icons.add),label: Text('Tambah Transaksi'),style:  ButtonStyle(
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
                                                200),
                                            _buildSize(
                                                DropDownField(
                                                  onValueChanged: (val) {
                                                    transaksi.mobil = val;
                                                  },
                                                  items: listMobil,
                                                ),
                                                'Pilih Mobil',
                                                200),
                                            _buildSize(TextFormField(
                                              onChanged: (va) {
                                                transaksi.tujuan = va;
                                              },
                                            ), 'Ketik Tujuan', 200),
                                            const Spacer(),
                                            _buildSize(
                                                WebDatePicker(
                                                  height: 60,
                                                  initialDate: DateTime.now(),
                                                  dateformat: 'dd/MM/yyyy',
                                                  onChange: (value) {
                                                    if (value != null) {
                                                      transaksi
                                                              .tanggalBerangkat =
                                                          value
                                                              .toIso8601String();
                                                    }
                                                  },
                                                ),
                                                'Tanggal',
                                                200)
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
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
                                              200),
                                          _buildSize(
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
                                              200),
                                          _buildSize(
                                              TextFormField(onChanged: (val) {
                                            transaksi.keterangan = val;
                                          }), 'Keterangan', 400),
                                        ],
                                      ),

                                      // const Text(
                                      //   'Perbaikan :',
                                      //   style: TextStyle(fontSize: 13),
                                      // ),
                                      // const Divider(),
                                      // ...List.generate(
                                      //     jumlahOpsi,
                                      //     (index) =>
                                      //         _buildPartName(index, context)),
                                      // Row(
                                      //   children: [
                                      //     const Text('Tambah Perbaikan'),
                                      //     IconButton(
                                      //         onPressed: () {
                                      //           setState(() {
                                      //             if (jumlahOpsi ==
                                      //                 _updatedTransaksi
                                      //                     .length) {
                                      //               _updatedTransaksi
                                      //                   .add(Transaksi.fromMap(
                                      //                 {
                                      //                   'id_transaksi': 1,
                                      //                   'tgl_berangkat':
                                      //                       '2022-07-20T20:18:04.000Z',
                                      //                   'tanggalPulang':
                                      //                       '2022-07-20T20:18:04.000Z',
                                      //                   'supir': 'Budi',
                                      //                   'tujuan': 'Gemolong',
                                      //                   'mobil':
                                      //                       'Ford AD 9999 RR',
                                      //                   'gajiSupir': 100,

                                      RoundedLoadingButton(
                                        color: Theme.of(context).primaryColor,elevation: 10,
                                        successColor: Colors.green,
                                        errorColor: Colors.red,
                                        child: Text('Tambah',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        controller: _btnController,
                                        onPressed: () async {
                                          if (transaksi.keluar == 0 ||
                                              transaksi.ongkos == 0 ||
                                              transaksi.mobil == '' ||
                                              transaksi.tujuan == '' ||
                                              transaksi.supir == '' ||
                                              transaksi.tanggalBerangkat ==
                                                  '') {
                                            _btnController.error();
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            _btnController.reset();
                                            return;
                                          }

                                          await Future.delayed(
                                              Duration(seconds: 3), () {
                                            Provider.of<ProviderData>(context,
                                                    listen: false)
                                                .addTransaksi(transaksi);
                                            _btnController.success();
                                          });
                                          await Future.delayed(
                                              Duration(seconds: 1), () {
                                            Navigator.of(context).pop();
                                          });
                                        },
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
