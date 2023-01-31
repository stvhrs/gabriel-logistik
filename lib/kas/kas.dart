import 'package:flutter/material.dart'; 

import 'package:collection/collection.dart';
import 'package:gabriel_logistik/models/kas_tahun.dart';
import '../helper/rupiah_format.dart';

class Kas extends StatefulWidget {
  final KasModel kasModel;
  const Kas(this.kasModel);

  @override
  State<Kas> createState() => _KasState();
}

class _KasState extends State<Kas> {
  final innerController = ScrollController();

  buildChildren() {

   
      return widget.kasModel.listBulananSupir .mapIndexed(
        (index, element) => Container(
          decoration: BoxDecoration(
              color: index.isEven
                  ? Colors.grey.shade200
                  : const Color.fromARGB(255, 189, 193, 221)
             
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
                  flex: 7,
                  child: Text(element.bulan,
                      style: Theme.of(context).textTheme.displaySmall)),
              Expanded(
                  flex: 7,
                  child: Text(Rupiah.format(element.totalBersih) .toString(),
                      style: Theme.of(context).textTheme.displaySmall)),
              Expanded(
                  flex: 7,
                  child: Text( Rupiah.format(element.totalPerbaikan) .toString(),
                      style: Theme.of(context).textTheme.displaySmall)),
                        Expanded(
                  flex: 7,
                  child: Text(Rupiah.format(element.persenanSupir!) .toString(),
                      style: Theme.of(context).textTheme.displaySmall)),
            ],
          ),
        ),
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  '${widget.kasModel.namaSupir} - ${widget.kasModel.tahun}',
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
                        flex: 7,
                        child: Text(
                          'Bulan',
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
                          'Bersih',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Perbaikan',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Persen',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                  ],
                ),
              ),
              ...buildChildren(),
            widget.kasModel.listBulananSupir.isEmpty?const SizedBox():   Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(margin: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Text('Total Bersih :',
                              style:  Theme.of(context).textTheme.displaySmall),
                        ),
                        Container(margin: const EdgeInsets.only(top: 2,bottom: 2),
                          child: const Text('Total Perbaikan: ', style: TextStyle(fontSize: 13),
                          )),
                        
                        Container(margin: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Text(
                         
                            'Total Persen Supir: ',
                           style:  Theme.of(context).textTheme.displaySmall),
                        )
                      ],    
                    ),
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(margin: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Text(
                            Rupiah.format(
                              widget.kasModel.totalBersih,
                            ),
                            style: Theme.of(context).textTheme.displaySmall,
                          )),
                          Container(margin: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Text(
                            textAlign: TextAlign.left,
                            Rupiah.format(widget.kasModel.totalPerbaikan),
                            style: Theme.of(context).textTheme.displaySmall,
                          )),
                          Container(margin: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Text(
                            Rupiah.format(
                                widget.kasModel.totalPersenSupir ?? 0),
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
