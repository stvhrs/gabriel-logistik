import 'dart:convert';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';

import 'package:gabriel_logistik/pages/daftar_supir.dart';
import 'package:gabriel_logistik/pages/jual_beli.dart';
import 'package:gabriel_logistik/pages/kas_tahun.dart';
import 'package:gabriel_logistik/pages/laporan_bulanan.dart';
import 'package:gabriel_logistik/pages/pengeluaran_page.dart';
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
  late List<Pengeluaran> listPengeluaran;
  late List<JualBeliMobil> listJualBeliMobil;
  bool loading = true;

  initData() async {
    listTransaksi = await Service.getAllTransaksi();
    listSupir = await Service.getAllSupir();
    listPengeluaran = await Service.getAllPengeluaran();
    print(listPengeluaran);
    listJualBeliMobil = await Service.getAlljualBeli();
    listMobil = await Service.getAllMobil(listPengeluaran);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    if (jsonDecode(data!)['status'] == 'owner') {
      print('owner');
      Provider.of<ProviderData>(context, listen: false).owner();
    } else {
      print('admin');
      Provider.of<ProviderData>(context, listen: false).admin();
    }

    Provider.of<ProviderData>(context, listen: false).setData(listTransaksi,
        false, listMobil, listSupir, listPengeluaran, listJualBeliMobil);
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SideMenu(
                    showToggle: false,
                    controller: sideMenu,
                    style: SideMenuStyle(
                      itemHeight: 55,
                      // itemBorderRadius:BorderRadius.all(Radius.circular(0) ),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),),
                      toggleColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      hoverColor:  Theme.of(context).colorScheme.secondary,
                      openSideMenuWidth:
                          MediaQuery.of(context).size.width / 6.5,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedIconColor: Colors.white,
                      displayMode: SideMenuDisplayMode.open,
                      itemOuterPadding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      itemBorderRadius: BorderRadius.all(Radius.circular(0)),
                      unselectedTitleTextStyle: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.grey.shade300),
                      selectedTitleTextStyle: const TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      selectedIconColor: Colors.white,
                    ),
                    title: Column(
                      children: [
                        ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 100,
                                maxWidth: 200,
                              ),
                              child:  Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                                 Provider.of<ProviderData>(context, listen: false)
                                    .isOwner?'images/boss.png' : 'images/admin.png', 
                        
                                // color: Colors.white,
                              ),
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
                        child:
                              Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              
                          
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
                        // icon: const Icon(Icons.wifi_protected_setup_outlined),
                      ),
                      SideMenuItem(
                        priority: 1,
                        title: 'Daftar Supir',
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.people_rounded),
                      ),
                      SideMenuItem(
                        priority: 2,
                        title: 'Daftar Mobil',
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.car_rental_rounded),
                      ),
                      SideMenuItem(
                        priority: 3,
                        title: 'Jual Beli Mobil',
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.car_repair),
                      ),
                      SideMenuItem(
                        priority: 4,
                        title: 'Pengeluaran',
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.monetization_on),
                      ),
                      SideMenuItem(
                        priority: 5,
                        title: 'Keuangan Bulanan',
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.document_scanner_rounded),
                      ),
                      SideMenuItem(
                        priority: 6,
                        title: 'Keuangan Tahunan',
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.monetization_on),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: page,
                    children: const [
                      TransaksiPage(),
                      DaftarSupir(),
                      DaftarMobil(),
                      JualBeli(),
                      PengeluaranPage(),
                      LaporanBulanan(),
                      KasTahun(),
                    ],
                  ),
                ),
              ],
            ));
  }
}
