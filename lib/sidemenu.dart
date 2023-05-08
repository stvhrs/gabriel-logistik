import 'dart:convert';
import 'dart:developer';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:gabriel_logistik/pages/administrasi_page.dart';

import 'package:gabriel_logistik/pages/daftar_supir.dart';
import 'package:gabriel_logistik/pages/dashboard..dart';
import 'package:gabriel_logistik/pages/jual_beli.dart';
import 'package:gabriel_logistik/pages/kas_tahun.dart';
import 'package:gabriel_logistik/pages/laporan_bulanan.dart';
import 'package:gabriel_logistik/pages/laporan_kas.dart';
import 'package:gabriel_logistik/pages/mutasi_saldo.dart';
import 'package:gabriel_logistik/pages/nota_beli.dart';
import 'package:gabriel_logistik/pages/nota_jual.dart';


import 'package:gabriel_logistik/pages/perbaikan_page.dart';
import 'package:gabriel_logistik/pages/rekap_unit.dart';

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
import 'package:gabriel_logistik/helper/custompaint.dart';

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

  String test = '';
  bool loading = true;
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
    if (mounted) {
      initData();
    }
    super.initState();
  }

  int _selectedIndex = 0;
  List<Widget> wid = [
    const DashBoardPage(),
    const DaftarMobil(),
    const DaftarSupir(),
    const JualBeli(),
    const TransaksiPage(),
    const PerbaikanPage(),
    const AdministrasiPage(), CashFlow(),
    const CashFlow1(),
   
    const LaporanBulanan(),
    const KasTahun(),
    const RekapUnit(),   LaporanKas(),
    const MutasiSaldoPage(),

    Container(
      child: Center(child: Text("USER")),
    )
  ];
  final List<bool> _open = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    log("build");

    var item = const TextStyle(
        fontFamily: 'Nunito',
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.white);
    return loading
        ? Center(
            child: CustomPaints(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.90),
                  width: MediaQuery.of(context).size.width * 0.17,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('images/title.png'),
                              )),
                        ),
                        Container(
                            color: _selectedIndex == 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).primaryColor,
                            child: ListTile(
                              iconColor: Colors.white,
                              minLeadingWidth: 20,
                              textColor: _selectedIndex == 0
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.white,
                              onTap: () {
                                _selectedIndex = 0;
                                setState(() {});
                              },
                              leading:
                                  const Icon(Icons.space_dashboard_rounded),
                              title: Text(style: item, 'Dashboard'),
                            )),
                        ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          title: Text(
                            style: item,
                            'Daftar Unit',
                          ),
                          children: <Widget>[
                            Container(
                                color: _selectedIndex == 1
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 1
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 1;
                                    setState(() {});
                                  },
                                  leading: const Icon(Icons.fire_truck),
                                  title: Text(style: item, 'Daftar Mobil'),
                                )),
                            Container(
                                color: _selectedIndex == 2
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 2
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 2;
                                    setState(() {});
                                  },
                                  leading: const Icon(Icons.people),
                                  title: Text(style: item, 'Daftar Supir'),
                                )),
                            Container(
                                color: _selectedIndex == 3
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 3
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 3;
                                    setState(() {});
                                  },
                                  leading: const Icon(Icons.inventory),
                                  title: Text(style: item, 'Jual Beli Unit'),
                                ))
                          ],
                        ),
                        ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          title: Text(
                            style: item,
                            'Transaksi',
                          ),
                          children: <Widget>[
                            Container(
                                color: _selectedIndex == 4
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 4
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 4;
                                    setState(() {});
                                  },
                                  leading: const Icon(
                                      Icons.currency_exchange_rounded),
                                  title: Text(style: item, 'Ritase'),
                                )),
                            Container(
                                color: _selectedIndex == 5
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 5
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 5;
                                    setState(() {});
                                  },
                                  leading:
                                      const Icon(Icons.engineering_rounded),
                                  title: Text(style: item, 'Perbaikan'),
                                )),
                            Container(
                                color: _selectedIndex == 6
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 6
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 6;
                                    setState(() {});
                                  },
                                  leading:
                                      const Icon(Icons.document_scanner_sharp),
                                  title: Text(style: item, 'Administrasi'),
                                )),
                          ],
                        ),
                        ExpansionTile(
                            collapsedIconColor: Colors.white,
                            iconColor: Colors.white,
                            title: Text(
                              style: item,
                              'Transaksi Lain',
                            ),
                            children: <Widget>[
                              Container(
                                  color: _selectedIndex == 7
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.primary,
                                  child: ListTile(
                                    iconColor: Colors.white,
                                    minLeadingWidth: 20,
                                    textColor: _selectedIndex == 7
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.white,
                                    onTap: () {
                                      _selectedIndex = 7;
                                      setState(() {});
                                    },
                                    leading: const Icon(Icons.compare_arrows),
                                    title: Text(style: item, 'Nota Pembelian'),
                                  )),
                              Container(
                                  color: _selectedIndex == 8
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.primary,
                                  child: ListTile(
                                    iconColor: Colors.white,
                                    minLeadingWidth: 20,
                                    textColor: _selectedIndex == 8
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.white,
                                    onTap: () {
                                      _selectedIndex = 8;
                                      setState(() {});
                                    },
                                    leading: const Icon(Icons.compare_arrows),
                                    title: Text(style: item, 'Nota Penjualan'),
                                  ))
                            ]),
                        ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          title: Text(
                            style: item,
                            'Laporan Unit',
                          ),
                          children: <Widget>[
                            Container(
                                color: _selectedIndex == 9
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 8
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 9;
                                    setState(() {});
                                  },
                                  leading:
                                      const Icon(Icons.monitor_heart_rounded),
                                  title: Text(style: item, 'Mobil Bulanan'),
                                )),
                            Container(
                                color: _selectedIndex == 10
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 10
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 10;
                                    setState(() {});
                                  },
                                  leading:
                                      const Icon(Icons.calendar_month_rounded),
                                  title: Text(style: item, 'Mobil Tahunan'),
                                )),
                            Container(
                                color: _selectedIndex == 11
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 11
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 11;
                                    setState(() {});
                                  },
                                  leading: const Icon(Icons.auto_graph_rounded),
                                  title: Text(style: item, 'Rekap Tahunan'),
                                )),
                          ],
                        ),
                        ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          title: Text(
                            style: item,
                            'Kas',
                          ),
                          children: <Widget>[
                             Container(
                                color: _selectedIndex == 12
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).primaryColor,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 12
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 12;
                                    setState(() {});
                                  },
                                  leading:
                                      const Icon(Icons.shopify_rounded),
                                  title: Text(style: item, 'Laporan Kas'),
                                )),
                            Container(
                                color: _selectedIndex == 13
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).primaryColor,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 13
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 13;
                                    setState(() {});
                                  },
                                  leading:
                                      const Icon(Icons.attach_money_rounded),
                                  title: Text(style: item, 'Mutasi'),
                                ))
                          ],
                        ),
                        Provider.of<ProviderData>(context, listen: false)
                                .isOwner
                            ? Container(
                                color: _selectedIndex == 14
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).primaryColor,
                                child: ListTile(
                                  iconColor: Colors.white,
                                  minLeadingWidth: 20,
                                  textColor: _selectedIndex == 14
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.white,
                                  onTap: () {
                                    _selectedIndex = 14;
                                    setState(() {});
                                  },
                                  leading:
                                      const Icon(Icons.emoji_people_rounded),
                                  title: Text(style: item, 'User Management'),
                                ))
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
                Expanded(child: wid[_selectedIndex]),
              ],
            ));
  }
}
