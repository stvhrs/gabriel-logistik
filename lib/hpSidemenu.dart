import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/custompaint.dart';
import 'package:gabriel_logistik/hp_transaksi_add.dart';
import 'package:gabriel_logistik/hp_transaksi_tile.dart';
import 'package:gabriel_logistik/logout_hp.dart';
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
import 'models/user.dart';

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
  late List<User> listUser;
  bool loading = true;
  String test = '';
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
listUser=await Service.getUser();
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

    Provider.of<ProviderData>(context, listen: false).setData(listUser,listTransaksi,
        false, listMobil, listSupir, listPerbaikan, listJualBeliMobil,listMutasiSaldo);
    
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
        if (mounted){ initData();}

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return loading
        ?  Center(
            child: CustomPaints(),
          )
        : Consumer<ProviderData>(builder: (context, prov, _) {
            return Scaffold(
                appBar: AppBar(  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  title: const Text('Riwayat Transaksi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 1.1)),
                  leading: HpLogout()
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
                                    'Tarif',
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
