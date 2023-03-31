import 'package:flutter/material.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';

import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class PengeluaranDelete extends StatelessWidget {
  final Pengeluaran supir;
  PengeluaranDelete(this.supir);
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
                title: const Text("Delete"),
                content: IntrinsicHeight(
                  child: SizedBox(
                    width: 500,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text('Apakah Anda Yakin ?'),
                    ),
                  ),

                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 20),
                  //   child: TextFormField(textInputAction: TextInputAction.next,initialValue: Transaksi.nama_Transaksi,
                  //     decoration: const InputDecoration(
                  //       hintText: 'Alamat',
                  //     ),
                  //     onChanged: (val) {
                  //       alamat = val.toString();
                  //     },
                  //     maxLines: 3,
                  //   ),
                  // )
                ),
                actions: <Widget>[
                  RoundedLoadingButton(
                    color: Colors.red,
                    elevation: 10,
                    successColor: Colors.green,
                    errorColor: Colors.red,
                    controller: _btnController,
                    onPressed: () async {
                      if (false)
                       {
                        _btnController.error();
                        await Future.delayed(const Duration(seconds: 1));
                        _btnController.reset();
                        return;
                      }


                      await Future.delayed(const Duration(seconds: 3), () {
                        Provider.of<ProviderData>(context, listen: false)
                            .deletePengeluaran(supir);
                        _btnController.success();
                      });
                      await Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              );
            });
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
