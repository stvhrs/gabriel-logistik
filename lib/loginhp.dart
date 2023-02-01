import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHp extends StatefulWidget {
  const LoginHp({super.key});

  @override
  State<LoginHp> createState() => _LoginHpState();
}

class _LoginHpState extends State<LoginHp> {
  List<Map<String, dynamic>> data = [
    {'user': 'owner', 'pass': '123', 'status': 'owner'},
    {'user': 'admin', 'pass': '123', 'status': 'admin'},
  ];
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String _userControler = '';
  String _passwordControler = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.3,
          child: Card(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: const Color.fromARGB(255, 189, 193, 221),
                shadowColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, bottom: 10, right: 30, left: 30),
                            child: TextFormField(
                                onChanged: (val) {
                                  _userControler = val;
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Username')),
                          ),
                        ),
                        Expanded(
                            child:Padding(
                            padding: const EdgeInsets.only(
                                top: 30, bottom: 10, right: 30, left: 30),
                          child: TextFormField(
                              onChanged: (val) {
                                _passwordControler = val;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              ),
                              obscureText: true),
                        )),
                        Expanded(
                            child: RoundedLoadingButton(
                          color: TargetPlatform.windows == defaultTargetPlatform
                              ? Colors.red
                              : Colors.green,
                          controller: _btnController,
                          successColor: Colors.green,
                          errorColor: Colors.red,
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            bool valid = false;
                            var userData = {};
                            for (var element in data) {
                              if (_passwordControler == element['pass'] &&
                                  _userControler == element['user']) {
                                userData = element;
                                valid = true;
                              }
                            }

                            if (valid) {
                              _btnController.success();
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              await prefs.setString(
                                  'data', jsonEncode(userData));

                              Provider.of<ProviderData>(context, listen: false)
                                  .login();
                            } else {
                              _btnController.error();
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              _btnController.reset();
                              return;
                            }
                          },
                          child: const Text('LoginHp',
                              style: TextStyle(color: Colors.white)),
                        ))
                      ]),
                ),
              ),
            ),
          )),
    );
  }
}
