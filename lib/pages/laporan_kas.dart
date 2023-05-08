import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/history_saldo.dart';

import 'package:gabriel_logistik/models/rekap_model.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/pages/rekap_tile.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../models/perbaikan.dart';

List<String> list = <String>[
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];

class LaporanKas extends StatefulWidget {
  const LaporanKas({super.key});

  @override
  State<LaporanKas> createState() => _LaporanKasState();
}

class _LaporanKasState extends State<LaporanKas> {
  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false).startMutasi = null;
    Provider.of<ProviderData>(context, listen: false).endMutasi = null;

    Provider.of<ProviderData>(context, listen: false).start = null;
    Provider.of<ProviderData>(context, listen: false).end = null;
    Provider.of<ProviderData>(context, listen: false).searchsupir = '';
    Provider.of<ProviderData>(context, listen: false).searchtujuan = '';
    Provider.of<ProviderData>(context, listen: false).searchmobile = '';

    Provider.of<ProviderData>(context, listen: false).searchMobil('', false);
    Provider.of<ProviderData>(context, listen: false).searchTransaksi(false);

    Provider.of<ProviderData>(context, listen: false)
        .searchperbaikan('', false);
    Provider.of<ProviderData>(context, listen: false).calculateSaldo();

    Provider.of<ProviderData>(context, listen: false).calculateMutasi();
    log('calucalte mutasi page');

    super.initState();
  }

  List<int> tahun = [];
  List<RekapModel> listKas = [];
  final innerController = ScrollController();

  String dropdownValue = list[DateTime.now().month - 1];
  String dropdownValue2 = list[DateTime.now().month - 1];
  int ropdownValue2 = DateTime.now().year;
  double totalTransaksi = 0;
  double totalJualUnit = 0;
  double totalNotaBeli = 0;

  double tahunMaintain = 0;
  double toalBeliUnit = 0;
  double totalNotaJual = 0;

  double totalPendapatan = 0;
  double totalPengeluaran = 0;
  double saldoAkhir = 0;
  double saldoAwal = 0;
  @override
  void didChangeDependencies() {
    for (var element
        in Provider.of<ProviderData>(context, listen: false).listHistorySaldo) {
      if (!tahun.contains(DateTime.parse(element.tanggal).year)) {
        tahun.add(DateTime.parse(element.tanggal).year);
      }
    }
    if (!tahun.contains(ropdownValue2)) {
      tahun.add(ropdownValue2);
    }
    super.didChangeDependencies();
    test();
  }

  test() {
    totalTransaksi = 0;
    totalJualUnit = 0;
    totalNotaBeli = 0;

    tahunMaintain = 0;
    toalBeliUnit = 0;
    totalNotaJual = 0;

    totalPendapatan = 0;
    totalPengeluaran = 0;
    saldoAkhir = 0;
    saldoAwal = 0;
    List<HistorySaldo> range = [];

    List<Perbaikan> listPerbaikan = [];
    if (dropdownValue != dropdownValue2) {
      log('beda');
      range = Provider.of<ProviderData>(context, listen: false)
          .listHistorySaldo
          .where((element) =>
              DateTime.parse(element.tanggal).isBefore(DateTime(
                  ropdownValue2, list.indexOf(dropdownValue2) + 1, 31, 24)) &&
              DateTime.parse(element.tanggal).isAfter(
                  DateTime(ropdownValue2, list.indexOf(dropdownValue) + 1, 0)))
          .toList();
      saldoAwal = range.last.sisaSaldo;
      saldoAkhir = range.first.harga + range.first.sisaSaldo;
    } else if (dropdownValue == dropdownValue2) {
      log('sama');
      range = Provider.of<ProviderData>(context, listen: false)
          .listHistorySaldo
          .where((element) =>
              DateTime.parse(element.tanggal).isBefore(DateTime(
                  ropdownValue2, list.indexOf(dropdownValue2) + 1, 31, 24)) &&
              DateTime.parse(element.tanggal).isAfter(DateTime(
                  ropdownValue2, list.indexOf(dropdownValue) + 1, 0, 0)))
          .toList();
      saldoAwal = range.last.sisaSaldo;
      saldoAkhir = range.first.harga + range.first.sisaSaldo;
    }

    for (var element in range) {
      if (element.sumber == "Transaksi") {
        totalTransaksi += element.harga;
        totalPendapatan += element.harga;
      }
      if (element.sumber == "Jual Mobil") {
        totalJualUnit += element.harga;
        totalPendapatan += element.harga;
      }
      if (element.sumber == "Beli Mobil") {
        totalPengeluaran += element.harga;
        toalBeliUnit += element.harga;
      }
      if (element.sumber == "Nota Jual") {
        totalNotaBeli += element.harga;
        totalPendapatan += element.harga;
      }
      if (element.sumber == "Nota Beli") {
        totalPengeluaran += element.harga;
        totalNotaBeli += element.harga;
      }
      if (element.sumber == "Maintain") {
        totalPengeluaran += element.harga;
        tahunMaintain += element.harga;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var bold = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );
    var light = TextStyle(
      fontSize: 14,
    );
    log(dropdownValue2);
    log(dropdownValue);
    log(list.indexOf(dropdownValue2).toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Row(
                children: [
                  DropdownButton<int>(
                    value: ropdownValue2,
                    elevation: 16,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    underline: Container(
                      height: 2.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onChanged: (int? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        ropdownValue2 = value!;
                      });
                      test();
                    },
                    items: tahun.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                color: Colors.black)),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    underline: Container(
                      height: 2.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onChanged: (String? value) {
                      if (list.indexOf(value!) > list.indexOf(dropdownValue2)) {
                        return;
                      }
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                      test();
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                color: Colors.black)),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Icon(Icons.arrow_forward_rounded),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue2,
                    elevation: 16,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    underline: Container(
                      height: 2.5,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue2 = value!;
                      });
                      test();
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Card(
                elevation: 10,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: Column(
                  children: [
                    Center(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/title.png',width: 400,),
                        ),  
                        Text('Laporan Kas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        Text(""),
                        Text("Periode "+ropdownValue2.toString() +
                            " " +
                            dropdownValue +
                            " - " +
                            dropdownValue2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                      ]),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Saldo Awal",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(saldoAwal),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Pemasukan :",
                            style: bold,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "                  Transaksi",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(totalTransaksi),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "                  Jual Unit",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(totalJualUnit),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "                  Nota Jual",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(totalNotaJual),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.green.withOpacity(0.2),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Total Pemasukan",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(totalPendapatan),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Pengeluaran :",
                            style: bold,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "                  Maintain",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(tahunMaintain),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "                  Beli Unit",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(toalBeliUnit),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "                  Nota Beli",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(totalNotaBeli),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.red.withOpacity(0.2),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Total Pengeluaran",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(totalPengeluaran),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Laba Bersih ( Pemasukan - Pengeluaran )",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(totalPendapatan + totalPengeluaran),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Saldo Akhir ( Saldo Awal + Laba Bersih )",
                            style: bold,
                          )),
                          Expanded(
                              child: Text(
                            Rupiah.format(saldoAkhir),
                            style: light,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
