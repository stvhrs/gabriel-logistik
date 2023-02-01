
import 'package:flutter/material.dart'; 
import 'package:gabriel_logistik/bulanan/bulanan.dart';
import 'package:gabriel_logistik/helper/totalPerbaikan.dart';
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

class LaporanBulanan extends StatefulWidget {
  const LaporanBulanan({super.key});

  @override
  State<LaporanBulanan> createState() => _LaporanBulananState();
}

class _LaporanBulananState extends State<LaporanBulanan> {
  List<int> tahun = [];
  final DateTime asu = DateTime.now();
  final innerController = ScrollController();

  String dropdownValue = list[DateTime.now().month - 1];
  int ropdownValue2 = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    for (var element in Provider.of<ProviderData>(context).backupTransaksi) {
      if (!tahun.contains(DateTime.parse(element.tanggalBerangkat).year)) {
        tahun.add(DateTime.parse(element.tanggalBerangkat).year);
      }
    }
    return Scaffold(resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [ DropdownButton<int>(
                  value: ropdownValue2,
                  elevation: 16,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
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
                          style:const TextStyle(fontSize: 16,fontFamily: 'Nunito',color: Colors.black)),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
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
                          style:const TextStyle(fontSize: 16,fontFamily: 'Nunito',color: Colors.black)),
                    );
                  }).toList(),
                ),
               
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                axisDirection: AxisDirection.down,
                mainAxisSpacing: 50,
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                children:
                    Provider.of<ProviderData>(context).backupListSupir.map((e) {
                  List<Transaksi> transaksiBulanIni = [];
                  double totalBersih = 0;
                  double totalPerbaikan = 0;
                  // for (Transaksi element
                  //     in Provider.of<ProviderData>(context).backupTransaksi) {
                 transaksiBulanIni=  Provider.of<ProviderData>(context).backupTransaksi.where((element) => 
                 element.supir==e.nama_supir&&
                  DateTime.parse(element.tanggalBerangkat).month ==
                            list.indexOf(dropdownValue)+1 &&
                        DateTime.parse(element.tanggalBerangkat).year ==
                            ropdownValue2).toList();
                    // if (element.supir == e.nama_supir &&
                    //     DateTime.parse(element.tanggalBerangkat).month ==
                    //         list.indexOf(dropdownValue)+1 &&
                    //     DateTime.parse(element.tanggalBerangkat).year ==
                    //         ropdownValue2) {
                    //   transaksiBulanIni.add(element);
                    // }
                  // }
                  for (var element in transaksiBulanIni) {
                    totalBersih += (element.ongkos - element.keluar);
                    totalPerbaikan +=
                        TotalPerbaikan.totalPerbaikan(element.listPerbaikan);
                  }
                  BulanSupir data = BulanSupir(
                      e.nama_supir,
                      transaksiBulanIni,
                      totalBersih-totalPerbaikan,
                      0,
                      totalPerbaikan,
                      list[list.indexOf(dropdownValue)  ]);
    
                  return Bulanan(data);
                }).toList(),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
