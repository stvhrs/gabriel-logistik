import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gabriel_logistik/pages/daftar_mobil.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/pages/kas_tahun.dart';
import 'package:gabriel_logistik/pages/laporan_bulanan.dart';
import 'package:gabriel_logistik/pages/transaksi_page.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:gabriel_logistik/styles/theme.dart';
import 'package:gabriel_logistik/pages/daftar_supir.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import 'models/transaksi.dart';

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
      title: 'Logistik',
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
  PageController _pageController=PageController();
  late List<Transaksi> listTransaksi;
  late List<Supir> listSupir;
  late List<Mobil> listMobil;
  bool loading = true;
  initData() async {
    listTransaksi = await Service.getAllTransaksi();
    listSupir = await Service.getAllSupir();
    listMobil = await Service.getAllMobil();
    loading = false;
    setState(() {});
    Provider.of<ProviderData>(context, listen: false)
        .setData(listTransaksi, false, listMobil, listSupir);
  }

  @override
  void initState() {
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SideMenuController page = SideMenuController();
    List<SideMenuItem> items = [
      SideMenuItem(
        priority: 0,
        title: 'Daftar Transaksi',
        onTap:(s,w){_pageController.jumpToPage(s);
        page.changePage(s);},
        icon: const Icon(Icons.wifi_protected_setup_outlined),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Daftar Supir',
        onTap:(s,w){_pageController.jumpToPage(s);
        page.changePage(s);},
        icon: const Icon(Icons.people_rounded),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Daftar Mobil',
        onTap:(s,w){_pageController.jumpToPage(s);
        page.changePage(s);},
        icon: const Icon(Icons.car_rental_rounded),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Laporan Bulanan',
        onTap:(s,w){_pageController.jumpToPage(s);
        page.changePage(s);},
        icon: const Icon(Icons.document_scanner_rounded),
      ),
      SideMenuItem(
        priority: 4,
        title: 'Kas Tahunan',
        onTap:(s,w){_pageController.jumpToPage(s);
        page.changePage(s);},
        icon: const Icon(Icons.monetization_on),
      ),
    ];
    //
    return !loading
        ? Scaffold(
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  showToggle: true,
                  controller: page,
                  style: SideMenuStyle(
                    toggleColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    hoverColor: Theme.of(context).colorScheme.secondary,
                    openSideMenuWidth: MediaQuery.of(context).size.width / 7.5,
                    selectedColor: Colors.transparent,
                    displayMode: SideMenuDisplayMode.open,
                    unselectedTitleTextStyle:
                        TextStyle(fontWeight: FontWeight.bold),
                    selectedTitleTextStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    selectedIconColor: Colors.white,
                  ),
                  title: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 300,
                            maxWidth: 200,
                          ),
                          child: Image.asset(
                            'images/logo3.png',

                            // color: Colors.white,
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
                    controller: _pageController,
                    children: [
                    
                      TransaksiPage(),
                      DaftarSupir(),
                      DaftarMobil(),  LaporanBulanan(),
                      
                     
                    KasTahun()
                    ],
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
