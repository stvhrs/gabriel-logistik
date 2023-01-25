import 'package:flutter/material.dart';
import 'package:gabriel_logistik/mobil/edit_pelanggan.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:gabriel_logistik/supir/tambah_supir.dart';
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
                'Daftar Supir',
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
                  TambahPelanggan()
                ],
              ),
              Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(flex: 11, child: Text('Mobil')),
                    Expanded(flex: 11, child: Text('Alamat')),
                    Expanded(flex: 11, child: Text('Nomor Polisi')),
                    Expanded(flex: 3, child: Text('       Aksi'))
                  ],
                ),
              ),
              Consumer<ProviderData>(builder: (context, c, h) {
            
          
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: c.listMobil.length,
                      itemBuilder: (context, index) => InkWell(
                        child: Container(
                          color: index.isEven
                              ? const Color.fromARGB(255, 193, 216, 226)
                              : Colors.transparent,
                          padding: const EdgeInsets.only(left: 15, right: 0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(c.listMobil[index].nama_mobil)),
                              Expanded(
                                  flex: 3,
                                  child: Text(c.listMobil[index].id_mobil.toString())),
                              Expanded(
                                  flex: 3,
                                  child: Text(c.listMobil[index].nama_mobil)),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EditMobil(c.listMobil[index]),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.delete,
                                          size: 16,
                                          color: Colors.red.shade700,
                                        )),
                                    const Spacer(),
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
