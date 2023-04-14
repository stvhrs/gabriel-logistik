import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_add.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_edit.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_add.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_edit.dart';
import 'package:gabriel_logistik/mutasiSaldo/mutasi_search.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class MutasiSaldoPage extends StatefulWidget {
  const MutasiSaldoPage({super.key});

  @override
  State<MutasiSaldoPage> createState() => _MutasiSaldoPageState();
}

class _MutasiSaldoPageState extends State<MutasiSaldoPage> {
  @override
  void initState() {     Provider.of<ProviderData>(context, listen: false).startMutasi = null;
    Provider.of<ProviderData>(context, listen: false).endMutasi = null;
  
    
      Provider.of<ProviderData>(context, listen: false).start = null;
    Provider.of<ProviderData>(context, listen: false).end = null;
    Provider.of<ProviderData>(context, listen: false).searchsupir = '';
    Provider.of<ProviderData>(context, listen: false).searchtujuan = '';
    Provider.of<ProviderData>(context, listen: false).searchmobile = '';
     Provider.of<ProviderData>(context, listen: false).searchTransaksi();
       Provider.of<ProviderData>(context, listen: false).calculateSaldo();
     Provider.of<ProviderData>(context, listen: false).searchHistorySaldo();
     Provider.of<ProviderData>(context, listen: false).calculateMutasi();
    log('calucalte mutasi page');
    super.initState();
  }

  bool transaksi = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.print),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => LaporanPrint(listKeuangan),
            // ));
          }),
      body: Consumer<ProviderData>(
        builder: (context, value, child) => Container(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 10,
                    strokeAlign: StrokeAlign.center),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            // width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Text(
                    'Mutasi Saldo',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image.asset('images/search.png',
                    //                   height: 30),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SearchMutasi(),
                        Text('Saldo : ' + Rupiah.format(value.totalSaldo),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    )),
                  ],
                ),
    
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        'Tanggal',
                        style: Theme.of(context).textTheme.displayMedium,
                      )),
                      Expanded(
                          child: Text('Sumber',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                          child: Text('Detail',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                          child: Text('Harga',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                          child: Text('Saldo',
                              style: Theme.of(context).textTheme.displayMedium))
                    ],
                  ),
                ),
                
                   SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          itemCount: value.listHistorySaldo.length,
                          itemBuilder: (context, index) => (InkWell(
                                child: Container(
                                  color: index.isEven
                                      ? const Color.fromARGB(255, 189, 193, 221)
                                      : Colors.grey.shade200,
                                  padding:
                                      const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(FormatTanggal.formatTanggal(
                                              value.listHistorySaldo[index]
                                                  .tanggal))),
                                      Expanded(
                                          child: Text(
                                              value.listHistorySaldo[index].sumber)),
                                      Expanded(
                                          child: Text(
                                              value.listHistorySaldo[index].detail)),
                                      Expanded(
                                          child: Text(Rupiah.format(
                                              value.listHistorySaldo[index].harga))),
                                      Expanded(
                                          child: Text(Rupiah.format(value
                                              .listHistorySaldo[index]
                                              .sisaSaldo))),
                                    ],
                                  ),
                                ),
                              ))))
                
              ],
            )),
      ),
    );
  }
}
