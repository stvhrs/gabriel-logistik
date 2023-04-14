import 'package:flutter/material.dart';
import 'package:gabriel_logistik/hp_transaksi_add.dart';
import 'package:gabriel_logistik/hp_transaksi_tile.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:gabriel_logistik/models/jual_beli_mobil.dart';



import 'package:gabriel_logistik/services/service.dart';


import 'package:shared_preferences/shared_preferences.dart';


import 'models/mobil.dart';
import 'models/mutasi_saldo.dart';
import 'models/perbaikan.dart';
import 'models/supir.dart';
import 'models/transaksi.dart';

class DashBoardHp extends StatefulWidget {
  const DashBoardHp({super.key});

  @override
  State<DashBoardHp> createState() => _DashBoardHpState();
}

class _DashBoardHpState extends State<DashBoardHp> {
  PageController page = PageController();


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
        : Consumer<ProviderData>(builder: (context, prov, _) {
            return Scaffold(resizeToAvoidBottomInset: false,
                appBar: AppBar(  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  title: const Text('Riwayat Transaksi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 1.1)),
                  leading: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                        child: const Icon(
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
                            children: const [
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
