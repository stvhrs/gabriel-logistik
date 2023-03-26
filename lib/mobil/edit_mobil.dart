import 'package:flutter/material.dart'; 
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class EditMobil extends StatelessWidget {
  final Mobil mobil;
   EditMobil(this.mobil);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  
  @override
  Widget build(BuildContext context) {


    return IconButton(
      
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                  title: const Text("Edit Mobil"),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(initialValue: mobil.nama_mobil,
                              decoration: const InputDecoration(
                                hintText: 'Nama Mobil',
                              ),
                              onChanged: (val) {
                                mobil.nama_mobil = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(initialValue: mobil.keterangan_mobill,
                              decoration: const InputDecoration(
                                hintText: 'No Hp',
                              ),
                              onChanged: (val) {
                                 mobil.keterangan_mobill = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(bottom: 20),
                          //   child: TextFormField(initialValue: mobil.nama_mobil,
                          //     decoration: const InputDecoration(
                          //       hintText: 'Alamat',
                          //     ),
                          //     onChanged: (val) {
                          //       alamat = val.toString();
                          //     },
                          //     maxLines: 3,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    RoundedLoadingButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 10,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      controller: _btnController,
                      onPressed: () async {
                        if (mobil.nama_mobil.isEmpty ||
                          
                            mobil.keterangan_mobill .isEmpty) {
                          _btnController.error();
                          await Future.delayed(const Duration(seconds: 1));
                          _btnController.reset();
                          return;
                        }

                        await Future.delayed(const Duration(seconds: 3), () {
                          Provider.of<ProviderData>(context, listen: false)
                              .updateMobil(Mobil(false,
                                
                                    mobil.nama_mobil,
                                    mobil.keterangan_mobill,mobil.pengeluaran));
                          _btnController.success();
                        });
                        await Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child:
                          const Text('Edit', style: TextStyle(color: Colors.white)),
                    )
                  ],
                );
              });
        },
        icon: const Icon(Icons.edit,color:      Colors.green,),
        );
  }
}
