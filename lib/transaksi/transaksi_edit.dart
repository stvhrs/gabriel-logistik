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



  Widget _buildPartName(int i, BuildContext context,StateSetter stateSetter ) {
    print(i);
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSize2(
                        TextFormField(
                          initialValue: transaksi.listPerbaikan[i].nama_perbaikan,
                          onChanged: (value) {
                            if (transaksi.listPerbaikan.isNotEmpty) {
                              transaksi.listPerbaikan[i].nama_perbaikan = value;
                            }
                          },
                          decoration: const InputDecoration(hintText: 'Part'),
                        ),
                        1),
                    _buildSize2(
                        TextFormField(
                          initialValue: Rupiah.format(
                              transaksi.listPerbaikan[i].harga_perbaikan),
                          decoration: const InputDecoration(hintText: 'Harga'),
                          onChanged: (value) {
                            if (transaksi.listPerbaikan.isNotEmpty) {
                              transaksi.listPerbaikan[i].harga_perbaikan =
                                  NumberFormat.currency(
                                          locale: 'id_ID', symbol: 'Rp ')
                                      .parse(value)
                                      .toDouble();
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CurrencyInputFormatter()
                          ],
                        ),
                        1),
                    IconButton(
                      onPressed: () {
 transaksi.listPerbaikan.removeAt(i);
           stateSetter((){});


                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    Expanded(flex: 2, child: SizedBox())
                  ],
                ));
  }

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

  Widget _buildSize2(widget, int flex) {
    return Flexible(
      flex: flex,
      child: Container(
          margin: EdgeInsets.only(right: 70, bottom: 15), child: widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    transaksi.transaksiId = Provider.of<ProviderData>(context, listen: false)
            .backupTransaksi
            .length +
        1;
    return InkWell(
        child: Icon(
          Icons.edit,
          color: Colors.green,
          size: 18,
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
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.green),
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
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20, top: 15),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [ Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text('Tambah Perbaikan'),
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
                                              icon: const Icon(Icons.add)),
                                               IconButton(
                                              onPressed: () {
                                          setState(() {
                                             transaksi.listPerbaikan
                                                      .remove(transaksi.listPerbaikan[transaksi.listPerbaikan.length-1]);
                                          });
                                                  
                                                
                                              },
                                              icon: const Icon(Icons.car_crash)),Text(transaksi.listPerbaikan.length.toString())
                                          // Text(jumlahOpsi.toString()),
                                        ],
                                      ),
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
                                      const Text(
                                        'Perbaikan :',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      const Divider(),
                                     
                                          ...transaksi.listPerbaikan.map((e) => _buildPartName(transaksi.listPerbaikan.indexOf(e), context, setState
                                          )).toList(),
                                         
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text('Tambah Perbaikan'),
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
                                              icon: const Icon(Icons.add)),
                                               IconButton(
                                              onPressed: () {
                                          setState(() {
                                             transaksi.listPerbaikan
                                                      .remove(transaksi.listPerbaikan[transaksi.listPerbaikan.length-1]);
                                          });
                                                  
                                                
                                              },
                                              icon: const Icon(Icons.car_crash)),Text(transaksi.listPerbaikan.length.toString())
                                          // Text(jumlahOpsi.toString()),
                                        ],
                                      ),
                                      RoundedLoadingButton(
                                        color: Theme.of(context).primaryColor,
                                        successColor: Colors.green,
                                        errorColor: Colors.red,
                                        child: Text('Edit',
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
                                                .updateTransaksi(transaksi);
                                            _btnController.success();
                                          });
                                          await Future.delayed(
                                              Duration(seconds: 2), () {
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
                        )));
              }).then((value) {
            // transaksi=widget.transaksi;
          });
        });
  }
}
