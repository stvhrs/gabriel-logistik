import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/pengeluaran/pengeluaran_add.dart';
import 'package:gabriel_logistik/pengeluaran/pengeluaran_delete.dart';
import 'package:gabriel_logistik/pengeluaran/pengeluaran_edit.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/services/service.dart';
import 'package:gabriel_logistik/supir/edit_supir.dart';
import 'package:gabriel_logistik/supir/tambah_supir.dart';
import 'package:provider/provider.dart';

class PengeluaranPage extends StatefulWidget {
  const PengeluaranPage({super.key});

  @override
  State<PengeluaranPage> createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
//
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
          decoration: BoxDecoration(boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              spreadRadius: 3,
              offset: Offset(2, 2),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              const Text(
                'Pengeluaran',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                              .searchPengeluaran(val.toLowerCase());
                        },
                      ),
                    ),
                  ),
                  const Expanded(flex: 4, child: SizedBox()),
                  PengelauaranAdd()
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
                        flex: 11,
                        child: Text(
                          'Tanggal',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 11,
                        child: Text('Mobil',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 11,
                        child: Text('Jenis',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 11,
                        child: Text('Pengeluaran',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 20,
                        child: Text('Keterangan',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                      flex: 4,
                      child: Text('Aksi',
                          style: Theme.of(context).textTheme.displayMedium),
                    )
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
                      itemCount: c.listPengeluaran.reversed.toList().length,
                      itemBuilder: (context, index) => InkWell(
                        child: Container(
                          color: index.isEven
                              ? const Color.fromARGB(255, 189, 193, 221)
                              : Colors.grey.shade200,
                          padding: const EdgeInsets.only(left: 15, right: 0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 11,
                                  child: Text(FormatTanggal.formatTanggal(
                                      c.listPengeluaran[index].tanggal))),
                              Expanded(
                                  flex: 11,
                                  child: Text(c.listPengeluaran[index].mobil)),
                              Expanded(
                                  flex: 11,
                                  child: Text(c.listPengeluaran[index].jenis)),
                              Expanded(
                                  flex: 11,
                                  child: Text(Rupiah.format(
                                      c.listPengeluaran[index].harga))),
                              Expanded(
                                  flex: 20,
                                  child: Text(
                                      c.listPengeluaran[index].keterangan)),
                              Expanded(
                                  flex: 2,
                                  child: PengeluaranDelete(
                                      c.listPengeluaran[index])),
                              Expanded(
                                  flex: 2,
                                  child: PengelauaranEdit(
                                      c.listPengeluaran[index]))
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
