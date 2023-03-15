import 'dart:convert';


import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart'; 


import 'package:gabriel_logistik/pages/daftar_supir.dart';
import 'package:gabriel_logistik/pages/kas_tahun.dart';
import 'package:gabriel_logistik/pages/laporan_bulanan.dart';
import 'package:gabriel_logistik/pages/transaksi_page.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'pages/daftar_mobil.dart';
import 'models/mobil.dart';
import 'models/supir.dart';
import 'models/transaksi.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  late List<Transaksi> listTransaksi;
  late List<Supir> listSupir;
  late List<Mobil> listMobil;
bool loading=true;

  initData() async {
    listTransaksi = await Service.getAllTransaksi();
    listSupir = await Service.getAllSupir();
    listMobil = await Service.getAllMobil();
      SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    if (jsonDecode(data!)['status'] == 'owner') {
        print('owner');
        Provider.of<ProviderData>(context, listen: false).owner();
      } else {
        print('admin');
        Provider.of<ProviderData>(context, listen: false).admin();
      }
     
 Provider.of<ProviderData>(context, listen: false)
        .setData(listTransaksi, false, listMobil, listSupir);
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    loading=false;
    setState(() {});

   
  }

  @override
  void initState() {
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading?const Center(child: CircularProgressIndicator(),): Scaffold(resizeToAvoidBottomInset: false,
            body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SideMenu(
                showToggle: true,
                controller: sideMenu,
                style: SideMenuStyle(
                  toggleColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  hoverColor: Theme.of(context).colorScheme.secondary,
                  openSideMenuWidth: MediaQuery.of(context).size.width / 7,
                  selectedColor: Colors.transparent,
                  displayMode: SideMenuDisplayMode.open,
                  unselectedTitleTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
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
                    Text(
                        Provider.of<ProviderData>(context, listen: false)
                                .isOwner
                            ? 'Hi Owner !'
                            : 'Hi Admin !',
                        style: const TextStyle(color: Colors.white)),
                    const Divider(
                      indent: 8.0,
                      endIndent: 8.0,
                    ),
                  ],
                ),
                footer: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();

                      // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MyHomePage(title: ''),));
                      Provider.of<ProviderData>(context, listen: false)
                          .logout();
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.red,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
                items: [
                  SideMenuItem(
                    priority: 0,
                    title: 'Riwayat Transaksi',
                    onTap: (s, w) {
                      page.jumpToPage(s);
                      sideMenu.changePage(s);
                    },
                    icon: const Icon(Icons.wifi_protected_setup_outlined),
                  ),
                  SideMenuItem(
                    priority: 1,
                    title: 'Daftar Supir',
                    onTap: (s, w) {
                      page.jumpToPage(s);
                      sideMenu.changePage(s);
                    },
                    icon: const Icon(Icons.people_rounded),
                  ),
                  SideMenuItem(
                    priority: 2,
                    title: 'Daftar Mobil',
                    onTap: (s, w) {
                      page.jumpToPage(s);
                      sideMenu.changePage(s);
                    },
                    icon: const Icon(Icons.car_rental_rounded),
                  ),
                  SideMenuItem(
                    priority: 3,
                    title: 'Laporan Bulanan',
                    onTap: (s, w) {
                      page.jumpToPage(s);
                      sideMenu.changePage(s);
                    },
                    icon: const Icon(Icons.document_scanner_rounded),
                  ),
                  SideMenuItem(
                    priority: 4,
                    title: 'Kas Tahunan',
                    onTap: (s, w) {
                      page.jumpToPage(s);
                      sideMenu.changePage(s);
                    },
                    icon: const Icon(Icons.monetization_on),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: page,
                  children: const [
                    TransaksiPage(),
                    DaftarSupir(),
                    DaftarMobil(),
                    LaporanBulanan(),
                    KasTahun()
                  ],
                ),
              ),
            ],
          ));
  }
}
