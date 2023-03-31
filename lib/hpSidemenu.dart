import 'package:flutter/material.dart';
import 'package:gabriel_logistik/hp_transaksi_add.dart';
import 'package:gabriel_logistik/hp_transaksi_tile.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/transaksi/transaksi_add.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_mobil.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_nama.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_tanggal.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_tujuan.dart';
import 'package:gabriel_logistik/transaksi/transaksi_tile.dart';
import 'package:provider/provider.dart';
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

class DashBoardHp extends StatefulWidget {
  const DashBoardHp({super.key});

  @override
  State<DashBoardHp> createState() => _DashBoardHpState();
}

class _DashBoardHpState extends State<DashBoardHp> {
  late List<Transaksi> listTransaksi;
  late List<Supir> listSupir;
  late List<Mobil> listMobil;
  late List<Pengeluaran> listPengeluaran;
  late List<JualBeliMobil> listJualBeliMobil;
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
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Consumer<ProviderData>(builder: (context, prov, _) {
            return Scaffold(resizeToAvoidBottomInset: false,
                appBar: AppBar(  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  title: Text('Riwayat Transaksi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 1.1)),
                  leading: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                        child: Icon(
                          Icons.restart_alt_rounded,
                          color: Colors.red,
                        ),
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();

                          // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MyHomePage(title: ''),));
                          Provider.of<ProviderData>(context, listen: false)
                              .logout();
                        },
                      ),
                    ),
                  ),
                ),
                
                backgroundColor: Colors.grey.shade300,
                floatingActionButton: HpTransaksiAdd(),
                body: Padding(
                    padding: const EdgeInsets.only(top: 0, ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              // borderRadius: const BorderRadius.only(
                              //     topLeft: Radius.circular(5),
                              //     topRight: Radius.circular(5))
                                  ),
                          margin: const EdgeInsets.only(top: 0),
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 12.5, left: 10, right: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Text(
                                    'Tanggal',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 8,
                                  child: Text(
                                    'Mobil',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 10,
                                  child: Text(
                                    'Tujuan',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 7,
                                  child: Text(
                                    'Ongkos',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 7,
                                  child: Text(
                                    'Keluar',
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                 
                          child: ListView.builder(
                              itemCount: prov.listTransaksi.length,
                              itemBuilder: (context, index) => HpTransaksiTile(
                                  prov.listTransaksi[index], index + 1)),
                        ),
                      ],
                    )));
          });
  }
}
