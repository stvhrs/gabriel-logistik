import 'package:flutter/material.dart'; 
import 'package:gabriel_logistik/services/service.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class TambahMobil extends StatelessWidget {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  TambahMobil({super.key});
  @override
  Widget build(BuildContext context) {
    String namaMobil = '';
    String noHp = '';


    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
               Colors.green)),
        onPressed: () {
          showDialog(barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Tambah Mobil"), Padding(
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
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'No Pol',
                              ),
                              onChanged: (val) {
                                namaMobil = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Keterangan',
                              ),
                              onChanged: (val) {
                                noHp = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                        
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
                        
                            namaMobil.isEmpty) {
                          _btnController.error();
                          await Future.delayed(const Duration(seconds: 1));
                          _btnController.reset();
                          return;
                        }

                         var data = await Service.postMobil(
                           {
       
        "plat_mobil": namaMobil,
        "ket_mobil":noHp,
        "terjual": "false"
    });

                        if (data != null) {
                          Provider.of<ProviderData>(context, listen: false)
                              .addMobil(data);
                        }else{
                         _btnController.error();
                         await Future.delayed(Duration(milliseconds: 500));
                          _btnController.reset();
                          return;
                        }

                       
                          _btnController.success();
                        
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
