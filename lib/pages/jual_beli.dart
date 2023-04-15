import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_add.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_edit.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_add.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_edit.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class JualBeli extends StatefulWidget {
  const JualBeli({super.key});

  @override
  State<JualBeli> createState() => _JualBeliState();
}

class _JualBeliState extends State<JualBeli> {
  int currentSegment = 0;
  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment = newValue!;
    });
  }

  final children = <int, Widget>{
    0: const Text('Beli',style: TextStyle(fontFamily: 'Nunito')),
    1: const Text('Jual',style: TextStyle(fontFamily: 'Nunito')),
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
                  right: 30, left: 30, bottom: 10, ),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: const Text(
                'Inventory',
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
                                    currentSegment == 0 ? BeliAdd() : JualAdd(),
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
                      child: Text('Mobil',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 3,
                      child: Text('Harga',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 6,
                      child: Text('Keterangan',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 1,
                      child: Text('Aksi',
                          style: Theme.of(context).textTheme.displayMedium))
                ],
              ),
            ),
            Consumer<ProviderData>(builder: (context, c, h) {
                 List<JualBeliMobil> listMutasi=[];
                List<JualBeliMobil> listMutasi2=[];
                      if(currentSegment==0){
                        for (var element in c.listJualBeliMobil) {
                          if(element.beli){  listMutasi.add(element);}
                        
                        }
                      }
                      if(currentSegment==1){
                        for (var element in c.listJualBeliMobil) {
                          if(!element.beli){  listMutasi2.add(element);}
                        
                        }
                      }
              return currentSegment==0?
               SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: listMutasi.length,
                    itemBuilder: (context, index) => InkWell(
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
                                      child: Text(
                                         listMutasi[index].mobil)),
                                  Expanded(
                                      flex: 3,
                                      child: Text(Rupiah.format(
                                         listMutasi[index].harga))),
                                  Expanded(
                                      flex: 6,
                                      child: Text(c.listJualBeliMobil[index]
                                          .keterangan)),
                                  Expanded(
                                      flex: 1,
                                      child: BeliEdit(
                                             listMutasi[index]))
                                ],
                              ),
                            ),
                          ))):SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: listMutasi2.length,
                    itemBuilder: (context, index) => InkWell(
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
                                         listMutasi2[index].mobil)),
                                  Expanded(
                                      flex: 3,
                                      child: Text(Rupiah.format(
                                         listMutasi2[index].harga))),
                                  Expanded(
                                      flex: 6,
                                      child: Text(listMutasi2[index]
                                          .keterangan)),
                                  Expanded(
                                      flex: 1,
                                      child: JualEdit(
                                             listMutasi2[index]))
                                ],
                              ),
                            ),
                          )));
                        
            })
          ],
        ));
  }
}
