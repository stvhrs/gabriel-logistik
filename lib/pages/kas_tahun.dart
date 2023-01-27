import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/bulanan/bulanan.dart';
import 'package:gabriel_logistik/helper/totalPerbaikan.dart';
import 'package:gabriel_logistik/kas/kas.dart';
import 'package:gabriel_logistik/models/kas_tahun.dart';
import 'package:gabriel_logistik/models/laporan_bulanan.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  KasTahun({super.key});

  @override
  State<KasTahun> createState() => _KasTahunState();
}

class _KasTahunState extends State<KasTahun> {
  List<int> tahun = [];

  final innerController = ScrollController();

  int ropdownValue2 = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    for (var element in Provider.of<ProviderData>(context).backupTransaksi) {
      if (!tahun.contains(DateTime.parse(element.tanggalBerangkat).year)) {
        tahun.add(DateTime.parse(element.tanggalBerangkat).year);
      }
    }
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
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
                        style: TextStyle(
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
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: StaggeredGrid.count(
              axisDirection: AxisDirection.down,
              mainAxisSpacing: 50,
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              children:
                  Provider.of<ProviderData>(context).backupListSupir.map((e) {
                    double totalBersihTahun=0;
                    double totalPerbaikanTahun=0;
                KasModel asu = KasModel(e.nama_supir, [], 0, 0, 0);
                for (var moon in list) {
                  double totalBersih = 0;
                  double totalPerbaikan = 0;
                  double totalPersenSupir = 0;

                  List<Transaksi> transaksiBulanIni = [];
                  transaksiBulanIni = Provider.of<ProviderData>(context)
                      .backupTransaksi
                      .where((element) =>
                          e.nama_supir == element.supir &&
                          DateTime.parse(element.tanggalBerangkat).month ==
                              list.indexOf(moon) + 1 &&
                          DateTime.parse(element.tanggalBerangkat).year ==
                              ropdownValue2)
                      .toList();
                          for (var element in transaksiBulanIni) {
                  totalBersih += (element.ongkos - element.keluar);
                  totalPerbaikan +=
                      TotalPerbaikan.totalPerbaikan(element.listPerbaikan);
                      
                }
                  if (transaksiBulanIni.isNotEmpty) {
                  
                    BulanSupir data = BulanSupir(
                        e.nama_supir,
                        transaksiBulanIni,
                        totalBersih - totalPerbaikan,
                        0,
                        totalPerbaikan,
                        list[DateTime.parse(
                                    transaksiBulanIni[0].tanggalBerangkat)
                                .month -
                            1]);

                    asu.listBulananSupir.add(data);
                  }
                }
     for (var element in asu.listBulananSupir) {
                asu.  totalBersih += element.totalBersih;
             asu.     totalPerbaikan +=
                      element.totalPerbaikan;
                      
                }
                return Kas(asu);
              }).toList(),
            ),
          ),
        ),
      ]),
    );
  }
}
