import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_add.dart';
import 'package:gabriel_logistik/jualbeli/beli/beli_edit.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_add.dart';
import 'package:gabriel_logistik/jualbeli/jual/jual_edit.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class JualBeli extends StatefulWidget {
  const JualBeli({super.key});

  @override
  State<JualBeli> createState() => _JualBeliState();
}

class _JualBeliState extends State<JualBeli> {
//
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
       Container(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 0,bottom: 25),
              decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2),width: 10,strokeAlign:StrokeAlign.center ),color: Colors.white, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  Container(margin: EdgeInsets.zero,
                    padding: const EdgeInsets.only(right:30,left: 30,bottom: 10,top: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: const Text(
                      'Jual Beli',
                      style: TextStyle(
                          color: Colors.white,fontFamily: 'Nunito',
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      height: MediaQuery.of(context).size.height / 20,
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'Cari'),
                        onChanged: (val) {
                          Provider.of<ProviderData>(context, listen: false)
                              .searchJual(val.toLowerCase());
                        },
                      ),
                    ),
                  ),
                  const Expanded(flex: 4, child: SizedBox()),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [const Spacer(), JualAdd(), const Spacer(), BeliAdd()],
                    ),
                  ),
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
                        flex: 1,
                        child: Text('Harga',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 3,
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
                // if (_search != '') {
                //   // c.listSupir.clear();
                //   for (var element in c.listSupir) {
                //     if (element.nama_supir
                //         .toLowerCase()
                //         .startsWith(_search.toLowerCase())) {
                //       c.listSupir.add(element);
                //     }
                //   }
                // } else {
                //   c.listSupir = c.listSupir;
                // }

                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: c.listJualBeliMobil.reversed.toList().length,
                      itemBuilder: (context, index) => InkWell(
                        child: Container(
                          color: !c.listJualBeliMobil[index].beli
                              ? Colors.red.shade100
                              : Colors.green.shade100,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(FormatTanggal.formatTanggal(
                                      c.listJualBeliMobil[index].tanggal))),
                              Expanded(
                                  flex: 3,
                                  child:
                                      Text(c.listJualBeliMobil[index].mobil)),
                              Expanded(
                                  flex: 1,
                                  child: Text(Rupiah.format(
                                      c.listJualBeliMobil[index].harga))),
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                      c.listJualBeliMobil[index].keterangan)),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    c.listJualBeliMobil[index].beli
                                        ? BeliEdit(c.listJualBeliMobil[index])
                                        : JualEdit(c.listJualBeliMobil[index]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
              })
            ],
          ))
    ]);
  }
}
