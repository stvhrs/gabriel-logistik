
// import 'package:flutter/material.dart';
// import 'package:gabriel_logistik/helper/format_tanggal.dart';
// import 'package:gabriel_logistik/helper/rupiah_format.dart';
// import 'package:gabriel_logistik/mobil/delete_mobil.dart'; 
// import 'package:gabriel_logistik/mobil/edit_mobil.dart';
// import 'package:gabriel_logistik/mobil/tambah_mobil.dart';
// import 'package:gabriel_logistik/providerData/providerData.dart';
// import 'package:provider/provider.dart';

// class DaftarPengeluaran extends StatefulWidget {
//   const DaftarPengeluaran({super.key});

//   @override
//   State<DaftarPengeluaran> createState() => _DaftarPengeluaranState();
// }

// class _DaftarPengeluaranState extends State<DaftarPengeluaran> {
// //
//   @override
//   Widget build(BuildContext context) {
//     return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Container(
//           padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
//           decoration: BoxDecoration(boxShadow: const <BoxShadow>[
//             BoxShadow(
//               color: Colors.grey,
//               blurRadius: 4,
//               spreadRadius: 3,
//               offset: Offset(2, 2),
//             ),
//           ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
//           width: MediaQuery.of(context).size.width * 0.7,
//           child: Column(
//             children: [
//               const Text(
//                 'Daftar Mobil',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 5),
//                       height: MediaQuery.of(context).size.height / 20,
//                       child: TextFormField(
//                         decoration: const InputDecoration(hintText: 'Cari Mobil'),
//                         onChanged: (val) {
//                           Provider.of<ProviderData>(context, listen: false)
//                               .searchPengeluaran(val.toLowerCase());
//                         },
//                       ),
//                     ),
//                   ),
//                   const Expanded(flex: 4, child: SizedBox()),
//                   TambahMobil()
//                 ],
//               ),
//               Container(
//                 color:Theme.of(context).primaryColor,
//                 padding: const EdgeInsets.only(
//                     top: 8, bottom: 8, left: 15, right: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children:  [
//                     Expanded(flex: 11, child: Text('Tanggal',style: Theme.of(context).textTheme.displayMedium,)),
//                     Expanded(flex: 11, child: Text('Mobil',style: Theme.of(context).textTheme.displayMedium)),
               
//                        Expanded(flex: 3, child: Text('Harga',style: Theme.of(context).textTheme.displayMedium)),
//                         Expanded(flex: 3, child: Text('Keterangan',style: Theme.of(context).textTheme.displayMedium))
//                   ],
//                 ),
//               ),
//               Consumer<ProviderData>(builder: (context, c, h) {
//                 // if (_search != '') {
//                 //   // c.listPengeluaran.clear();
//                 //   for (var element in c.listPengeluaran) {
//                 //     if (element.nama_supir
//                 //         .toLowerCase()
//                 //         .startsWith(_search.toLowerCase())) {
//                 //       c.listPengeluaran.add(element);
//                 //     }
//                 //   }
//                 // } else {
//                 //   c.listPengeluaran = c.listPengeluaran;
//                 // }

//                 return SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.7,
//                     child: ListView.builder(
//                       itemCount: c.listPengeluaran.reversed.toList().length,
//                       itemBuilder: (context, index) => InkWell(
//                         child: Container(
//                           color: index.isEven
//                               ? const Color.fromARGB(255, 189, 193, 221)
//                               : Colors.grey.shade200,
//                           padding: const EdgeInsets.only(left: 15, right: 0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(FormatTanggal.formatTanggal(c.listPengeluaran[index].tanggal) )),   Expanded(
//                                   flex: 3,
//                                   child: Text(c.listPengeluaran[index].mobil)),    Expanded(
//                                   flex: 3,
//                                   child: Text(c.listPengeluaran[index].keterangan)),   
//                                     Expanded(
//                                   flex: 3,
//                                   child: Text(Rupiah.format( c.listPengeluaran[index].harga))),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(c.listPengeluaran[index].keterangan)),
//                               Expanded(
//                                 flex: 1,
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     EditMobil(c.listPengeluaran[index]),
//                                     DeleteMobil(c.listPengeluaran[index])
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ));
//               })
//             ],
//           ))
//     ]);
//   }
// }
