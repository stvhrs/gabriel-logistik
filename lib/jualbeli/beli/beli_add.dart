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

import '../../helper/input_currency.dart';

class BeliAdd extends StatefulWidget {

  @override
  State<BeliAdd> createState() => _BeliAddState();
}

class _BeliAddState extends State<BeliAdd> {
 
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late JualBeliMobil jualBeliMobil;
  TextStyle small = const TextStyle(fontSize: 13);
  Widget _buildSize(widget, String ket, int flex) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Expanded(
      flex: flex,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.14 * flex,
        margin: EdgeInsets.only(left: ket=='Tanggal'||ket=='Keterangan'?0: 50, bottom: 30),
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
    return ElevatedButton(
      
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
        onPressed: () {
          jualBeliMobil = JualBeliMobil.fromMap( {
    'nama_mobil': '', 'ket_mobil':'',
    'harga': 0,
   
    'beli': true,
    'keterangan': '',
    'tanggal': DateTime.now().toIso8601String()
  },);

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
                          'Beli Mobil',
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
                                        TextFormField(
                                          onChanged: (va) {
                                            jualBeliMobil.mobil=va;
                                          },
                                        ),
                                        'Mobil',
                                        1),
                                          _buildSize(
                                        TextFormField(
                                          onChanged: (va) {
                                            jualBeliMobil.ketMobil=va;
                                          },
                                        ),
                                        'Keterangan Mobil',
                                        1),
                                    
                                    _buildSize(
                                        TextFormField(
                                          onChanged: (va) {
                                            jualBeliMobil.harga=Rupiah.parse(va);
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
                                          onChanged: (va) {
                                            jualBeliMobil.keterangan=va;
                                          },
                                        ),
                                        'Keterangan',
                                        2),
                                  ],
                                ),RoundedLoadingButton(
                                          color:Colors.green,
                                          elevation: 10,
                                          successColor: Colors.green,
                                          errorColor: Colors.red,
                                          controller: _btnController,
                                          onPressed: () async {
                                            if (jualBeliMobil.harga==0||jualBeliMobil.tanggal.isEmpty||jualBeliMobil.mobil.isEmpty) {
                                              _btnController.error();
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                              _btnController.reset();
                                              return;
                                            }

                                            await Future.delayed(
                                                const Duration(seconds: 3), () {
                                            
                                                Provider.of<ProviderData>(
                                                        context,
                                                        listen: false)
                                                    .addJualBeliMobil(jualBeliMobil);
                                                    Provider.of<ProviderData>(
                                                        context,
                                                        listen: false)
                                                    .addMobil(Mobil(false,jualBeliMobil.mobil, jualBeliMobil.ketMobil, [  ]));
                                              

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
                    ));
              });
        },
      
        child: const Text(
          'Beli',
          style: TextStyle(color: Colors.white),
        ));
  }
}