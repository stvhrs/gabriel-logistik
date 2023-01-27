import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/bulanan/bulanan.dart';
import 'package:gabriel_logistik/helper/totalPerbaikan.dart';
import 'package:gabriel_logistik/models/laporan_bulanan.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class LaporanBulanan extends StatefulWidget {
  const LaporanBulanan({super.key});

  @override
  State<LaporanBulanan> createState() => _LaporanBulananState();
}

class _LaporanBulananState extends State<LaporanBulanan> {
  final DateTime asu = DateTime.now();
  final innerController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
        child: StaggeredGrid.count(axisDirection: AxisDirection.down,
          mainAxisSpacing: 50,
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          children: Provider.of<ProviderData>(context).backupListSupir.map((e) {
            List<Transaksi> transaksiBulanIni = [];
            double totalBersih = 0;
            double totalPerbaikan = 0;
            for (Transaksi element
                in Provider.of<ProviderData>(context).backupTransaksi) {
              if (element.supir == e.nama_supir &&
                  DateTime.parse(element.tanggalBerangkat).month == asu.month &&
                  DateTime.parse(element.tanggalBerangkat).year == asu.year) {
                transaksiBulanIni.add(element);
              }
              
            }
            for (var element in transaksiBulanIni) {
              totalBersih += (element.ongkos - element.keluar);
              totalPerbaikan +=
                  TotalPerbaikan.totalPerbaikan(element.listPerbaikan);
            }
            BulanSupir data = BulanSupir(e.nama_supir, transaksiBulanIni,
                totalBersih, 0, totalPerbaikan, 'Februari');

            return Bulanan(data);
          }).toList(),
        ));
  }
}
