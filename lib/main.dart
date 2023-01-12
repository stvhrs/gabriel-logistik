import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gabriel_logistik/pages/transaksi_page.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProviderData()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

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
      locale: Locale('id'),
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,scaffoldBackgroundColor: Colors.white
      ),
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
        title: 'Dashboard',
        onTap: () => page.jumpToPage(0),
        icon: Icon(Icons.home),
        badgeContent: Text(
          '3',
          style: TextStyle(color: Colors.white),
        ),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Settings',
        onTap: () => page.jumpToPage(1),
        icon: Icon(Icons.settings),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Exit',
        onTap: () {},
        icon: Icon(Icons.exit_to_app),
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
            style: SideMenuStyle(backgroundColor: Color.fromARGB(255, 163, 213, 237),
              hoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
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
                'mohada',
                style: TextStyle(fontSize: 15),
              ),
            ),
            items: items,
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                TransaksiPage(),
                Center(
                  child: Container(
                    color: Colors.white,
                    child: WebDatePicker(
                      dateformat: 'dd/MM/yyyy',
                      onChange: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
