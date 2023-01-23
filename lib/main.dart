import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gabriel_logistik/mobil/daftar_mobil.dart';
import 'package:gabriel_logistik/pages/transaksi_page.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/styles/theme.dart';
import 'package:gabriel_logistik/supir/daftar_supir.dart';
import 'package:provider/provider.dart';

void main() {
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
      debugShowCheckedModeBanner: false,
      locale: const Locale('id'),
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      title: 'Gabriel Logistik',
      theme: AppTheme.getAppThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    PageController page = PageController();
    List<SideMenuItem> items = [
      SideMenuItem(
        priority: 0,
        title: 'Daftar Transaksi',
        onTap: () => page.jumpToPage(0),
        icon: const Icon(Icons.wifi_protected_setup_outlined),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Daftar Supir',
        onTap: () => page.jumpToPage(1),
        icon: const Icon(Icons.people_rounded),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Daftar Mobil',
        onTap: () => page.jumpToPage(2),
        icon: const Icon(Icons.car_rental_rounded),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Laporan Bulanan',
        onTap: () => page.jumpToPage(3),
        icon: const Icon(Icons.document_scanner_rounded),
      ),
      SideMenuItem(
        priority: 4,
        title: 'Kas Tahunan',
        onTap: () => page.jumpToPage(4),
        icon: const Icon(Icons.monetization_on),
      ),
    ];
    //
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            showToggle: true,
            controller: page,
            style: SideMenuStyle(
              backgroundColor: Theme.of(context).primaryColor,
              hoverColor: const Color.fromARGB(255, 101, 157, 202),
              openSideMenuWidth: MediaQuery.of(context).size.width / 6.5,
              selectedColor: Colors.transparent,
              displayMode: SideMenuDisplayMode.open,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            title: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 150,
                      maxWidth: 150,
                    ),
                    child: Image.asset(
                      'images/logo.png',
                    ),
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Logistik',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: items,
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                TransaksiPage(),
                DaftarSupir(),
                DaftarMobil(),
                SizedBox(),
                SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
