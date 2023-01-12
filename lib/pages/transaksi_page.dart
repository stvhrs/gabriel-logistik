import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
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
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: (){
      Provider.of<ProviderData>(context,listen: false).addTransaksi(
        Transaksi.fromMap( {
        'transaksiId': 1,
        'tanggalBerangkat': '2022-07-20T20:18:04.000Z',
        'tanggalPulang': '2022-07-20T20:18:04.000Z',
        'supir': 'Budi2',
        'tujuan': 'Gemolong',
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
      })
      );
    }),
      body: FutureBuilder(
        future: Service().getAllTransaksi(),
        builder: (context, AsyncSnapshot<List<Transaksi>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Transaksi> data = snapshot.data!;
            Provider.of<ProviderData>(context,listen: false).setTransaksi(data);
            return Consumer<ProviderData>(
              builder: (context,prov,_) {
                return ListView.builder(
                  itemCount:prov.listTransaksi. length,
                  itemBuilder: (context, index) => Text(prov.listTransaksi[index].supir),
                );
              }
            );
          }
        },
      ),
    );
  }
}
