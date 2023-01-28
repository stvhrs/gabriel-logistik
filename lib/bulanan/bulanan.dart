import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/helper/totalPerbaikan.dart';
import 'package:gabriel_logistik/models/laporan_bulanan.dart';
import 'package:collection/collection.dart';
import '../helper/format_tanggal.dart';
import '../helper/rupiah_format.dart';

class Bulanan extends StatefulWidget {
  final BulanSupir laporanBulanan;
  Bulanan(this.laporanBulanan);

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
            child: Center(child: Icon(Icons.question_mark_rounded)))
      ];
    } else {
      return widget.laporanBulanan.transaksiBulanIni.mapIndexed(
        (index, element) => Container(
          decoration: BoxDecoration(
              color: index.isEven
                  ? Colors.grey.shade200
                  : Theme.of(context).colorScheme.secondary,
             
                         ),
          width: MediaQuery.of(context).size.width * 0.43,
          padding: const EdgeInsets.only(
            top: 14,
            bottom: 14,
            left: 15,
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                      DateTime.parse(element.tanggalBerangkat).day.toString(),
                      style: Theme.of(context).textTheme.displaySmall)),
              // Expanded(
              //     flex: 7,
              //     child: Text(element.mobil,
              //         style: Theme.of(context).textTheme.displaySmall)),
              Expanded(
                  flex: 7,
                  child: Text(element.tujuan,
                      style: Theme.of(context).textTheme.displaySmall)), Expanded(
                  flex: 7,
                  child: Text(Rupiah.format(element.ongkos),
                      style: Theme.of(context).textTheme.displaySmall)),
              Expanded(
                  flex: 7,
                  child: Text(Rupiah.format(element.keluar),
                      style: Theme.of(context).textTheme.displaySmall)),
             
              Expanded(
                  flex: 7,
                  child: Text(Rupiah.format(element.ongkos - element.keluar),
                      style: Theme.of(context).textTheme.displaySmall)),
              Expanded(
                flex: 7,
                child: Text(
                    textAlign: TextAlign.left,
                    element.listPerbaikan.isEmpty
                        ? ''
                        : Rupiah.format(TotalPerbaikan.totalPerbaikan(
                            element.listPerbaikan)),
                    style: Theme.of(context).textTheme.displaySmall),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      child: Card(
        elevation: 5,
        color: Colors.white,surfaceTintColor: Colors.grey.shade500,shadowColor: Theme.of(context).colorScheme.primary,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15.0,top: 7.5,bottom: 7.5),
                child: Text(
                  widget.laporanBulanan.namaSupir +
                      ' - ' +
                      widget.laporanBulanan.tanggal,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 12.5, left: 15),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          'Tgl',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    // Expanded(
                    //     flex: 7,
                    //     child: Text(
                    //       'Mobil',
                    //       style: Theme.of(context).textTheme.displayMedium,
                    //     )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Tujuan',
                          style: Theme.of(context).textTheme.displayMedium,
                        )), Expanded(
                        flex: 7,
                        child: Text(
                          'Ongkos',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Keluar',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                   
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Sisa',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Perbaikan',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                  ],
                ),
              ),
              ...buildChildren(),
           widget.laporanBulanan.transaksiBulanIni.isEmpty?SizedBox():   Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child:   Text('Total Sisa :',
                            style:  Theme.of(context).textTheme.displaySmall),
                        ), Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child: Text('Total Perbaikan: ', style:  Theme.of(context).textTheme.displaySmall,
                          )),
                             Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child:  Text('Total Bersih :',
                            style:  Theme.of(context).textTheme.displaySmall)), Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child: 
                        Text(
                            textAlign: TextAlign.left,
                            'Persen Supir: ',
                           style:  Theme.of(context).textTheme.displaySmall)),
                        
                      ],
                    ),
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child:   Text(
                            Rupiah.format(
                              widget.laporanBulanan.totalBersih +widget.laporanBulanan.totalPerbaikan,
                            ),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),), Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child:  Text(
                            textAlign: TextAlign.left,
                            Rupiah.format(widget.laporanBulanan.totalPerbaikan),
                            style: Theme.of(context).textTheme.displaySmall,
                          )),
                          Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child:  Text(
                            Rupiah.format(
                              widget.laporanBulanan.totalBersih,
                            ),
                            style: Theme.of(context).textTheme.displaySmall,
                          )),
                         
                        Container(margin: EdgeInsets.only(top: 2,bottom: 2),
                          child:    Text(
                            Rupiah.format(
                                widget.laporanBulanan.persenanSupir ?? 0),
                            style: Theme.of(context).textTheme.displaySmall,
                          )),
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
