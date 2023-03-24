import 'package:flutter/material.dart';

import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import '../helper/rupiah_format.dart';

class Bulanan extends StatefulWidget {
  final KeuanganBulanan laporanBulanan;
  const Bulanan(this.laporanBulanan);

  @override
  State<Bulanan> createState() => _BulananState();
}

class _BulananState extends State<Bulanan> {
  final innerController = ScrollController();

  buildChildren() {
    if (widget.laporanBulanan.transaksiBulanIni.isEmpty) {
      return [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: const Center(child: Icon(Icons.question_mark_rounded)))
      ];
    } else {
      return widget.laporanBulanan.transaksiBulanIni.mapIndexed(
        (index, element) => Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: index.isEven
                  ? Colors.grey.shade200
                  : const Color.fromARGB(255, 189, 193, 221)),
          padding: const EdgeInsets.only(
            top: 14,
            bottom: 14,
            left: 15,
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(textAlign: TextAlign.left,
                       DateTime.parse(element.tanggalBerangkat)
                              .day
                              .toString()+', '+ DateFormat('EEEE', "id_ID").format(
                              DateTime.parse(element.tanggalBerangkat)) )
                      ),
              Expanded(
                  flex: 3,
                  child: Text(textAlign: TextAlign.left,element.supir,
                      )),
              Expanded(
                  flex: 10,
                  child: Text(textAlign: TextAlign.left,element.tujuan,
                      )),
              Expanded(
                  flex: 7,
                  child: Text(textAlign: TextAlign.left,Rupiah.format(element.ongkos),
                      )),
              Expanded(
                  flex: 7,
                  child: Text(textAlign: TextAlign.left,Rupiah.format(element.keluar),
                      )),

              Expanded(
                  flex: 7,
                  child: Text(textAlign: TextAlign.left,Rupiah.format(element.ongkos - element.keluar),
                      )),
              // Expanded(
              //   flex: 7,
              //   child: Text(textAlign: TextAlign.left,
              //       textAlign: TextAlign.left,
              //       element.listPerbaikan.isEmpty
              //           ? ''
              //           : Rupiah.format(totalPengeluaran.totalPengeluaran(
              //               element.listPerbaikan)),
              //       ),
              // ),
            
          ]),
        
      ));
    }
  }

