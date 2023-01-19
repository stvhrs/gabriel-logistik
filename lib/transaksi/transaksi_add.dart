// import 'package:gabriel_logistik/models/transaksi.dart';
// import 'package:gabriel_logistik/providerData/providerData.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

// import 'package:provider/provider.dart';


// import '../helper/dropdown.dart';
// import '../helper/input_currency.dart';

// class TransaksiAdd extends StatefulWidget {
//   const TransaksiAdd({super.key});

//   @override
//   State<TransaksiAdd> createState() => _TransaksiAddState();
// }

// class _TransaksiAddState extends State<TransaksiAdd> {
 
//   final TextEditingController _controller = TextEditingController();
//   int jumlahOpsi = 1;


//   List<Transaksi> _updatedTransaksi = [
//     // Transaksi(
//     // )
//   ];
//   List<String> itemsTransaksi = [];
//   Widget _buildPartName(int i, BuildContext context) {
//     List<Transaksi> transaksi =
//         Provider.of<ProviderData>(context, listen: false).listTransaksi;
//     return Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         child: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) => Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 200,
//                       child: DropDownField(
//                         inputFormatters: const [],
//                         required: true,
//                         onValueChanged: (val) {
//                           if (transaksi
//                               .map((e) => e.supir)
//                               .toList()
//                               .contains(val)) {
//                             if (_updatedTransaksi.length < i + 1) {
//                               _updatedTransaksi.insert(
//                                   i,
//                                   transaksi.firstWhere(
//                                       (element) => element.supir == val));
//                             }

//                             setState(() {});
//                           }
//                         },
//                         strict: true,
//                         labelText: 'PartName',
//                         items: transaksi.map((e) => e.supir).toList(),
//                       ),
//                     ),
//                     const Spacer(),
//                     SizedBox(
//                       width: 200,
//                       child: TextFormField(
//                         decoration: const InputDecoration(hintText: 'Perbaikan'),
//                         onChanged: (value) {
//                           if (_updatedTransaksi.isNotEmpty) {
//                             _updatedTransaksi[i].extendedCost[i]['harga'] =
//                                 NumberFormat.currency(
//                                         locale: 'id_ID', symbol: 'Rp ')
//                                     .parse(value)
//                                     .toDouble();
//                           }
//                         },
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           CurrencyInputFormatter()
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {});
//                           if (  _updatedTransaksi[i].extendedCost.length > 1) {
//                             setState(() {
//                                 _updatedTransaksi[i].extendedCost.length--;
//                               //   _updatedTransaksi[i].extendedCost[i]['harga']--;
//                             });
//                           }
//                         },
//                         icon: const Icon(Icons.remove_circle)),
//                     Text(  _updatedTransaksi[i].extendedCost.length.toString()),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                                _updatedTransaksi[i].extendedCost.length++;
//                             //   _updatedTransaksi[i].extendedCost[i]['harga']++;
//                           });
//                         },
//                         icon: const Icon(Icons.add_circle)),
//                   ],
//                 )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Transaksi> Transaksis =
//         Provider.of<ProviderData>(context, listen: false).listTransaksi;
//     // List<Transaksi> transaksi =
//     //     Provider.of<Trigger>(context, listen: false).listSelectedTransaksi;
//     // List<Penyuplai> penyuplais =
//     //     Provider.of<Trigger>(context, listen: false).listSelectedPenyuplai;

//     // if (_updatedTransaksi.isNotEmpty) {
//     //   for ( e in penyuplais) {
//     //     if (!itemsTransaksi.contains(e.namaPenyuplai)) {
//     //       itemsTransaksi.add(e.namaPenyuplai);
//     //     }
//     //   }
//     // }

//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       child: ElevatedButton.icon(  icon: const Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//           label: const Text(
//             'Tambah Pembelian',
//             style: TextStyle(color: Colors.white),
//           ),
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(
//                   const Color.fromARGB(255, 79, 117, 134))),
//           onPressed:() {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return 
//                         AlertDialog(
//                             actionsPadding:
//                                 const EdgeInsets.only(right: 15, bottom: 15),
//                             title: const Text("Tambah Pembelian"),
//                             content: StatefulBuilder(
//                               builder: (BuildContext context,
//                                       StateSetter setState) =>
//                                   IntrinsicHeight(
//                                 child: SizedBox(
//                                   width: 500,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
                                    
                                     
//                                       ...List.generate(
//                                           jumlahOpsi,
//                                           (index) =>
//                                               _buildPartName(index, context)),
//                                       Row(
//                                         children: [
//                                           IconButton(
//                                               onPressed: () {
//                                                 setState(() {
//                                                   if (jumlahOpsi > 1 &&
//                                                       jumlahOpsi ==
//                                                           _updatedTransaksi
//                                                               .length) {
//                                                     _updatedTransaksi.removeAt(
//                                                         jumlahOpsi - 1);
//                                                     _updatedTransaksi
//                                                         .removeAt(
//                                                             jumlahOpsi - 1);
//                                                     jumlahOpsi = jumlahOpsi - 1;
//                                                   }
//                                                 });
//                                               },
//                                               icon: const Icon(
//                                                   Icons.remove_circle)),
//                                           // Text(jumlahOpsi.toString()),
                                       
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
                              
                           
                
//         ),
//     ));
  
// });})

// );
//   }
// }