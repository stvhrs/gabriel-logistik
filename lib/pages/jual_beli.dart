
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/jualbeli/beli_add.dart';
import 'package:gabriel_logistik/jualbeli/jual_delete.dart'; 
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/supir/edit_supir.dart';
import 'package:gabriel_logistik/supir/tambah_supir.dart';
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
                'Jual Beli Mobil',
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
                              .searchSupir(val.toLowerCase());
                        },
                      ),
                    ),
                  ),
                  const Expanded(flex: 4, child: SizedBox()),
                  JualDelete(), 
                  BeliAdd()
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
                    Expanded(flex: 11, child: Text('Nomor Hp',style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(flex: 3, child: Text(' Aksi',style: Theme.of(context).textTheme.displayMedium))
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
                      itemCount: c.listSupir.reversed.toList().length,
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
                                  child: Text(c.listSupir[index].nama_supir)),
                              Expanded(
                                  flex: 3,
                                  child: Text(c.listSupir[index].nohp_supir)),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EditSupir(c.listSupir[index]),
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
