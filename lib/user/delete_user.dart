import 'package:flutter/material.dart';

import 'package:gabriel_logistik/models/user.dart';
import 'package:gabriel_logistik/services/service.dart';

import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class UserDelete extends StatelessWidget {
  final User user;
  UserDelete(this.user);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Delete"),
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
                              color: Colors.red,
                            ),
                          )),
                    ),
                  ],
                ),
                content: IntrinsicHeight(
                  child: SizedBox(
                    width: 500,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text('Apakah Anda Yakin ?'),
                    ),
                  ),
                ),
                actions: <Widget>[
                  RoundedLoadingButton(
                    color: Colors.red,
                    elevation: 10,
                    successColor: Colors.green,
                    errorColor: Colors.red,
                    controller: _btnController,
                    onPressed: () async {
                      var data = await Service.deleteUser(
                        user.id,
                        
                      );

                      if (data.isNotEmpty) {
                        Provider.of<ProviderData>(context, listen: false)
                            .deleteUser(data);
                      } else {
                        _btnController.error();
                        await Future.delayed(const Duration(seconds: 1), () {
                          _btnController.reset();
                        });
                        return;
                      }

                      _btnController.success();

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
