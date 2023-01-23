import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gabriel_logistik/transaksi/transaksi_edit.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/format_tanggal.dart';
import '../helper/input_currency.dart';

class TransaksiTile extends StatefulWidget {
  final Transaksi _transaksi;
  final int index;

  const TransaksiTile(this._transaksi, this.index);

  @override
  State<TransaksiTile> createState() => _TransaksiTileState();
}

class _TransaksiTileState extends State<TransaksiTile> {
  totalPerbaikan(List<Perbaikan> data) {
    double totalHarga = 0;
    for (var element in data) {
      totalHarga = totalHarga + element.harga_perbaikan;
    }
    return totalHarga;
  }

  List<String> listSupir = [];
  List<String> listMobil = [];

  @override
  void initState() {
    jumlahOpsi=widget._transaksi.listPerbaikan.length;
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
    transaksi = widget._transaksi;
    super.initState();
  }

  int jumlahOpsi = 0;

  final List<Perbaikan> _updatedPerbaikan = [];
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
                          onChanged: (value) {
                            if (_updatedPerbaikan.isNotEmpty) {
                              _updatedPerbaikan[i].nama_perbaikan = value;
                            }
                          },
                          decoration: const InputDecoration(hintText: 'Part'),
                        )),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'Harga'),
                        onChanged: (value) {
                          if (_updatedPerbaikan.isNotEmpty) {
                            _updatedPerbaikan[i].harga_perbaikan =
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

  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                  backgroundColor: Colors.grey.shade600,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      const Text(
                        'Detail Transaksi',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  content: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          IntrinsicHeight(
                        child: Container(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20, top: 15),
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
                                                transaksi.tanggalBerangkat =
                                                    value.toIso8601String();
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
                                    _buildSize(TextFormField(onChanged: (val) {
                                      transaksi.keterangan = val;
                                    }), 'Keterangan', 400),
                                  ],
                                ),
                                widget._transaksi.listPerbaikan.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Perbaikan :',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          const Divider(),
                                          ...List.generate(
                                              jumlahOpsi,
                                              (index) => _buildPartName(
                                                  index, context)),
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            });
      },
      onHover: (v) {
        hover = v;
        setState(() {});
      },
      child: Container(
        color: hover
            ? Colors.amber.shade100
            : widget.index.isEven
                ? const Color.fromARGB(255, 181, 212, 238)
                : Colors.grey.shade200,
        padding:
            const EdgeInsets.only(top: 14, bottom: 14, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  ' ${widget.index}',
                )),
            Expanded(
                flex: 7,
                child: Text(FormatTanggal.formatTanggal(
                    widget._transaksi.tanggalBerangkat))),
            Expanded(flex: 5, child: Text(widget._transaksi.supir)),
            Expanded(flex: 7, child: Text(widget._transaksi.mobil)),
            Expanded(flex: 10, child: Text(widget._transaksi.tujuan)),
            Expanded(
                flex: 7, child: Text(Rupiah.format(widget._transaksi.keluar))),
            Expanded(
                flex: 7, child: Text(Rupiah.format(widget._transaksi.ongkos))),
            Expanded(
                flex: 7,
                child: Text(widget._transaksi.listPerbaikan.isEmpty
                    ? '-'
                    : Rupiah.format(
                        totalPerbaikan(widget._transaksi.listPerbaikan)))),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // EditPelanggan(c.listSupir[index]),
                  const Spacer(),
                  TransaksiEdit(transaksi: widget._transaksi),
                  const Spacer(),
                  Icon(
                    Icons.delete,
                    size: 18,
                    color: Colors.red.shade700,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
