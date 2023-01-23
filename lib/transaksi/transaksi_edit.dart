import 'dart:async';

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
    List<Supir> _listSupir =
        Provider.of<ProviderData>(context, listen: false).listSupir;
    List<Mobil> _listMobil =
        Provider.of<ProviderData>(context, listen: false).listMobil;

    _listSupir.map((e) => e.nama_supir).toList().forEach((element) {
      if (listSupir.contains(element)) {
      } else {
        listSupir.add(element);
      }
    });
    _listMobil.map((e) => e.nama_mobil).toList().forEach((element) {
      print(element);
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });

    super.initState();
  }

  int jumlahOpsi = 0;

  final List<Transaksi> _updatedTransaksi = [];
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Widget _buildPartName(int i, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: 'Part'),
                        )),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'Harga'),
                        onChanged: (value) {
                          if (_updatedTransaksi.isNotEmpty) {
                            _updatedTransaksi[i]
                                .listPerbaikan[jumlahOpsi]
                                .harga_perbaikan = NumberFormat.currency(
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
                    ),
                  ],
                )));
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton(
            child: const Icon(Icons.add),
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
                                                  onValueChanged: (val) {},
                                                  items: listSupir,
                                                ),
                                                'Pilih Supir',
                                                200),
                                            _buildSize(
                                                DropDownField(
                                                  onValueChanged: (val) {},
                                                  items: listMobil,
                                                ),
                                                'Pilih Mobil',
                                                200),
                                            _buildSize(TextFormField(),
                                                'Ketik Tujuan', 200),
                                            const Spacer(),
                                            _buildSize(
                                                WebDatePicker(
                                                  height: 60,
                                                  initialDate: DateTime.now(),
                                                  dateformat: 'dd/MM/yyyy',
                                                  onChange: (value) {},
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
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  CurrencyInputFormatter()
                                                ],
                                              ),
                                              'Biaya Ongkos',
                                              200),
                                          _buildSize(TextFormField(),
                                              'Keterangan', 400),
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
                                      //                   'totalCost': 400,
                                      //                   'perbaikan_transaksi':
                                      //                       []
                                      //                 },
                                      //               ));

                                      //               jumlahOpsi = jumlahOpsi + 1;
                                      //             }
                                      //           });
                                      //         },
                                      //         icon: const Icon(Icons.add)),
                                      //     // Text(jumlahOpsi.toString()),
                                      //   ],
                                      // ),

                                      RoundedLoadingButton(color: Theme.of(context).primaryColor,successColor: Colors.green,errorColor: Colors.red,
                                        child: Text('Tambah',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        controller: _btnController,
                                        onPressed: () async {
                                          await Future.delayed(
                                              Duration(seconds: 3), () {
                                            Provider.of<ProviderData>(context,
                                                    listen: false)
                                                .addTransaksi(Transaksi(
                                                    Provider.of<ProviderData>(
                                                            context,
                                                            listen: false)
                                                        .listTransaksi
                                                        .length,
                                                    DateTime.now()
                                                        .toIso8601String(),'keterabgan',
                                                    'supir',
                                                    'mobil',
                                                    'tujuan',
                                                    5,
                                                    5,
                                                    []));
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
