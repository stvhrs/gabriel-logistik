import 'dart:async';

import 'package:gabriel_logistik/helper/rupiah_format.dart';

import 'package:gabriel_logistik/models/jual_beli_mobil.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../../helper/input_currency.dart';

class JualEdit extends StatefulWidget {
  final JualBeliMobil jualBeliMobil;
  const JualEdit(this.jualBeliMobil);
  @override
  State<JualEdit> createState() => _JualEditState();
}

class _JualEditState extends State<JualEdit> {
  List<String> listMobil = [];

  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false)
       .listMobil.where((element) => element.terjual==false)
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
 
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
 
  TextStyle small = const TextStyle(fontSize: 13.5);
  Widget _buildSize(widget, String ket, int flex) {

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
    return IconButton(
    
        icon:const Icon(Icons.edit,color: Colors.green,),
        
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
                                             WebDatePicker(lastDate: DateTime.now(),
                                          height: 60,
                                          initialDate:DateTime.parse(widget.jualBeliMobil.tanggal) ,
                                          dateformat: 'dd/MM/yyyy',
                                          onChange: (value) {
                                            if (value != null) {
                                              widget.jualBeliMobil.tanggal =
                                                  value.toIso8601String();
                                            }
                                          },
                                        ),
                                        'Tanggal',
                                        1),
                                  
                                    _buildSize(
                                        TextFormField(initialValue: widget.jualBeliMobil.mobil,enabled: false,
                                          onChanged: (val) {
                                            widget.jualBeliMobil.mobil = val;
                                            
                                          },
                                       
                                        ),
                                        'Pilih Mobil',
                                        1),  _buildSize(
                                        TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly: true,initialValue: widget.jualBeliMobil.ketMobil,
                                          onChanged: (va) {
                                            widget.jualBeliMobil.ketMobil=va;
                                          },
                                        ),
                                        'Keterangan Mobil',
                                        1),
                                    _buildSize(
                                        TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,initialValue:Rupiah.format( widget.jualBeliMobil.harga),
                                          onChanged: (va) {
                                            widget.jualBeliMobil.harga=Rupiah.parse(va);
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
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,initialValue: widget.jualBeliMobil.keterangan,
                                          onChanged: (va) {
                                            widget.jualBeliMobil.keterangan=va;
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
                                            if (widget.jualBeliMobil.harga==0||widget.jualBeliMobil.tanggal.isEmpty||widget.jualBeliMobil.mobil.isEmpty) {
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
                                                  .updateJualBeliMobil(widget.jualBeliMobil);
                                              
 
                                              _btnController.success();
                                            });
                                            await Future.delayed(
                                                const Duration(seconds: 1), () {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: const Text('Edit',
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
        });
  }
}
