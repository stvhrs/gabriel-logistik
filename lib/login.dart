import 'dart:convert';

import 'package:flutter/material.dart'; 
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.2,
          child: Card(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: const Color.fromARGB(255, 189, 193, 221),
                shadowColor: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, right: 30, left: 30, top: 10),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 10, right: 30, left: 30),
                      child: TextFormField(
                          onChanged: (val) {
                            _userControler = val;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Username')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 30, right: 30, left: 30),
                      child: TextFormField(
                          onChanged: (val) {
                            _passwordControler = val;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          obscureText: true),
                    ),
                    RoundedLoadingButton(
                      color: Colors.green,
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
                          await prefs.setString('data', jsonEncode(userData));

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
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    )
                  ]),
                ),
              ),
            ),
          )),
    );
  }
}
