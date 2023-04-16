import 'dart:convert';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/logout.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';

import 'package:gabriel_logistik/pages/daftar_supir.dart';
import 'package:gabriel_logistik/pages/dashboard..dart';
import 'package:gabriel_logistik/pages/jual_beli.dart';
import 'package:gabriel_logistik/pages/kas_tahun.dart';
import 'package:gabriel_logistik/pages/laporan_bulanan.dart';
import 'package:gabriel_logistik/pages/mutasi_saldo.dart';
import 'package:gabriel_logistik/pages/cashflow_page.dart';

import 'package:gabriel_logistik/pages/perbaikan_page.dart';

import 'package:gabriel_logistik/pages/transaksi_page.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/mutasi_saldo.dart';
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
  late List<Perbaikan> listPerbaikan;
  late List<JualBeliMobil> listJualBeliMobil;
  late List<MutasiSaldo> listMutasiSaldo;
  bool loading = true;
  String test = '';
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
    listTransaksi = await Service.getAllTransaksi();
    listSupir = await Service.getAllSupir();
    listPerbaikan = await Service.getAllPerbaikan();

    listJualBeliMobil = await Service.getAlljualBeli();
    listMobil = await Service.getAllMobil(listPerbaikan);
    listMutasiSaldo=await Service.getAllMutasiSaldo();
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
        false, listMobil, listSupir, listPerbaikan, listJualBeliMobil,listMutasiSaldo);
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
                      itemHeight: 40,iconSize: 16,
                      // itemBorderRadius:BorderRadius.all(Radius.circular(0) ),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),),
                      toggleColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                      hoverColor:
                          Theme.of(context).colorScheme.primary.withBlue(150),
                      openSideMenuWidth:
                          MediaQuery.of(context).size.width / 6.5,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedIconColor: Colors.white,
                      displayMode: SideMenuDisplayMode.open,
                      itemOuterPadding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      itemBorderRadius:
                          const BorderRadius.all(Radius.circular(0)),
                      unselectedTitleTextStyle: TextStyle(
                          fontFamily: 'Nunito',
                          overflow: TextOverflow.visible,
                          fontSize: 15,
                          color: Colors.grey.shade300),
                      selectedTitleTextStyle: const TextStyle(
                          fontFamily: 'Nunito',
                          overflow: TextOverflow.visible,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      selectedIconColor: Colors.white,
                    ),
                    title: Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            maxWidth: 200,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                Provider.of<ProviderData>(context,
                                            listen: false)
                                        .isOwner
                                    ? 'images/boss.png'
                                    : 'images/admin.png',

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
                      child:Logout()
                    ),
                    items: [
                      SideMenuItem(
                        priority: 0,
                        title: 'Dashboard',
                        icon: const Icon(Icons.dashboard),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.monetization_on),
                      ),
                      SideMenuItem(
                        priority: 1,
                        title: 'Transaksi',
                        icon: const Icon(Icons.currency_exchange_rounded),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.wifi_protected_setup_outlined),
                      ),
                      SideMenuItem(
                        priority: 2,
                        title: 'Daftar Supir', icon: const Icon(Icons.people),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.people_rounded),
                      ),
                      SideMenuItem(
                        priority: 3,
                        title: 'Daftar Mobil', icon: const Icon(Icons.fire_truck),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.car_rental_rounded),
                      ),
                      SideMenuItem(
                        priority: 4,
                        title: 'Inventory', icon: const Icon(Icons.inventory),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.car_repair),
                      ),
                      SideMenuItem(
                        priority: 5,
                        title: 'Perbaikan',
                        icon: const Icon(Icons.engineering_rounded),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.monetization_on),
                      ),
                      SideMenuItem(
                        priority: 6,
                        title: 'Keuangan Bulanan',
                        icon: const Icon(Icons.monitor_heart_rounded),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.document_scanner_rounded),
                      ),
                      SideMenuItem(
                        priority: 7,
                        title: 'Keuangan Tahunan',
                        icon: const Icon(Icons.auto_graph_rounded),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.monetization_on),
                      ),
                       SideMenuItem(
                        priority: 8,
                        title: 'Cash Flow',
                        icon: const Icon(Icons.compare_arrows),
                        onTap: (s, w) {
                          page.jumpToPage(s);
                          sideMenu.changePage(s);
                        },
                        // icon: const Icon(Icons.monetization_on),
                      ),
                      SideMenuItem(
                        priority: 9,
                        title: 'Mutasi Saldo',
                        icon: const Icon(Icons.attach_money_rounded),
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
                     
                      DashBoardPage(),
                      TransaksiPage(),
                      DaftarSupir(),
                      DaftarMobil(),
                      JualBeli(),
                      PerbaikanPage(),
                      LaporanBulanan(),
                      KasTahun(), CashFlow(),
                        MutasiSaldoPage(),
                      
                    ],
                  ),
                ),
              ],
            ));
  }
}
