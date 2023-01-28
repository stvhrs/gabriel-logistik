import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/input_currency.dart';

class TransaksiEdit extends StatefulWidget {
  final Transaksi transaksi;
  const TransaksiEdit({required this.transaksi});

  @override
  State<TransaksiEdit> createState() => _TransaksiEditState();
}

class _TransaksiEditState extends State<TransaksiEdit> {
  List<String> listSupir = [];
  List<String> listMobil = [];
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Transaksi transaksi = Transaksi.fromMap({
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
  @override
  void test() {
    print('inin dialgo');

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
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });

    transaksi = Transaksi(
        widget.transaksi.transaksiId,
        widget.transaksi.tanggalBerangkat,
        widget.transaksi.keterangan,
        widget.transaksi.supir,
        widget.transaksi.mobil,
        widget.transaksi.tujuan,
        widget.transaksi.keluar,
        widget.transaksi.ongkos,
        widget.transaksi.listPerbaikan);
    transaksi.listPerbaikan = List.from(widget.transaksi.listPerbaikan);
  }

  Widget _buildPartName(int i, BuildContext context, StateSetter stateSetter) {
    TextEditingController controller =
        TextEditingController(text: transaksi.listPerbaikan[i].nama_perbaikan);
    TextEditingController controller2 = TextEditingController(
        text: Rupiah.format(transaksi.listPerbaikan[i].harga_perbaikan));
    return Container(
        key: ValueKey(i),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSize2(
                TextFormField(
                 
                  controller: controller,
                  onChanged: (value) {
                    if (transaksi.listPerbaikan.isNotEmpty) {
                      transaksi.listPerbaikan[i].nama_perbaikan = value;
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Part'),
                ),
                1,
                false),
            _buildSize2(
                TextFormField(
      
                  controller: controller2,
                  decoration: const InputDecoration(hintText: 'Harga'),
                  onChanged: (value) {
                    if (transaksi.listPerbaikan.isNotEmpty) {
                      transaksi.listPerbaikan[i].harga_perbaikan =
                          NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
                              .parse(value)
                              .toDouble();
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter()
                  ],
                ),
                1,
                true),
            IconButton(
              onPressed: () {
                print(transaksi.listPerbaikan.length);
                transaksi.listPerbaikan.removeAt(i);
                print(transaksi.listPerbaikan.length);
                stateSetter(() {});
                for (var element in transaksi.listPerbaikan) {
                  print(element.nama_perbaikan);
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ));
  }

  Widget _buildSize(widget, String ket, int flex) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.14 * flex,
      margin: EdgeInsets.only(
          right: ket == 'Tanggal' || ket == 'Keterangan' ? 0 : 50, bottom: 30),
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
        margin: EdgeInsets.only(right: 0, bottom: 30),
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

  Widget _buildSize2(widget, int flex, bool ket) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.14 * flex,
        margin: EdgeInsets.only(right: ket ? 10 : 50, bottom: 10),
        child: widget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: const Icon(
          Icons.edit,
          color: Colors.green,
 
        ),
        onTap: () {
          test();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Theme(
                    data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            letterSpacing: 0.7),
                        //        border: InputBorder.none,

                        contentPadding:
                            const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.grey.shade200,

                        // hintStyle: TextStyle(
                        //   color: Colors.grey.shade600,
                        //   fontSize: 14,
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    child: AlertDialog(
                        backgroundColor: Colors.green,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            const Text(
                              'Edit Transaksi',
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
                                padding: const EdgeInsets.all(25),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(bottom: 50),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildSize(
                                                DropDownField(
                                                  value: transaksi.supir,
                                                  onValueChanged: (val) {
                                                    transaksi.supir = val;
                                                  },
                                                  items: listSupir,
                                                ),
                                                'Pilih Supir',
                                                1),
                                            _buildSize(
                                                DropDownField(
                                                  value: transaksi.mobil,
                                                  onValueChanged: (val) {
                                                    transaksi.mobil = val;
                                                  },
                                                  items: listMobil,
                                                ),
                                                'Pilih Mobil',
                                                1),
                                            _buildSize(
                                                TextFormField(
                                                  initialValue:
                                                      transaksi.tujuan,
                                                  onChanged: (va) {
                                                    transaksi.tujuan = va;
                                                  },
                                                ),
                                                'Ketik Tujuan',
                                                1),
                                            _buildSizeV2(
                                              WebDatePicker(
                                                height: 60,
                                                width: double.infinity,
                                                initialDate: DateTime.parse(
                                                    transaksi.tanggalBerangkat),
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
                                        children: [
                                          _buildSize(
                                              TextFormField(
                                                initialValue: Rupiah.format(
                                                    transaksi.keluar),
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
                                          _buildSize(
                                              TextFormField(
                                                initialValue: Rupiah.format(
                                                    transaksi.ongkos),
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
                                          _buildSizeV2(
                                            TextFormField(
                                                initialValue:
                                                    transaksi.keterangan,
                                                onChanged: (val) {
                                                  transaksi.keterangan = val;
                                                }),
                                            'Keterangan',
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'Perbaikan :',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      const Divider(),
                                      ...transaksi.listPerbaikan
                                          .map((e) => _buildPartName(
                                              transaksi.listPerbaikan
                                                  .indexOf(e),
                                              context,
                                              setState))
                                          .toList(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Tambah Perbaikan',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  transaksi.listPerbaikan
                                                      .add(Perbaikan.fromMap(
                                                    {
                                                      'nama_perbaikan': '',
                                                      'harga_perbaikan': 0
                                                    },
                                                  ));
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add_circle_rounded,
                                                color: Colors.green,
                                              )),

                                          // Text(jumlahOpsi.toString()),
                                        ],
                                      ),
                                      RoundedLoadingButton(
                                        color: Colors.green,
                                        successColor: Colors.green,
                                        errorColor: Colors.red,
                                        controller: _btnController,
                                        onPressed: () async {
                                          if (transaksi.keluar == 0 ||transaksi.keluar>=transaksi.ongkos||
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
                                                .updateTransaksi(transaksi);
                                            _btnController.success();
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 2), () {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Edit',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )));
              }).then((value) {
            // transaksi=widget.transaksi;
          });
        });
  }
}
