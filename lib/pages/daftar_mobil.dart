
import 'package:flutter/material.dart'; 
import 'package:gabriel_logistik/mobil/edit_mobil.dart';
import 'package:gabriel_logistik/mobil/tambah_mobil.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class DaftarMobil extends StatefulWidget {
  const DaftarMobil({super.key});

  @override
  State<DaftarMobil> createState() => _DaftarMobilState();
}

class _DaftarMobilState extends State<DaftarMobil> {
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
                'Daftar Mobil',
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
                              .searchMobil(val.toLowerCase());
                        },
                      ),
                    ),
                  ),
                  const Expanded(flex: 4, child: SizedBox()),
                  TambahMobil()
                ],
              ),
              Container(
                color:Theme.of(context).primaryColor,
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Expanded(flex: 11, child: Text('Nama',style: Theme.of(context).textTheme.displayMedium,)),
                    Expanded(flex: 11, child: Text('Nomor Polisi',style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(flex: 3, child: Text(' Aksi',style: Theme.of(context).textTheme.displayMedium))
                  ],
                ),
              ),
              Consumer<ProviderData>(builder: (context, c, h) {
                // if (_search != '') {
                //   // c.listMobil.clear();
                //   for (var element in c.listMobil) {
                //     if (element.nama_supir
                //         .toLowerCase()
                //         .startsWith(_search.toLowerCase())) {
                //       c.listMobil.add(element);
                //     }
                //   }
                // } else {
                //   c.listMobil = c.listMobil;
                // }

                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: c.listMobil.reversed.toList().length,
                      itemBuilder: (context, index) => InkWell(
                        child: Container(
                          color: index.isEven
                              ? const Color.fromARGB(255, 189, 193, 221)
                              : Colors.grey.shade200,
                          padding: const EdgeInsets.only(left: 15, right: 0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(c.listMobil[index].nama_mobil)),
                              Expanded(
                                  flex: 3,
                                  child: Text(c.listMobil[index].keterangan_mobill)),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EditMobil(c.listMobil[index]),
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
