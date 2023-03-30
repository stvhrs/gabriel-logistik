import 'package:flutter/material.dart';
import 'package:gabriel_logistik/models/supir.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class EditSupir extends StatelessWidget {
  final Supir supir;
  EditSupir(this.supir);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                title:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Edit Supir"), Padding(
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
                                    
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                  ],
                ),
                content: IntrinsicHeight(
                  child: SizedBox(
                    width: 500,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            initialValue: supir.nama_supir,
                            decoration: const InputDecoration(
                              hintText: 'Nama Supir',
                            ),
                            onChanged: (val) {
                              supir.nama_supir = val.toString();
                            },
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            initialValue: supir.nohp_supir,
                            decoration: const InputDecoration(
                              hintText: 'No Hp',
                            ),
                            onChanged: (val) {
                              supir.nohp_supir = val.toString();
                            },
                            maxLines: 1,
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(bottom: 20),
                        //   child: TextFormField(initialValue: supir.nama_supir,
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
                      if (supir.nama_supir.isEmpty ||
                          supir.nohp_supir.isEmpty) {
                        _btnController.error();
                        await Future.delayed(const Duration(seconds: 1));
                        _btnController.reset();
                        return;
                      }

                      await Future.delayed(const Duration(seconds: 3), () {
                        Provider.of<ProviderData>(context, listen: false)
                            .updateSupir(Supir( supir.nama_supir,
                                supir.nohp_supir));
                        _btnController.success();
                      });
                      await Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Edit',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              );
            });
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.green,
      ),
    );
  }
}
