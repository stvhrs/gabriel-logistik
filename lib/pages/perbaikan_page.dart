import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../perbaikan/perbaikan_add.dart';
import '../perbaikan/perbaikan_delete.dart';
import '../perbaikan/perbaikan_edit.dart';

class PerbaikanPage extends StatefulWidget {
  const PerbaikanPage({super.key});

  @override
  State<PerbaikanPage> createState() => _PerbaikanPageState();
}

class _PerbaikanPageState extends State<PerbaikanPage> {
//
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
                  right: 30, left: 30, bottom: 10, top: 5),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: const Text(
                'Perbaikan',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
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
                              style: TextStyle(fontSize:13),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Cari'),
                      onChanged: (val) {
                        Provider.of<ProviderData>(context, listen: false)
                            .searchperbaikan(val.toLowerCase());
                      },
                    ),
                  ),
                ),
                const Expanded(flex: 4, child: SizedBox()),
                PerbaikanAdd()
              ],
            ),
            Container(
              color: Theme.of(context).primaryColor,
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
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
                      child: Text('No Pol',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 11,
                      child: Text('Jenis',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 11,
                      child: Text('Perbaikan',
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
                    itemCount: c.listPerbaikan.reversed.toList().length,
                    itemBuilder: (context, index) => InkWell(
                      child: Container(
                        color: index.isEven
                            ? const Color.fromARGB(255, 189, 193, 221)
                            : Colors.grey.shade200,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 11,
                                child: Text(FormatTanggal.formatTanggal(
                                    c.listPerbaikan[index].tanggal))),
                            Expanded(
                                flex: 11,
                                child: Text(c.listPerbaikan[index].mobil)),
                            Expanded(
                                flex: 11,
                                child: Text(c.listPerbaikan[index].jenis)),
                            Expanded(
                                flex: 11,
                                child: Text(Rupiah.format(
                                    c.listPerbaikan[index].harga))),
                            Expanded(
                                flex: 20,
                                child: Text(c.listPerbaikan[index].keterangan)),
                            Expanded(
                                flex: 2,
                                child: Provider.of<ProviderData>(context)
                                        .isOwner
                                    ? PerbaikanDelete(c.listPerbaikan[index])
                                    : const SizedBox()),
                            Expanded(
                                flex: 2,
                                child: PerbaikanEdit(c.listPerbaikan[index]))
                          ],
                        ),
                      ),
                    ),
                  ));
            })
          ],
        ));
  }
}
