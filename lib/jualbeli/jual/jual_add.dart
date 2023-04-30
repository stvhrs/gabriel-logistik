import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';

import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/mobil.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../../helper/dropdown.dart';
import '../../helper/input_currency.dart';
import '../../services/service.dart';

class JualAdd extends StatefulWidget {
  @override
  State<JualAdd> createState() => _JualAddState();
}

class _JualAddState extends State<JualAdd> {
  List<String> listMobil = [];

  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false)
        .listMobil
        .where((element) => element.terjual == false)
        .map((e) => e.nama_mobil)
        .toList()
        .forEach((element) {
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });

    super.initState();
  }

  TextEditingController controlerKetMobil = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late JualBeliMobil jualBeliMobil;
  TextStyle small = const TextStyle(fontSize: 13.5);
  Widget _buildSize(widget, String ket, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.14 * flex,
        margin: EdgeInsets.only(
            left: ket == 'Tanggal' || ket == 'Keterangan' ? 0 : 50, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 7, top: 7),
                child: Row(
                  children: [
                    Text(
                      '$ket :',
                      style: const TextStyle(fontSize: 13.5),
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
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
        onPressed: () {
          jualBeliMobil = JualBeliMobil.fromMap({
            'id_jb': '0',
            'id_mobil': '0',
            'plat_mobil': '0',
            'ket_mobil': '0',
            'harga_jb': "0",
            'tgl_jb': DateTime.now().toIso8601String(),
            'beli_jb': "false",
            'ket_jb': 'keterangan'
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
                          'Jual Mobil',
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSize(
                                        WebDatePicker(
                                          lastDate: DateTime.now(),
                                          height: 60,
                                          initialDate: DateTime.now(),
                                          dateformat: 'dd/MM/yyyy',
                                          onChange: (value) {
                                            if (value != null) {
                                              jualBeliMobil.tanggal =
                                                  value.toIso8601String();
                                            }
                                          },
                                        ),
                                        'Tanggal',
                                        1),
                                    _buildSize(
                                        DropDownField(
                                          onValueChanged: (val) {
                                            jualBeliMobil.mobil = val;
                                            controlerKetMobil.text = Provider
                                                    .of<ProviderData>(context,
                                                        listen: false)
                                                .listMobil
                                                .firstWhere((element) =>
                                                    element.nama_mobil == val)
                                                .keterangan_mobill;
                                                jualBeliMobil.id_mobil=Provider.of<ProviderData>(context,listen: false).listMobil.where((element) => element.terjual==false) .firstWhere((element) => element.nama_mobil==val).id;
                                          },
                                          items: listMobil,
                                        ),
                                        'Pilih Mobil',
                                        1),
                                    _buildSize(
                                        TextFormField(
                                          style: const TextStyle(fontSize: 13),
                                          textInputAction: TextInputAction.next,
                                          readOnly: true,
                                          controller: controlerKetMobil,
                                          onChanged: (va) {
                                            jualBeliMobil.ketMobil = va;
                                          },
                                        ),
                                        'Keterangan Mobil',
                                        1),
                                    _buildSize(
                                        TextFormField(
                                          style: const TextStyle(fontSize: 13),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (va) {
                                            jualBeliMobil.harga =
                                                Rupiah.parse(va);
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CurrencyInputFormatter()
                                          ],
                                        ),
                                        'Harga',
                                        1),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _buildSize(
                                        TextFormField(
                                          style: const TextStyle(fontSize: 13),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (va) {
                                            jualBeliMobil.keterangan = va;
                                          },
                                        ),
                                        'Keterangan',
                                        2),
                                  ],
                                ),
                                RoundedLoadingButton(
                                  color: Colors.red,
                                  elevation: 10,
                                  successColor: Colors.green,
                                  errorColor: Colors.red,
                                  controller: _btnController,
                                  onPressed: () async {
                                    if (jualBeliMobil.harga == 0 ||
                                        jualBeliMobil.tanggal.isEmpty ||
                                        jualBeliMobil.mobil.isEmpty) {
                                      _btnController.error();
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      _btnController.reset();
                                      return;
                                    }
                                    var data = await Service.postJB({
                                      "id_jb":jualBeliMobil.id,
                                      "id_mobil":jualBeliMobil.id_mobil,
                                      'plat_mobil': jualBeliMobil.mobil,
                                      'ket_mobil': jualBeliMobil.ketMobil,
                                      'harga_jb':
                                          jualBeliMobil.harga.toString(),
                                      'tgl_jb': jualBeliMobil.tanggal,
                                      'beli_jb': "false",
                                      'ket_jb': jualBeliMobil.ketMobil
                                    });

                                    if (data != null) {
                                      Provider.of<ProviderData>(context,
                                              listen: false)
                                          .updateMobil(Mobil.fromMap({
                                        'id_mobil': data.id_mobil,
                                        'plat_mobil': data.mobil,
                                        "ket_mobil": data.ketMobil,
                                        "terjual": "true"
                                      }, []));

                                      Provider.of<ProviderData>(context,
                                              listen: false)
                                          .addJualBeliMobil(data);
                                    } else {
                                      _btnController.error();
                                      await Future.delayed(
                                          const Duration(seconds: 1), () {});
                                      _btnController.reset();
                                      return;
                                    }

                                    _btnController.success();

                                    await Future.delayed(
                                        const Duration(seconds: 1), () {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const Text('Jual',
                                      style: TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              });
        },
        child: const Text(
          'Jual',
          style: TextStyle(color: Colors.white),
        ));
  }
}
