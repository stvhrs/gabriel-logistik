
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/mobil/delete_mobil.dart'; 
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
  @override
  void initState() {
     Provider.of<ProviderData>(context, listen: false)
                              .searchMobil('',false);
    super.initState();
  }
//
  @override
  Widget build(BuildContext context) {
    return
        Container(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 0,bottom: 25),
              decoration: BoxDecoration( border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2),width: 10,strokeAlign:StrokeAlign.center ),color: Colors.white, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  Container(margin: const EdgeInsets.only(bottom: 30),
                    padding: const EdgeInsets.only(right:30,left: 30,bottom: 10,top: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: const Text(
                      'Daftar Mobil',
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
                              style: TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'Cari'),
                        onChanged: (val) {
                          Provider.of<ProviderData>(context, listen: false)
                              .searchMobil(val.toLowerCase(),true);
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
                    Expanded(flex: 11, child: Text('No Pol',style: Theme.of(context).textTheme.displayMedium,)),
                    Expanded(flex: 11, child: Text('Keterangan',style: Theme.of(context).textTheme.displayMedium)),
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
                      itemBuilder: (context, index) => c.listMobil[index].terjual?const SizedBox(): InkWell(
                        child: Container(
                          color: index.isEven
                              ? const Color.fromARGB(255, 189, 193, 221)
                              : Colors.grey.shade200,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 11,
                                  child: Text(c.listMobil[index].nama_mobil)),
                              Expanded(
                                  flex: 11,
                                  child: Text(c.listMobil[index].keterangan_mobill)),
                              Expanded(
                                flex: 3,
                                child: Row(
                                
                                  children: [
                                    EditMobil(c.listMobil[index]),
                                   Provider.of<ProviderData>(context, listen: false)
                                    .isOwner?   DeleteMobil(c.listMobil[index]):const SizedBox()
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
          ));
   
  }
}
