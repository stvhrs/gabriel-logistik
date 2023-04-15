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
          showDialog(barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                  title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Edit Mobil"), Padding(
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
                              style: TextStyle(fontSize:13),textInputAction: TextInputAction.next,initialValue: mobil.nama_mobil,
                              decoration: const InputDecoration(
                                hintText: 'No Pol',
                              ),
                              onChanged: (val) {
                                mobil.nama_mobil = val.toString();
                              },
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              style: TextStyle(fontSize:13),textInputAction: TextInputAction.next,initialValue: mobil.keterangan_mobill,
                              decoration: const InputDecoration(
                                hintText: 'Keterangan',
                              ),
                              onChanged: (val) {
                                 mobil.keterangan_mobill = val.toString();
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
                                    mobil.keterangan_mobill,mobil.perbaikan));
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
