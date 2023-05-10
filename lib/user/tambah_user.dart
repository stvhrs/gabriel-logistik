import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/uppercase.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../login/app_icons.dart';
import '../providerData/providerData.dart';

class TambahUser extends StatefulWidget {

  TambahUser({super.key});

  @override
  State<TambahUser> createState() => _TambahUserState();
}

class _TambahUserState extends State<TambahUser> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
bool hidden=true;
    String namaMobil = '';
    String noHp = '';
  @override
  Widget build(BuildContext context) {
TextEditingController satu=TextEditingController();
TextEditingController satu2=TextEditingController();
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
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
                      const Text('Tambah User'),
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
                    child:StatefulBuilder(
                    builder: (context,setState,) {
                        return SizedBox(
                          width: 500,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(controller: satu,
                                  style: const TextStyle(fontSize: 13.5),
                                  textInputAction: TextInputAction.next,inputFormatters: [UpperCaseTextFormatter()],
                                  decoration:   InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: SizedBox(
                             
                              child: Icon(Icons.email),
                            ),
                                    hintText: 'Username',
                                  ),
                                  onChanged: (val) {
                                    namaMobil = val.toString();
                                  },
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(controller:satu2 ,obscureText: hidden,
                                  style: const TextStyle(fontSize: 13.5),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    hidden = !hidden;
                                    setState(() {});
                                  },
                                  icon: hidden
                                      ? Icon(Icons.remove_red_eye_outlined)
                                      :  Icon(Icons.remove_red_eye_rounded),
                                ),
                                prefixIcon: SizedBox(
                                  child:Icon(Icons.lock),
                                ),
                                    hintText: 'Password',
                                  ),
                                  onChanged: (val) {
                                    noHp = val.toString();
                                  },
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                  actions: <Widget>[
                   Container(margin: EdgeInsets.only(top: 10),
                                    child: Expanded(
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [RoundedLoadingButton(width: 120,color: Colors.red,controller:
                                         RoundedLoadingButtonController(), onPressed: (){
                                          Navigator.of(context).pop();
                                         }, child: const Text('Batal',
                                                style: TextStyle(color: Colors.white))),
                                          RoundedLoadingButton(width: 120,
                                            color: Theme.of(context).primaryColor,
                      elevation: 10,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      controller: _btnController,
                      onPressed: () async {
                        if (noHp.isEmpty || namaMobil.isEmpty) {
                          _btnController.error();
                          await Future.delayed(const Duration(seconds: 1));
                          _btnController.reset();
                          return;
                        }
                        var data = await Service.postSupir(
                            {'nama_supir': namaMobil, "no_hp": noHp,"terhapus":"false"});

                        if (data != null) {
                          Provider.of<ProviderData>(context, listen: false)
                              .addSupir(data);
                        }else{
                          _btnController.error();
                         await Future.delayed(const Duration(milliseconds: 500));
                          _btnController.reset();
                          return;

                        }

                        _btnController.success();

                        await Future.delayed(const Duration(seconds: 1), () {
                          namaMobil="";
                          noHp="";
                          satu.clear();
                          satu2.clear();
                          
                        _btnController.reset();
                        });
                      },
                      child: const Text('Simpan',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                                    )))]);;
              });
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Tambah',
          style: TextStyle(color: Colors.white),
        ));
  }
}
