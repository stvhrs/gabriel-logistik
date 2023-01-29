import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gabriel_logistik/login.dart';

import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/pages/kas_tahun.dart';
import 'package:gabriel_logistik/pages/laporan_bulanan.dart';
import 'package:gabriel_logistik/pages/transaksi_page.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:gabriel_logistik/sidemenu.dart';
import 'package:gabriel_logistik/styles/theme.dart';
import 'package:gabriel_logistik/pages/daftar_supir.dart';
import 'package:provider/provider.dart';

import 'models/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProviderData()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('id', {}),
      ],
      initLanguageCode: 'id',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
      locale: const Locale('id'),
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      title: 'Logistik',
      theme: AppTheme.getAppThemeData(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
bool loading=true;
  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    if (data != null) {
     
      Provider.of<ProviderData>(context, listen: false).login();
       loading=false;
       setState(() {
         
       });
     
    } else {
      Provider.of<ProviderData>(context, listen: false).logout();
        loading=false;
       setState(() {
         
       });
      return;
    }
   
  }

  @override
  void initState() {
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return loading?CircularProgressIndicator() :Consumer<ProviderData>(builder: (context, data, _) {
      return data.logined ? DashBoard() : Login();
    });
  }
}
