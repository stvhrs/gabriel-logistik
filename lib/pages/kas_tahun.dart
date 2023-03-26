import 'package:flutter/material.dart';

import 'package:gabriel_logistik/kas/kas.dart';
import 'package:gabriel_logistik/models/kas_tahun.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../models/keuangan_bulanan.dart';
import '../models/pengeluaran.dart';

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

class KasTahun extends StatefulWidget {
  const KasTahun({super.key});

  @override
  State<KasTahun> createState() => _KasTahunState();
}

class _KasTahunState extends State<KasTahun> {
  List<int> tahun = [];

  final innerController = ScrollController();

  int ropdownValue2 = DateTime.now().year;
  @override
  void didChangeDependencies() {
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
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
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
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView(
              children:
                  Provider.of<ProviderData>(context).backupListMobil.map((e) {
                double tahunTotalPengeluaran = 0;
                double tahunTotalBersih = 0;
                double tahunTotalOngkos = 0;
                double tahunTotalKeluar = 0;
                double tahunTotalSisa = 0;
                KasModel asu = KasModel(
                    e.nama_mobil, [], 0, 0, 0, 0, ropdownValue2.toString());
                for (var moon in list) {
                  List<Transaksi> transaksiBulanIni = [];
                  double totalPengeluaran = 0;
                  double totalBersih = 0;
                  double totalOngkos = 0;
                  double totalKeluar = 0;
                  double totalSisa = 0;
                  List<Pengeluaran> listPengeluaran = [];

                  transaksiBulanIni = Provider.of<ProviderData>(context)
                      .backupTransaksi
                      .where((element) =>
                          element.mobil == e.nama_mobil &&
                          DateTime.parse(element.tanggalBerangkat).month ==
                              list.indexOf(moon) + 1 &&
                          DateTime.parse(element.tanggalBerangkat).year ==
                              ropdownValue2)
                      .toList();
                  e.pengeluaran = Provider.of<ProviderData>(context)
                      .backupListPengeluaran
                      .where((element) =>
                          element.mobil == e.nama_mobil &&
                          DateTime.parse(element.tanggal).month ==
                              list.indexOf(moon) + 1 &&
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

                  print(totalPengeluaran);
                  KeuanganBulanan data = KeuanganBulanan(
                      e.nama_mobil,
                      transaksiBulanIni,
                      listPengeluaran,
                      totalBersih,
                      totalOngkos,
                      totalKeluar,
                      totalSisa,
                      totalPengeluaran,
                      list[list.indexOf(moon)]);

                  asu.listBulananMobil.add(data);
                  tahunTotalSisa += totalSisa;
                  tahunTotalBersih += totalBersih;
                  tahunTotalKeluar += totalKeluar;
                  tahunTotalOngkos += totalOngkos;
                  tahunTotalPengeluaran += totalPengeluaran;
                }
                return Kas(asu,tahunTotalOngkos,tahunTotalKeluar,tahunTotalSisa,tahunTotalPengeluaran,tahunTotalBersih);
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
