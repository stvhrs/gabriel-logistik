import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/cashflow/delete_pendaptan.dart';
import 'package:gabriel_logistik/cashflow/edit_pendapta.dart';
import 'package:gabriel_logistik/cashflow/tambah_pendaptan.dart';
import 'package:gabriel_logistik/cashflow/view_pendaptan.dart';

import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_add.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_edit.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_add.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_edit.dart';
import 'package:gabriel_logistik/models/mutasi_saldo.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class CashFlow extends StatefulWidget {
  const CashFlow({super.key});

  @override
  State<CashFlow> createState() => _CashFlowState();
}

class _CashFlowState extends State<CashFlow> {
  int currentSegment = 0;
  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment = newValue!;
    });
  }

  final children = <int, Widget>{
    0: const Text('Masuk', style: TextStyle(fontFamily: 'Nunito')),
    1: const Text('Keluar', style: TextStyle(fontFamily: 'Nunito')),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                width: 10,
                strokeAlign: StrokeAlign.center),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
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
                'Uang ' + (currentSegment == 0 ? 'Masuk' : 'Keluar'),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: CupertinoSlidingSegmentedControl<int>(
                      children: children,
                      onValueChanged: onValueChanged,
                      groupValue: currentSegment,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            Provider.of<ProviderData>(context, listen: false)
                                    .isOwner
                                ? [
                                    const Spacer(),
                                    TambahPendapatan(currentSegment == 0)
                                  ]
                                : []),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Tanggal',
                        style: Theme.of(context).textTheme.displayMedium,
                      )),
                  Expanded(
                      flex: 3,
                      child: Text('Keterangan',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 3,
                      child: Text(
                          'Total ' + (currentSegment == 0 ? "Masuk" : "Keluar"),
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 1,
                      child: Text('Aksi',
                          style: Theme.of(context).textTheme.displayMedium))
                ],
              ),
            ),
            Consumer<ProviderData>(builder: (context, c, h) {
              List<MutasiSaldo> listMutasi = [];
              List<MutasiSaldo> listMutasi2 = [];
              if (currentSegment == 0) {
                for (var element in c.listMutasiSaldo) {
                  if (element.pendapatan) {
                    listMutasi.add(element);
                  }
                }
              }
              if (currentSegment == 1) {
                for (var element in c.listMutasiSaldo) {
                  if (!element.pendapatan) {
                    listMutasi2.add(element);
                  }
                }
              }
              return currentSegment == 0
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          itemCount: listMutasi.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                color: index.isEven
                                    ? const Color.fromARGB(255, 189, 193, 221)
                                    : Colors.grey.shade200,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(FormatTanggal.formatTanggal(
                                            listMutasi[index].tanggal))),
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Text(listMutasi[index].keterangan)),
                                    Expanded(
                                        flex: 3,
                                        child: Text(Rupiah.format(
                                            listMutasi[index].totalMutasi))),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            EditPendaptan(currentSegment == 0,
                                                listMutasi[index]),
                                            ViewPendapatan(currentSegment == 0,
                                                listMutasi[index]),
                                            Provider.of<ProviderData>(context,
                                                        listen: false)
                                                    .isOwner
                                                ? DeletePendaptan(
                                                    listMutasi[index])
                                                : SizedBox()
                                          ],
                                        )),
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: currentSegment == 1
                                    //         ? JualEdit(listMutasi[index])
                                    //         : BeliEdit(
                                    //             listMutasi[index]))
                                  ],
                                ),
                              ),
                            );
                          }))
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          itemCount: listMutasi2.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                color: index.isEven
                                    ? const Color.fromARGB(255, 189, 193, 221)
                                    : Colors.grey.shade200,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(FormatTanggal.formatTanggal(
                                            listMutasi2[index].tanggal))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                            listMutasi2[index].keterangan)),
                                    Expanded(
                                        flex: 3,
                                        child: Text(Rupiah.format(
                                            listMutasi2[index].totalMutasi))),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            EditPendaptan(currentSegment == 0,
                                                listMutasi2[index]),
                                            ViewPendapatan(currentSegment == 0,
                                                listMutasi2[index]),
                                            Provider.of<ProviderData>(context,
                                                        listen: false)
                                                    .isOwner
                                                ? DeletePendaptan(
                                                    listMutasi2[index])
                                                : SizedBox()
                                          ],
                                        )),
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: currentSegment == 1
                                    //         ? JualEdit(listMutasi[index])
                                    //         : BeliEdit(
                                    //             listMutasi[index]))
                                  ],
                                ),
                              ),
                            );
                          }));
            })
          ],
        ));
  }
}
