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
    listMutasiSaldo = await Service.getAllMutasiSaldo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    if (jsonDecode(data!)['status'] == 'owner') {
      print('owner');
      Provider.of<ProviderData>(context, listen: false).owner();
    } else {
      print('admin');
      Provider.of<ProviderData>(context, listen: false).admin();
    }

    Provider.of<ProviderData>(context, listen: false).setData(
        listTransaksi,
        false,
        listMobil,
        listSupir,
        listPerbaikan,
        listJualBeliMobil,
        listMutasiSaldo);
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

  int _selectedIndex = 0;
  List<Widget> wid = [
    DashBoardPage(),
    TransaksiPage(),
    DaftarSupir(),
    DaftarMobil(),
    JualBeli(),
    PerbaikanPage(),
    LaporanBulanan(),
    KasTahun(),
    CashFlow(),
    MutasiSaldoPage(),
  ];
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
                NavigationRail(
                  minWidth: MediaQuery.of(context).size.width * 0.14,
                  indicatorColor: Theme.of(context).primaryColor,
                  useIndicator: false,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  leading: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.075,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset('images/cahaya.png'),
                      ),
                      Divider(
                        color: Colors.white,thickness: 2,height: 2,
                      )
                    ],
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  destinations: <NavigationRailDestination>[
                    // navigation destinations

                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.dashboard_rounded,
                              color: _selectedIndex == 0
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Dashboard',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_exchange_rounded,
                              color: _selectedIndex == 1
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Transaksi',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: _selectedIndex == 2
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Daftar Supir',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.fire_truck,
                              color: _selectedIndex == 3
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Daftar Mobil',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.inventory,
                              color: _selectedIndex == 4
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Inventory',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.engineering_rounded,
                              color: _selectedIndex == 5
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Perbaikan',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.monitor_heart_rounded,
                              color: _selectedIndex == 6
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Keuangan Bulanan',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_graph_rounded,
                              color: _selectedIndex == 7
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Keuangan Tahunan',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.compare_arrows,
                              color: _selectedIndex == 8
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Uang Masuk Keluar',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.zero,
                      icon: Container(
                        height: 10,
                      ),
                      label: Container(
                        width: MediaQuery.of(context).size.width * 0.14,
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: _selectedIndex == 9
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Mutasi Saldo',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  selectedIconTheme: IconThemeData(color: Colors.white,size: 17),
                  unselectedIconTheme: IconThemeData(color: Colors.grey.shade700),
                  
                  selectedLabelTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,letterSpacing: 1.2),
                  unselectedLabelTextStyle: TextStyle(
                      color: Colors.grey.shade500, letterSpacing: 1.2),
                ),
              
                Expanded(child: wid[_selectedIndex]),
              ],
            ));
  }
}
