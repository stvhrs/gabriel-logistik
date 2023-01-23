import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/transaksi/transaksi_add.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search.dart';
import 'package:gabriel_logistik/transaksi/transaksi_tile.dart';
import 'package:provider/provider.dart';

import '../models/mobil.dart';
import '../models/supir.dart';
import '../services/service.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  late List<Transaksi> listTransaksi;
  late List<Supir> listSupir;
  late List<Mobil> listMobil;

 Future<List<Transaksi>> initData() async {
    listTransaksi = await Service.getAllTransaksi();
    listSupir = await Service.getAllSupir();
    listMobil = await Service.getAllMobil();
   return listTransaksi;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:initData(),
      builder: (context, AsyncSnapshot<List<Transaksi>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Transaksi> data = snapshot.data!;
          Provider.of<ProviderData>(context, listen: false)
              .setData(data, false, listMobil, listSupir);
          return Scaffold(
              floatingActionButton: const TransaksiAdd(),
              body: Consumer<ProviderData>(builder: (context, prov, _) {
                prov.listTransaksi.reversed.toList();
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FutureBuilder(
                      //   future: Service.test(),
                      //   builder: (context, snapshotx) => snapshotx
                      //               .connectionState ==
                      //           ConnectionState.waiting
                      //       ? const CircularProgressIndicator()
                      //       : Text(
                      //           jsonDecode(snapshotx.data!)['data'].toString()),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SearchTransaksi(),
                          InkWell(
                              onTap: () {},
                              child: Image.asset(
                                'images/excel.png',
                                width: MediaQuery.of(context).size.width / 20,
                              ))
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 12.5, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                               Expanded(
                                flex:3,
                                child: Text(
                                  'No',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(
                                flex:7,
                                child: Text(
                                  'Berangkat',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  'Supir',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  'Mobil',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(
                                flex: 10,
                                child: Text(
                                  'Tujuan',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  'Keluar',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  'Ongkos',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  'Perbaikan',
                                  style: Theme.of(context).textTheme.headline2,
                                )),
                            Expanded(flex: 5, child: Text(textAlign: TextAlign.center,'Action', style: Theme.of(context).textTheme.headline2,)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                            itemCount: prov.listTransaksi.reversed.toList().length,
                            itemBuilder: (context, index) => TransaksiTile(
                                prov.listTransaksi[index], index)),
                      ),
                    ],
                  ),
                );
              }));
        }
      },
    );
  }
}
