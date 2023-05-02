import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/input_currency.dart';
import '../models/mobil.dart';

class AdministrasiAdd extends StatefulWidget {
  @override
  State<AdministrasiAdd> createState() => _AdministrasiAddState();
}

class _AdministrasiAddState extends State<AdministrasiAdd> {
  List<String> listMobil = [];

  @override
  void initState() {
    List<Mobil> temp = Provider.of<ProviderData>(context, listen: false)
        .listMobil
        .where((element) => element.terjual == false)
        .toList();

    temp.map((e) => e.nama_mobil).toList().forEach((element) {
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });

    super.initState();
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Perbaikan perbaikan;
  TextStyle small = const TextStyle(fontSize: 13.5);
  Widget _buildSize(widget, String ket, int flex) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.14,
      // margin: EdgeInsets.only(left: ket=='Tanggal'||ket=='Keterangan'?0: 50, bottom: 30),
      child: Container(
          margin: const EdgeInsets.only(bottom: 7, top: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$ket :',
                  style: const TextStyle(fontSize: 13.5),
                ),
              ),
              Expanded(flex: 2, child: widget),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Tambah Administrasi',
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
        onPressed: () {
          perbaikan = Perbaikan.fromMap({
            "id_perbaikan": "0",
            "id_mobil": "0",
            "plat_mobil": "ll",
            "jenis_p": "test",
            "harga_p": "0",
            "ket_p": "test",
            "tgl_p": DateTime.now().toIso8601String(),
             "administrasi":"true"
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
                          'Tambah Administrasi',
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            child:  SingleChildScrollView(
                              child: Column(
                                children: [
                                  _buildSize(
                                      WebDatePicker(
                                        lastDate: DateTime.now(),
                                        height: 60,
                                        initialDate: DateTime.now(),
                                        dateformat: 'dd/MM/yyyy',
                                        onChange: (value) {
                                          if (value != null) {
                                            perbaikan.tanggal =
                                                value.toIso8601String();
                                          }
                                        },
                                      ),
                                      'Tanggal',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (va) {
                                          perbaikan.jenis = va;
                                        },
                                      ),
                                      'Jenis Administrasi',
                                      1),
                                  _buildSize(
                                      DropDownField(
                                        onValueChanged: (val) {
                                          perbaikan.mobil = val;
                                          perbaikan.id_mobil =
                                              Provider.of<ProviderData>(context,
                                                      listen: false)
                                                  .listMobil
                                                  .firstWhere((element) =>
                                                      element.nama_mobil == val)
                                                  .id;
                                        },
                                        items: listMobil,
                                      ),
                                      'Pilih Mobil',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (va) {
                                          perbaikan.harga = Rupiah.parse(va);
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyInputFormatter()
                                        ],
                                      ),
                                      'Nomnial Administrasi',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (va) {
                                          perbaikan.keterangan = va;
                                        },
                                      ),
                                      'Keterangan',
                                      2),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RoundedLoadingButton(
                                      color: Colors.green,
                                      elevation: 10,
                                      successColor: Colors.green,
                                      errorColor: Colors.red,
                                      controller: _btnController,
                                      onPressed: () async {
                                        if (perbaikan.harga == 0 ||
                                            perbaikan.jenis.isEmpty ||
                                            perbaikan.mobil.isEmpty) {
                                          _btnController.error();
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          _btnController.reset();
                                          return;
                                        }
                            
                                        var data = await Service.postPerbaikan({
                                          "id_mobil": perbaikan.id_mobil,
                                          "plat_mobil": perbaikan.mobil,
                                          "ket_mobil": perbaikan.keterangan,
                                          "jenis_p": perbaikan.jenis,
                                          "harga_p": perbaikan.harga.toString(),
                                          "ket_p": perbaikan.keterangan,
                                          "tgl_p": perbaikan.tanggal,
                                           "administrasi":"true"
                                        });
                            
                                        if (data != null) {
                                          Provider.of<ProviderData>(context,
                                                  listen: false)
                                              .addPerbaikan(data);
                                        } else {
                                          _btnController.error();
                                        }
                            
                                        _btnController.success();
                            
                                        await Future.delayed(
                                            const Duration(seconds: 1), () {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: const Text('Tambah',
                                          style: TextStyle(color: Colors.white)),
                                    ),
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
