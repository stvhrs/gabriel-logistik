import 'package:flutter/material.dart'; import 'package:auto_size_text/auto_size_text.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class TambahMobil extends StatelessWidget {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  TambahMobil({super.key});
  @override
  Widget build(BuildContext context) {
    String namaSupir = '';
    String noHp = '';


    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
               Colors.green)),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                  title: const AutoSizeText(maxLines: 1,"Tambah Mobil"),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Nama Mobil',
                              ),
                              onChanged: (val) {
                                namaSupir = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'No Hp',
                              ),
                              onChanged: (val) {
                                noHp = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(bottom: 20),
                          //   child: TextFormField(
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
                        if (noHp.isEmpty ||
                        
                            namaSupir.isEmpty) {
                          _btnController.error();
                          await Future.delayed(const Duration(seconds: 1));
                          _btnController.reset();
                          return;
                        }

                        await Future.delayed(const Duration(seconds: 3), () {
                          Provider.of<ProviderData>(context, listen: false)
                              .addMobil(Mobil(
                                  Provider.of<ProviderData>(context,
                                              listen: false)
                                          .listMobil
                                          .length +
                                      1,
                                  namaSupir,
                                  noHp));
                          _btnController.success();
                        });
                        await Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });
                      },
                      child:
                          const AutoSizeText(maxLines: 1,'Tambah', style: TextStyle(color: Colors.white)),
                    )
                  ],
                );
              });
        },
        icon: const Icon(Icons.add,color: Colors.white,),
        label: const AutoSizeText(maxLines: 1,'Tambah',style: TextStyle(color: Colors.white),));
  }
}
