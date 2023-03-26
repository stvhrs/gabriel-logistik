import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/format_tanggal.dart';
import '../helper/input_currency.dart';

class HpTransaksiAdd extends StatefulWidget {


  @override
  State<HpTransaksiAdd> createState() => _HpTransaksiAddState();
}

class _HpTransaksiAddState extends State<HpTransaksiAdd> {
  List<String> listSupir = [];
  List<String> listMobil = [];
  List<Transaksi> bulkTransaksi = [];
  TextEditingController controlerSisa = TextEditingController();
  TextEditingController controlerOngkos = TextEditingController();
  TextEditingController controlerKeluar = TextEditingController();
  TextEditingController controlerSupir = TextEditingController();
  TextEditingController controlerMobil = TextEditingController();
  TextEditingController controlerKeterangan = TextEditingController();
  TextEditingController controlerTujuan = TextEditingController();
  TextEditingController controlerKetMobil = TextEditingController();
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
    List<Mobil> temp=Provider.of<ProviderData>(context, listen: false)
        .listMobil;

        temp.removeWhere((element) => element.terjual);
    temp
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
  late Transaksi transaksi;
  TextStyle small = const TextStyle(fontSize: 7);
  Widget _buildSize(widget, String ket, int flex) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Expanded(
      flex: flex,
      // width: MediaQuery.of(context).size.width * 0.14 * flex,
      // margin: EdgeInsets.only(right: ket == 'Tanggal' ? 0 : 50, bottom: 30),
      child: Container(
        margin: EdgeInsets.only(
            right: ket == 'Keterangan Mobil' || ket == 'Ketik Tujuan' ? 0 : 50,
            bottom: ket == 'Keterangan' ? 20 : 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 7, top: 7),
                child: Row(
                  children: [
                    Text(
                      '$ket :',
                      style: const TextStyle(fontSize: 6),
                    ),
                  ],
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
        margin: const EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton(backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            
            onPressed: () {
              transaksi = Transaksi.fromMap({
               
                'tgl_berangkat': DateTime.now().toIso8601String(),
                'keterangan': '',
                'supir': '',
                'tujuan': '',
                'mobil': '',
                'keluar': 0,
                'ongkos': 0,
                'sisa': 0,
              });
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
                              height: 2000,
                              padding: const EdgeInsets.only(
                                  bottom: 20, left: 20, right: 20, top: 15),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildSize(
                                          WebDatePicker(
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
                                          1),
                                      _buildSize(
                                          DropDownField(
                                            controller: controlerSupir,
                                            onValueChanged: (val) {
                                              transaksi.supir = val;
                                            },
                                            items: listSupir,
                                          ),
                                          'Pilih Supir',
                                          1),
                                      _buildSize(
                                          DropDownField(
                                            controller: controlerMobil,
                                            onValueChanged: (val) {
                                              transaksi.mobil = val;
                                              controlerKetMobil.text = Provider
                                                      .of<ProviderData>(context,
                                                          listen: false)
                                                  .listMobil
                                                  .firstWhere((element) =>
                                                      element.nama_mobil == val)
                                                  .keterangan_mobill;
                                            },
                                            items: listMobil,
                                          ),
                                          'Pilih Mobil',
                                          1),
                                      _buildSize(
                                          TextFormField(
                                            readOnly: true,
                                            controller: controlerKetMobil,
                                            onChanged: (val) {},
                                          ),
                                          'Keterangan Mobil',
                                          1),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      _buildSize(
                                          TextFormField(
                                            controller: controlerOngkos,
                                            onChanged: (va) {
                                              if (va.isNotEmpty &&
                                                  va.startsWith('Rp')) {
                                                transaksi.ongkos =
                                                    Rupiah.parse(va);
                                                if (transaksi.keluar >
                                                    Rupiah.parse(va)) {
                                                  controlerSisa.text =
                                                      'Tidak boleh minus';
                                                } else {
                                                  controlerSisa.text =
                                                      Rupiah.format((transaksi
                                                                  .ongkos -
                                                              transaksi.keluar))
                                                          .toString();
                                                  transaksi.sisa =
                                                      transaksi.ongkos -
                                                          transaksi.keluar;
                                                }
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
                                            controller: controlerKeluar,
                                            onChanged: (va) {
                                              if (va.isNotEmpty &&
                                                  va.startsWith('Rp')) {
                                                transaksi.keluar =
                                                    Rupiah.parse(va);
                                                
                                                if (transaksi.ongkos <
                                                    Rupiah.parse(va)) {
                                                  controlerSisa.text =
                                                      'Tidak boleh minus';
                                                } else {
                                                  transaksi.sisa =
                                                      transaksi.ongkos -
                                                          transaksi.keluar;
                                                  controlerSisa.text =
                                                      Rupiah.format((transaksi
                                                                  .ongkos -
                                                              transaksi.keluar))
                                                          .toString();
                                                }
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
                                            controller: controlerSisa,
                                            readOnly: true,
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
                                          'Sisa',
                                          1),
                                      _buildSize(
                                          TextFormField(
                                            controller: controlerTujuan,
                                            onChanged: (va) {
                                              transaksi.tujuan = va;
                                            },
                                          ),
                                          'Ketik Tujuan',
                                          1),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _buildSize(
                                          TextFormField(
                                              controller: controlerKeterangan,
                                              onChanged: (val) {
                                                transaksi.keterangan = val;
                                              }),
                                          'Keterangan',
                                          2),
                                      const Expanded(flex: 1, child: SizedBox()),
                                     
                                    ],
                                  ),
                                 
                                
                               
                                 RoundedLoadingButton(
                                          color: Colors.green,
                                          elevation: 10,
                                          successColor: Colors.green,
                                          errorColor: Colors.red,
                                          controller: _btnController,
                                          onPressed: () async {
                                            if (bulkTransaksi.isEmpty) {
                                              _btnController.error();
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                              _btnController.reset();
                                              return;
                                            }

                                            await Future.delayed(
                                                const Duration(seconds: 3), () {
                                              for (var element
                                                  in bulkTransaksi) {
                                                Provider.of<ProviderData>(
                                                        context,
                                                        listen: false)
                                                    .addTransaksi(element);
                                              }

                                              _btnController.success();
                                            });
                                            await Future.delayed(
                                                const Duration(seconds: 1), () {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Tambah',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}