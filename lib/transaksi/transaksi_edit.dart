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
import '../models/mobil.dart';

class TransaksiEdit extends StatefulWidget {
  Transaksi transaksi;
  TransaksiEdit(this.transaksi);

  @override
  State<TransaksiEdit> createState() => _TransaksiEditState();
}

class _TransaksiEditState extends State<TransaksiEdit> {
  List<String> listSupir = [];
  List<String> listMobil = [];
  TextEditingController controlerSisa = TextEditingController();
  TextEditingController controlerKetMobil = TextEditingController();

  @override
  void initState() {

    transaksi=widget.transaksi;
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
      controlerKetMobil.text=temp.firstWhere((element) => element.nama_mobil==widget.transaksi.mobil).nama_mobil;
      controlerSisa.text=widget.transaksi.sisa.toString();
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
  Widget _buildSize(widget, String ket, int flex) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Expanded(
      // width: MediaQuery.of(context).size.width * 0.14 * flex,
      // margin: EdgeInsets.only(right: ket == 'Tanggal' ? 0 : 50, bottom: 30),
      child: Container(
        margin: EdgeInsets.only(
            right: ket == 'Keterangan Mobil' || ket == 'Ketik Tujuan' ? 0 : 50,
            bottom: ket == 'Keterangan' ? 40 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 7, top: 7),
                child: Row(
                  children: [
                    Text(
                      '$ket :',
                      style: const TextStyle(fontSize: 13),
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
    return IconButton(
       
            icon: const Icon(
              Icons.edit,
              color: Colors.green),
            
           
          
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
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildSize(
                                              WebDatePicker(
                                                height: 60,
                                                initialDate:DateTime.parse(widget.transaksi.tanggalBerangkat) ,
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
                                              DropDownField(value: widget.transaksi.supir,
                                                onValueChanged: (val) {
                                                  transaksi.supir = val;
                                                },
                                                items: listSupir,
                                              ),
                                              'Pilih Supir',
                                              1),
                                          _buildSize(
                                              DropDownField(value: widget.transaksi.mobil,
                                                onValueChanged: (val) {
                                                  transaksi.mobil = val;
                                                  controlerKetMobil
                                                      .text = Provider.of<
                                                              ProviderData>(
                                                          context,
                                                          listen: false)
                                                      .listMobil
                                                      .firstWhere((element) =>
                                                          element.nama_mobil ==
                                                          val)
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
                                              TextFormField(initialValue:Rupiah.format(widget.transaksi.ongkos) ,
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
                                                      controlerSisa
                                                          .text = Rupiah.format(
                                                              (transaksi
                                                                      .ongkos -
                                                                  transaksi
                                                                      .keluar))
                                                          .toString();
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
                                              TextFormField(initialValue: Rupiah.format(widget.transaksi.keluar),
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
                                                      controlerSisa
                                                          .text = Rupiah.format(
                                                              (transaksi
                                                                      .ongkos -
                                                                  transaksi
                                                                      .keluar))
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
                                          _buildSize(TextFormField(initialValue: widget.transaksi.tujuan,
                                            onChanged: (va) {
                                              transaksi.tujuan = va;
                                            },
                                          ), 'Ketik Tujuan', 1),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          _buildSize(
                                              TextFormField(initialValue: widget.transaksi.keterangan,onChanged: (val) {
                                            transaksi.keterangan = val;
                                          }), 'Keterangan', 2),
                                          _buildSize(const SizedBox(), '', 4),
                                          //                               ElevatedButton.icon(
                                          // icon: const Icon(
                                          //   Icons.add,
                                          //   color: Colors.white,
                                          // ),
                                          // label: const Text(
                                          //   'Masuk Ringkasan',
                                          //   style: TextStyle(color: Colors.white),
                                          // ),
                                          // style: ButtonStyle(
                                          //     padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
                                          // onPressed: () {})
                                        ],
                                      ),
                                      RoundedLoadingButton(
                                        color:Colors.green,
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
                                                .updateTransaksi(transaksi);
                                            _btnController.success();
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 1), () {
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
                        ));
                  });
            });
  }
}
