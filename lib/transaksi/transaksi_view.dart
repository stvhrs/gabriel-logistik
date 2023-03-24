import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';
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

class TransaksiView extends StatefulWidget {
  final Transaksi _transaksi;

  const TransaksiView(
    this._transaksi,
  );

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
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
    transaksi = widget._transaksi;
    super.initState();
  }

  int jumlahOpsi = 0;

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

  Widget _buildSize2(widget, int flex, bool ket) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.14 * flex,
        margin: EdgeInsets.only(right: ket ? 10 : 50, bottom: 10),
        child: widget);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.remove_red_eye_sharp,
        color: Colors.grey.shade700,
      ),
      onPressed: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Theme(
                  data: ThemeData(
                    fontFamily: 'Nunito',
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                          letterSpacing: 0.7),
                      contentPadding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade800),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade800),
                      ),
                    ),
                  ),
                  child: AlertDialog(
                      backgroundColor: Colors.grey.shade800,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          const Text(
                            'Lihat Transaksi',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                enabled: false,
                                                items: const [],
                                              ),
                                              'Pilih Supir',
                                              1),
                                          _buildSize(
                                              DropDownField(
                                                value: transaksi.mobil,
                                                enabled: false,
                                                items: const [],
                                              ),
                                              'Pilih Mobil',
                                              1),
                                          _buildSize(
                                              TextFormField(
                                                initialValue: transaksi.tujuan,
                                                readOnly: true,
                                                onChanged: (va) {
                                                  transaksi.tujuan = va;
                                                },
                                              ),
                                              'Ketik Tujuan',
                                              1),
                                          _buildSizeV2(
                                            WebDatePicker(
                                              initialDate: DateTime.parse(
                                                  transaksi.tanggalBerangkat),
                                              height: 60,
                                              width: double.infinity,
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
                                                  transaksi.ongkos),
                                              readOnly: true,
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
                                              initialValue: Rupiah.format(
                                                  transaksi.keluar),
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
                                            'Biaya Keluar',
                                            1),
                                        _buildSizeV2(
                                          TextFormField(
                                              initialValue:
                                                  transaksi.keterangan,
                                              readOnly: true,
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )));
            }).then((value) {});
      },
    );
  }
}
