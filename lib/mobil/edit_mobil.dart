import 'package:flutter/material.dart'; import 'package:auto_size_text/auto_size_text.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class EditMobil extends StatelessWidget {
  final Mobil supir;
   EditMobil(this.supir);
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
                  title: const AutoSizeText(maxLines: 1,"Edit Mobil"),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(initialValue: supir.nama_mobil,
                              decoration: const InputDecoration(
                                hintText: 'Nama Mobil',
                              ),
                              onChanged: (val) {
                                supir.nama_mobil = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(initialValue: supir.nopol_mobil,
                              decoration: const InputDecoration(
                                hintText: 'No Hp',
                              ),
                              onChanged: (val) {
                                 supir.nopol_mobil = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(bottom: 20),
                          //   child: TextFormField(initialValue: supir.nama_mobil,
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
                        if (supir.nama_mobil.isEmpty ||
                          
                            supir.nopol_mobil .isEmpty) {
                          _btnController.error();
                          await Future.delayed(const Duration(seconds: 1));
                          _btnController.reset();
                          return;
                        }

                        await Future.delayed(const Duration(seconds: 3), () {
                          Provider.of<ProviderData>(context, listen: false)
                              .updateSupir(Supir(
                                 supir.id_mobil,
                                    supir.nama_mobil,
                                    supir.nama_mobil));
                          _btnController.success();
                        });
                        await Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child:
                          const AutoSizeText(maxLines: 1,'Edit', style: TextStyle(color: Colors.white)),
                    )
                  ],
                );
              });
        },
        icon: const Icon(Icons.edit,color:      Colors.green,),
        );
  }
}
