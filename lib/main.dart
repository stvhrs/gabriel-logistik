import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gabriel_logistik/hpSidemenu.dart';

import 'package:gabriel_logistik/login/login_screen.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/sidemenu.dart';
import 'package:gabriel_logistik/styles/theme.dart';
import 'package:provider/provider.dart';
import 'package:gabriel_logistik/helper/custompaint.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await findSystemLocale();
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
      home: const MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
      locale: const Locale('id'),
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      title: 'Cahaya Trans',
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
  bool loading = true;
  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    if (data != null) {
      // ignore: use_build_context_synchronously
      Provider.of<ProviderData>(context, listen: false).login();
      loading = false;
      setState(() {});
    } else {
      Provider.of<ProviderData>(context, listen: false).logout();
      loading = false;
      setState(() {});
      return;
    }
  }

  @override
  void initState() {
        if (mounted){ initData();}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio);
    print(MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio);
    return loading
        ?   CustomPaints()
        : Consumer<ProviderData>(builder: (context, data, _) {
            return data.logined
                ? MediaQuery.of(context).size.width <= 500
                    ? const DashBoardHp()
                    : const DashBoard()
                : const LoginScreen();
          });
  }
}
