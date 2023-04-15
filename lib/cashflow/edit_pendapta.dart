import 'dart:async';
import 'dart:developer';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/mutasi_child.dart';
import 'package:gabriel_logistik/models/mutasi_saldo.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';

import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/input_currency.dart';

class EditPendaptan extends StatefulWidget {
  final bool pendapatan;
  final MutasiSaldo mutasi;
  const EditPendaptan(this.pendapatan, this.mutasi);

  @override
  State<EditPendaptan> createState() => _EditPendaptanState();
}

class _EditPendaptanState extends State<EditPendaptan> {
  int jumlahOpsi = 1;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
   
    super.initState();
  }

  List<TextEditingController> total = [];

  List<TextEditingController> qty = [];

  List<TextEditingController> harga = [];
  TextEditingController totalMutasi = TextEditingController();
  Widget _buildPartName(int i, BuildContext context) {
    print(i);
    return Container(
        margin: EdgeInsets.only(top: i == 0 ? 5 : 15),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 4,
                        child: SizedBox(
                            height: 36,
                            child: TextFormField(
                              initialValue:
                                  widget.mutasi.listMutasi[i].keterangan,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(fontSize: 13.5),
                              onChanged: (value) {
                                if (widget.mutasi.listMutasi.isNotEmpty) {
                                  widget.mutasi.listMutasi[i].keterangan =
                                      value;
                                }
                              },
                              decoration:
                                  const InputDecoration(hintText: 'Part'),
                            ))),
                    Expanded(
                        flex: 4,
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 13.5),
                            controller: harga[i],
                            decoration:
                                const InputDecoration(hintText: 'Harga'),
                            onChanged: (value) {
                              if (widget.mutasi.listMutasi.isNotEmpty) {
                                widget.mutasi.listMutasi[i].harga =
                                    Rupiah.parse(value).toDouble();
                              total[i].text = Rupiah.format(
                                  widget.mutasi.listMutasi[i].qty *
                                      widget.mutasi.listMutasi[i].harga);
                              }
                              if (widget.mutasi.listMutasi.isNotEmpty) {
                                widget.mutasi.listMutasi[i].total =
                                    widget.mutasi.listMutasi[i].qty *
                                        widget.mutasi.listMutasi[i].harga;
                                double calculateTotalAll = 0;

                                for (var element in widget.mutasi.listMutasi) {
                                  calculateTotalAll += element.total;
                                }
                                totalMutasi.text =
                                    Rupiah.format(calculateTotalAll);
                                widget.mutasi.totalMutasi = calculateTotalAll;
                                print(calculateTotalAll);
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter()
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 13.5),
                            controller: qty[i],
                            decoration: const InputDecoration(hintText: 'Qty'),
                            onChanged: (value) {
                              widget.mutasi.listMutasi[i].qty =
                                  double.parse(value);
                              // qty[i].text = double.parse(value).toString();
                              total[i].text = Rupiah.format(
                                  widget.mutasi.listMutasi[i].qty *
                                      widget.mutasi.listMutasi[i].harga);
                              log('total mas');
                              if (widget.mutasi.listMutasi.isNotEmpty) {
                                widget.mutasi.listMutasi[i].total =
                                    widget.mutasi.listMutasi[i].qty *
                                        widget.mutasi.listMutasi[i].harga;
                                double calculateTotalAll = 0;

                                for (var element in widget.mutasi.listMutasi) {
                                  calculateTotalAll += element.total;
                                }
                                widget.mutasi.totalMutasi = calculateTotalAll;
                                print(calculateTotalAll);
                                totalMutasi.text =
                                    Rupiah.format(calculateTotalAll);
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            readOnly: true,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 13.5),
                            controller: total[i],
                            decoration:
                                const InputDecoration(hintText: 'Total'),
                            onChanged: (value) {},
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter()
                            ],
                          ),
                        )),
                  ],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.green,
            ),
            onPressed: () { jumlahOpsi = widget.mutasi.listMutasi.length;

    totalMutasi.text = Rupiah.format(widget.mutasi.totalMutasi);

    for (var e in widget.mutasi.listMutasi) {
      total.add(
          TextEditingController()..text = Rupiah.format(e.total).toString());
      harga.add(
          TextEditingController()..text = Rupiah.format(e.harga).toString());
      qty.add(TextEditingController()..text = e.qty.toString());
    }
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
                          Text(
                            widget.pendapatan ? 'Uang Masuk' : 'Uang Keluar',
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
                            borderRadius: BorderRadius.circular(3)),
                        child: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) =>
                                  IntrinsicHeight(
                            child: Container(
                              constraints: BoxConstraints(minHeight: 600),
                              padding: const EdgeInsets.only(
                                  bottom: 20, left: 20, right: 20, top: 15),
                              width: MediaQuery.of(context).size.width * 0.52,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      // margin: EdgeInsets.only(bottom: 50),
                                      child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 150,
                                          height: 36,
                                          child: WebDatePicker(
                                            height: 60,
                                            initialDate: DateTime.parse(
                                              widget.mutasi.tanggal,
                                            ),
                                            dateformat: 'dd/MM/yyyy',
                                            onChange: (value) {
                                              if (value != null) {
                                                widget.mutasi.tanggal =
                                                    value.toIso8601String();
                                              }
                                            },
                                          )),
                                      SizedBox(
                                        width: 150,
                                        height: 36,
                                        child: TextFormField(
                                          initialValue:
                                              widget.mutasi.keterangan,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(fontSize: 13.5),
                                          decoration: InputDecoration(
                                              hintText: 'Keterangan'),
                                          onChanged: (v) {
                                            widget.mutasi.keterangan = v;
                                          },
                                        ),
                                      )
                                    ],
                                  )),
                                  const Divider(height: 12),
                                  const Divider(height: 12),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(3),
                                            topRight: Radius.circular(3))),
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      left: 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Deskripsi',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                            )),
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: Text(
                                                  'Harga',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ))),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: Text(
                                                  'Qty',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ))),
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                'Total',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            )),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    child: SingleChildScrollView(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          ...List.generate(
                                            jumlahOpsi,
                                            (index) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                    flex: 15,
                                                    child: _buildPartName(
                                                        index, context)),
                                                Expanded(
                                                  flex: 1,
                                                  child: index == 0
                                                      ? SizedBox()
                                                      : Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                if (jumlahOpsi >
                                                                    1) {
                                                                  widget.mutasi
                                                                      .listMutasi
                                                                      .remove(widget
                                                                          .mutasi
                                                                          .listMutasi[index]);
                                                                  jumlahOpsi =
                                                                      jumlahOpsi -
                                                                          1;
                                                                  total.remove(
                                                                      total[
                                                                          index]);
                                                                  harga.remove(
                                                                      harga[
                                                                          index]);
                                                                  qty.remove(qty[
                                                                      index]);
                                                                  double
                                                                      calculateTotalAll =
                                                                      0;

                                                                  for (var element
                                                                      in widget
                                                                          .mutasi
                                                                          .listMutasi) {
                                                                    calculateTotalAll +=
                                                                        element
                                                                            .total;
                                                                  }
                                                                  totalMutasi
                                                                          .text =
                                                                      Rupiah.format(
                                                                          calculateTotalAll);
                                                                  widget.mutasi
                                                                          .totalMutasi =
                                                                      calculateTotalAll;
                                                                  print(
                                                                      calculateTotalAll);
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              )),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (jumlahOpsi ==
                                                  widget.mutasi.listMutasi
                                                      .length) {
                                                widget.mutasi.listMutasi.add(
                                                  MutasiChild.fromMap({
                                                    'keterangan': '',
                                                    'harga': 0,
                                                    'qty': 1,
                                                    'total': 0
                                                  }),
                                                );

                                                jumlahOpsi = jumlahOpsi + 1;
                                                total.add(
                                                    TextEditingController());
                                                harga.add(
                                                    TextEditingController());
                                                qty.add(
                                                    TextEditingController());
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Colors.green,
                                            size: 25,
                                          )),
                                    ),
                                  ),
                                  const Divider(height: 12),
                                  const Divider(height: 12),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        'Total ' +
                                            (widget.pendapatan
                                                ? "Masuk :"
                                                : "Keluar :"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                          height: 36,
                                          width: 150,
                                          child: TextFormField(
                                            readOnly: true,
                                            textInputAction:
                                                TextInputAction.next,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            controller: totalMutasi,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                fillColor: Colors.white,
                                                hintText: ''),
                                          )),
                                    ],
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: RoundedLoadingButton(
                                      color: Colors.green,
                                      successColor: Colors.green,
                                      errorColor: Colors.red,
                                      child: Text('Tambah',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      controller: _btnController,
                                      onPressed: () async {
                                        bool empty = false;

                                        for (var element
                                            in widget.mutasi.listMutasi) {
                                          if (element.keterangan == '' ||
                                              widget.mutasi.keterangan == '' ||
                                              element.total <= 0) {
                                            empty = true;
                                          }
                                        }
                                        if (empty) {
                                          _btnController.error();
                                          _btnController.reset();
                                          return;
                                        } else {}

                                        await Future.delayed(
                                            Duration(seconds: 3), () {
                                          Provider.of<ProviderData>(context,
                                                  listen: false)
                                              .updateMutasi(widget.mutasi);
                                          _btnController.success();
                                        });
                                        await Future.delayed(
                                            Duration(seconds: 2), () {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).then((value) {
                setState(() {});
              });
            }));
  }
}
