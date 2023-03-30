import 'package:flutter/material.dart';
import 'package:gabriel_logistik/bulanan/bulanan.dart';

import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/prints.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

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

class LaporanBulanan extends StatefulWidget {
  const LaporanBulanan({super.key});

  @override
  State<LaporanBulanan> createState() => _LaporanBulananState();
}

class _LaporanBulananState extends State<LaporanBulanan> {
  List<int> tahun = [];

  final innerController = ScrollController();
  List<Mobil> mobil = [];
  List<Transaksi> trankaskis = [];
  String dropdownValue = list[DateTime.now().month - 1];
  int ropdownValue2 = DateTime.now().year;
  List<KeuanganBulanan> listKeuangan = [];
  @override
  void didChangeDependencies() {
    trankaskis = Provider.of<ProviderData>(context).backupTransaksi;
    mobil = Provider.of<ProviderData>(context).backupListMobil;
    for (var element in Provider.of<ProviderData>(context).backupTransaksi) {
      if (!tahun.contains(DateTime.parse(element.tanggalBerangkat).year)) {
        tahun.add(DateTime.parse(element.tanggalBerangkat).year);
      }
    }
    if (!tahun.contains(ropdownValue2)) {
      tahun.add(ropdownValue2);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.print),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LaporanPrint(listKeuangan),
            ));
          }),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                DropdownButton<int>(
                  value: ropdownValue2,
                  elevation: 16,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  underline: Container(
                    height: 2.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onChanged: (int? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      ropdownValue2 = value!;
                    });
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  underline: Container(
                    height: 2.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.89,
            child: ListView(
              children: Provider.of<ProviderData>(context).listMobil.map((e) {
                List<Transaksi> transaksiBulanIni = [];
                double totalPengeluaran = 0;
                double totalBersih = 0;
                List<Pengeluaran> listPengeluaran = [];
                double totalOngkos = 0;
                double totalKeluar = 0;
                double totalSisa = 0;

                transaksiBulanIni = Provider.of<ProviderData>(context)
                    .backupTransaksi
                    .where((element) =>
                        element.mobil == e.nama_mobil &&
                        DateTime.parse(element.tanggalBerangkat).month ==
                            list.indexOf(dropdownValue) + 1 &&
                        DateTime.parse(element.tanggalBerangkat).year ==
                            ropdownValue2)
                    .toList();
                e.pengeluaran = Provider.of<ProviderData>(context)
                    .backupListPengeluaran
                    .where((element) =>
                        element.mobil == e.nama_mobil &&
                        DateTime.parse(element.tanggal).month ==
                            list.indexOf(dropdownValue) + 1 &&
                        DateTime.parse(element.tanggal).year == ropdownValue2)
                    .toList();

                // }
                for (var element in transaksiBulanIni) {
                  totalBersih += element.sisa;
                  totalOngkos += element.ongkos;
                  totalKeluar += element.keluar;
                  totalSisa += element.sisa;
                }
                for (var pengeluaran in e.pengeluaran) {
                  totalPengeluaran = totalPengeluaran + pengeluaran.harga;
                  listPengeluaran.add(pengeluaran);
                }
                totalBersih -= totalPengeluaran;

                KeuanganBulanan data = KeuanganBulanan(
                    e.nama_mobil,
                    transaksiBulanIni,
                    listPengeluaran,
                    totalBersih,
                    totalOngkos,
                    totalKeluar,
                    totalSisa,
                    totalPengeluaran,
                    list[list.indexOf(dropdownValue)]);
                    if(transaksiBulanIni.isNotEmpty && e.pengeluaran.isNotEmpty){
                        listKeuangan.add(data);
                    }
              
                return transaksiBulanIni.isEmpty && e.pengeluaran.isEmpty
                    ? SizedBox()
                    : Bulanan(data);
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
