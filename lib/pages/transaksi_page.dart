import 'package:flutter/material.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/transaksi/transaksi_add.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_mobil.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_nama.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_perbaikan.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_tanggal.dart';
import 'package:gabriel_logistik/transaksi/transaksi_search_tujuan.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const TransaksiAdd(),
        body: Consumer<ProviderData>(builder: (context, prov, _) {
          return Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
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
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Card(
                    color: Theme.of(context).colorScheme.secondary,
                    shadowColor: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 30,
                              ),
                              Expanded(child: SearchTanggal()),
                              const Expanded(child: SearchNama()),
                              const Expanded(child: SearchMobil()),
                              const Expanded(child: SearchTujuan()),
                              Expanded(child: SearchPerbaikan()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
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
                          flex: 3,
                          child: Text(
                            'No',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            'Berangkat',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 5,
                          child: Text(
                            'Supir',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            'Mobil',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 10,
                          child: Text(
                            'Tujuan',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            'Keluar',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            'Ongkos',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            'Sisa',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            'Perbaikan',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 5,
                          child: Text(
                            textAlign: TextAlign.center,
                            'Action',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      itemCount: prov.listTransaksi.length,
                      itemBuilder: (context, index) =>
                          TransaksiTile(prov.listTransaksi[index], index + 1)),
                ),
              ],
            ),
          );
        }));
  }
}