buildChildren2() {
    if (widget.laporanBulanan.pengeluranBulanIni.isEmpty) {
      return [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: const Center(child: Icon(Icons.question_mark_rounded)))
      ];
    } else {
      return widget.laporanBulanan.pengeluranBulanIni.mapIndexed(
        (index, element) => Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: index.isEven
                  ? Colors.grey.shade200
                  :  Colors.white),
          padding: const EdgeInsets.only(
            top: 14,
            bottom: 14,
            left: 15,
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(textAlign: TextAlign.left,
                     
                          DateTime.parse(element.tanggal)
                              .day
                              .toString()+', '+ DateFormat('EEEE', "id_ID").format(
                              DateTime.parse(element.tanggal)) )
                          
                      ),
              Expanded(
                  flex: 5,
                  child: Text(textAlign: TextAlign.left,element.jenis,
                      )),
                      
              Expanded(
                  flex: 5,
                  child: Text(textAlign: TextAlign.left,Rupiah.format( element.harga),
                      )),
              Expanded(
                  flex: 7,
                  child: Text(textAlign: TextAlign.left,element.keterangan,
                      )),
              
              // Expanded(
              //   flex: 7,
              //   child: Text(textAlign: TextAlign.left,
              //       textAlign: TextAlign.left,
              //       element.listPerbaikan.isEmpty
              //           ? ''
              //           : Rupiah.format(totalPengeluaran.totalPengeluaran(
              //               element.listPerbaikan)),
              //       ),
              // ),
            ],
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(bottom: 50),
      child: Card(
        elevation: 5,
        color: Colors.white, surfaceTintColor: Colors.white,
        shadowColor: Theme.of(context).colorScheme.primary,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 7.5, bottom: 7.5),
                child: Text(textAlign: TextAlign.left,
                  '${widget.laporanBulanan.namaMobil} - ${widget.laporanBulanan .bulan}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 12.5, left: 15),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(textAlign: TextAlign.left,
                          'Tanggal',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 3,
                        child: Text(textAlign: TextAlign.left,
                          'Supir',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 10,
                        child: Text(textAlign: TextAlign.left,
                          'Tujuan',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(textAlign: TextAlign.left,
                          'Ongkos',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(textAlign: TextAlign.left,
                          'Keluar',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(textAlign: TextAlign.left,
                          'Sisa',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                  ],
                ),
              ),
              ...buildChildren(), 
           
               Container(margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.red.shade600
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 12.5, left: 15),
                child: Row(
                  children: [
                     Expanded(
                        flex: 3,
                        child: Text(textAlign: TextAlign.left,
                          'Tanggal',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 5,
                        child: Text(textAlign: TextAlign.left,
                          'Nama Pengeluaran',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 5,
                        child: Text(textAlign: TextAlign.left,
                          'Harga Pengeluaran',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(textAlign: TextAlign.left,
                          'Keterangan Pengeluaran',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                   
                  ],
                ),
              ),
           
              ...buildChildren2()
 ,             widget.laporanBulanan.transaksiBulanIni.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 15, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(flex:2,
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(textAlign: TextAlign.left,'Total Ongkos ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(textAlign: TextAlign.left,
                                    Rupiah.format(
                                        widget.laporanBulanan.totalOngkos),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ),
                              ),
                              Expanded(flex: 7, child: SizedBox()),
                            ],
                          ),
                            Row(
                            children: [
                              Expanded(flex:4,
                                child: Divider(
                                  height: 7,
                                                       
                                  color: Colors.grey.shade900,
                                ),
                              ),Expanded(flex: 9,child: SizedBox())
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:2,
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(textAlign: TextAlign.left,'Total Keluar ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(textAlign: TextAlign.left,
                                    Rupiah.format(
                                        widget.laporanBulanan.totalKeluar),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ),
                              ),
                              Expanded(flex: 7, child: SizedBox()),
                            ],
                          ),
                            Row(
                            children: [
                              Expanded(flex:4,
                                child: Divider(
                                  height: 7,
                                                       
                                  color: Colors.grey.shade900,
                                ),
                              ),Expanded(flex: 9,child: SizedBox())
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:2,
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(textAlign: TextAlign.left,'Total Sisa ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(textAlign: TextAlign.left,
                                    Rupiah.format(
                                        widget.laporanBulanan.totalSisa),
                                    style:
                                        Theme.of(context).textTheme.displaySmall,
                                  ),
                                ),
                              ),  Expanded(flex: 7, child: SizedBox()),
                            ],
                          ),
                            Row(
                            children: [
                              Expanded(flex:4,
                                child: Divider(
                                  height: 7,
                                                       
                                  color: Colors.grey.shade900,
                                ),
                              ),Expanded(flex: 9,child: SizedBox())
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:2,
                                child: Container(
                                    margin:
                                        const EdgeInsets.only(top: 10, bottom: 0),
                                    child: Text(textAlign: TextAlign.left,
                                      'Total Pengeluaran',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    margin:
                                        const EdgeInsets.only(top: 10, bottom: 0),
                                    child: Text(textAlign: TextAlign.left,
                                      
                                      Rupiah.format(
                                          widget.laporanBulanan.totalPengeluaran),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )),
                              ),  Expanded(flex: 7, child: SizedBox()),
                            ],
                          ),
                            Row(
                            children: [
                              Expanded(flex:4,
                                child: Divider(
                                  height: 7,
                                                       
                                  color: Colors.grey.shade900,
                                ),
                              ),Expanded(flex: 9,child: SizedBox())
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex:2,
                                child: Container(
                                    margin:
                                        const EdgeInsets.only(top: 10, bottom: 0),
                                    child: Text(textAlign: TextAlign.left,'Total Bersih ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall)),
                              ),
                              Expanded(
                                child: Container(
                                    margin:
                                        const EdgeInsets.only(top: 10, bottom: 0),
                                    child: Text(textAlign: TextAlign.left,
                                      Rupiah.format(
                                        widget.laporanBulanan.totalBersih,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )),
                              ),  Expanded(flex: 7, child: SizedBox()),
                            ],
                          ),
                            Row(
                            children: [
                              Expanded(flex:4,
                                child: Divider(
                                  height: 7,
                                                       
                                  color: Colors.grey.shade900,
                                ),
                              ),Expanded(flex: 9,child: SizedBox())
                            ],
                          ),
                        ],
                      ),
                    ),
            ]), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
