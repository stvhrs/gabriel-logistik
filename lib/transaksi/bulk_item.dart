import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

import '../helper/format_tanggal.dart';

class Bulkitem extends StatelessWidget {
  final int index;
  final Transaksi element;
  const Bulkitem(this.index,this.element);

  @override
  Widget build(BuildContext context) {
      TextStyle small = const TextStyle(fontSize: 13.5);
    return  Container(
                                                          color: index.isEven
                                                              ? Colors
                                                                  .grey.shade200
                                                              : const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  189,
                                                                  193,
                                                                  221),
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 2,
                                                                      bottom:
                                                                        2,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            Text(
                                                                          style:
                                                                              small,
                                                                          (index + 1)
                                                                              .toString(),
                                                                        )),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            maxLines:
                                                                                1,
                                                                            FormatTanggal.formatTanggal(element.tanggalBerangkat).toString())),
                                                                    Expanded(
                                                                        flex: 8,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            element.mobil)),
                                                                    Expanded(
                                                                        flex: 5,
                                                                        child:
                                                                            Text(
                                                                          style:
                                                                              small,
                                                                          element
                                                                              .supir,
                                                                        )),
                                                                    Expanded(
                                                                        flex:
                                                                            10,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            element.tujuan)),

                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            Rupiah.format(element.ongkos))),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            Rupiah.format(element.keluar))),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            Rupiah.format(element.sisa))),
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            // bulkTransaksi.remove(element);
                                                                            // setState(() {});
                                                                          },
                                                                          icon: const Icon(
                                                                            Icons.delete_forever,
                                                                            color:
                                                                                Colors.red,
                                                                          )),
                                                                    )
                                                                    // Expanded(
                                                                    //     flex: 7,
                                                                    //     child: Text(element.listPerbaikan.isEmpty
                                                                    //         ? "-"
                                                                    //         : Rupiah.format(
                                                                    //             totalPerbaikan(element.listPerbaikan)))),
                                                                  ]))
  );}
}