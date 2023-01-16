import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/models/transaksi_model.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/transaksi/search_transaksi.dart';
import 'package:gabriel_logistik/transaksi/transaksi_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/service.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  @override
  void initState() {
    print('init Transaksi Page');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            for (var i = 0; i <= 1000; i++) {
              Provider.of<ProviderData>(context, listen: false)
                  .addTransaksi(Transaksi.fromMap({
                'transaksiId': 1,
                'tanggalBerangkat': '2022-07-20T20:18:04.000Z',
                'tanggalPulang': '2022-07-20T20:18:04.000Z',
                'supir': '$i Steve',
                'tujuan': 'Ganurejo RT4',
                'mobil': '$i Carry AD 1234 XX',
                'gajiSupir': 100,
                'totalCost': 400,
                'fixCost': [
                  {'harga': 100, 'nama': 'bensin'},
                  {'harga': 100, 'nama': 'bensin'}
                ],
                'extendedCost': [
                  {'harga': 23, 'nama': 'Ban Bocor'},
                  {'harga': 100, 'nama': 'Ban Bocor'}
                ]
              }));
            }
          }),
      body: FutureBuilder(
        future: Service.getAllTransaksi(),
        builder: (context, AsyncSnapshot<List<Transaksi>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Transaksi> data = snapshot.data!;
            Provider.of<ProviderData>(context, listen: false)
                .setTransaksi(data, false);
            return Consumer<ProviderData>(builder: (context, prov, _) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: Service.test(),
                      builder: (context, snapshotx) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? CircularProgressIndicator()
                              : Text(jsonDecode(snapshotx.data!)['deskripsi']),
                    ),
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
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 11,
                              child: Text(
                                'Berangkat',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          Expanded(
                              flex: 11,
                              child: Text(
                                'Pulang',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          Expanded(
                              flex: 5,
                              child: Text(
                                'Supir',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          Expanded(
                              flex: 11,
                              child: Text(
                                'Mobil',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          Expanded(
                              flex: 11,
                              child: Text(
                                'Tujuan',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          Expanded(
                              flex: 11,
                              child: Text(
                                'Gaji Supir',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          Expanded(
                              flex: 11,
                              child: Text(
                                'Total Cost',
                                style: Theme.of(context).textTheme.headline2,
                              )),
                          const Expanded(flex: 5, child: Text('Action')),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                          itemCount: prov.listTransaksi.length,
                          itemBuilder: (context, index) =>
                              TransaksiTile(prov.listTransaksi[index], index)),
                    ),
                  ],
                ),
              );
            });
          }
        },
      ),
    );
  }
}
