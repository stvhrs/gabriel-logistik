import 'package:flutter/material.dart'; 
import 'package:gabriel_logistik/models/supir.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class TambahSupir extends StatelessWidget {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  TambahSupir({super.key});
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
                  title: const Text("Tambah Supir",),
                  content: IntrinsicHeight(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Nama Supir',
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
                              .addSupir(Supir(
                                  Provider.of<ProviderData>(context,
                                              listen: false)
                                          .listSupir
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
                          const Text('Tambah', style: TextStyle(color: Colors.white)),
                    )
                  ],
                );
              });
        },
        icon: const Icon(Icons.add,color: Colors.white,),
        label: const Text('Tambah',style: TextStyle(color: Colors.white),));
  }
}
