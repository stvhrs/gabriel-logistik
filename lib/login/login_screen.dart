import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gabriel_logistik/login/app_colors.dart';
import 'package:gabriel_logistik/login/app_icons.dart';
import 'package:gabriel_logistik/login/app_styles.dart';
import 'package:gabriel_logistik/login/responsive_widget.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? height * 0.032 : height * 0.12),
                color: AppColors.backColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.2),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Halaman',
                                style: ralewayStyle.copyWith(
                                  fontSize: 25.0,
                                  color: AppColors.blueDarkColor,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                              text: ' Log in 👇',
                              style: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.blueDarkColor,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text('Masukan Username dan Password',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(height: height * 0.064),

                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text('Username',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(onChanged: (val){
                              _userControler = val;
                        },

                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Image.asset(AppIcons.emailIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 0),
                            hintText: 'Enter Username',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text('Password',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField( onChanged: (val) {
                            _passwordControler = val;
                          },

                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          obscureText: true,

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){},
                              icon: Image.asset(AppIcons.eyeIcon),
                            ),
                            prefixIcon: IconButton(
                              onPressed: (){},
                              icon: Image.asset(AppIcons.lockIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 0),
                            hintText: 'Enter Password',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.03),
                    
                      SizedBox(height: height * 0.05),
                      RoundedLoadingButton(
                      color: Theme.of(context).colorScheme.primary,
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
                      child: const Text('Log in',
                          style: TextStyle(color: Colors.white)),
                    )
                    ],
                  ),
                ),
              ),
            ),ResponsiveWidget.isSmallScreen(context) ? const SizedBox() : Expanded(
              child: Container(
                height: height,
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                  child: Text(
                    'Logistik',
                    style: ralewayStyle.copyWith(
                      fontSize: 48.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
