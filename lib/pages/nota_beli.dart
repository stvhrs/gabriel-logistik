import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_logistik/cashflow/delete_pendaptan.dart';
import 'package:gabriel_logistik/cashflow/edit_pendapta.dart';
import 'package:gabriel_logistik/cashflow/tambah_pendaptan.dart';
import 'package:gabriel_logistik/cashflow/view_pendaptan.dart';
import 'package:gabriel_logistik/helper/custompaint.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';

import 'package:gabriel_logistik/models/mutasi_saldo.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../services/service.dart';

class CashFlow extends StatefulWidget {
  const CashFlow({super.key});

  @override
  State<CashFlow> createState() => _CashFlowState();
}

class _CashFlowState extends State<CashFlow> {
      late List<MutasiSaldo> listTransaksi;

 
  bool loading = true;
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
    listTransaksi = await Service.getAllMutasiSaldo();

    Provider.of<ProviderData>(context, listen: false)
        .setData([], false, [], [], [], [], listTransaksi);

    loading = false;

    setState(() {});
  }
  @override
  void initState() {
        if (mounted){ initData();}
   
 

  

    super.initState();
  }


  final children = <int, Widget>{
    0: const Text('Masuk', style: TextStyle(fontFamily: 'Nunito')),
    1: const Text('Keluar', style: TextStyle(fontFamily: 'Nunito')),
  };

  @override
  Widget build(BuildContext context) {
    return  loading==true
        ? Center(
            child: CustomPaints(),
          )
        :  Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                width: 10,
                strokeAlign: StrokeAlign.center),
            color: const Color.fromRGBO(244, 244, 252,  1),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(
                right: 30,
                left: 30,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Text(
                'Nota Pembelian',
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
           
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ? [
                                      const Spacer(),
                                      TambahPendapatan( false)
                                    ]
                                  : []),
                  ),
                  
              
            
            Container(
              color: Theme.of(context).primaryColor,
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Tanggal',
                        style: Theme.of(context).textTheme.displayMedium,
                      )),
                  Expanded(
                      flex: 3,
                      child: Text('Keterangan',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 3,
                      child: Text(
                          'Total Nota Pembelian',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 1,
                      child: Text('Aksi',
                          style: Theme.of(context).textTheme.displayMedium))
                ],
              ),
            ),
            Consumer<ProviderData>(builder: (context, c, h) {
              List<MutasiSaldo> listMutasi = [];
              List<MutasiSaldo> listMutasi2 = [];
             
            
                for (var element in c.listMutasiSaldo) {
                  if (!element.pendapatan) {
                    listMutasi2.add(element);
                  }
                }
              return
             SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          itemCount: listMutasi.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                color: index.isEven
                                    ?  Colors.white
                                    : Colors.grey.shade200,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(FormatTanggal.formatTanggal(
                                            listMutasi[index].tanggal))),
                                    Expanded(
                                        flex: 3,
                                        child:
                                            Text(listMutasi[index].keterangan)),
                                    Expanded(
                                        flex: 3,
                                        child: Text(Rupiah.format(
                                            listMutasi[index].totalMutasi))),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            EditPendaptan(false,
                                                listMutasi[index]),
                                            ViewPendapatan(false,
                                                listMutasi[index]),
                                            Provider.of<ProviderData>(context,
                                                        listen: false)
                                                    .isOwner
                                                ? DeletePendaptan(
                                                    listMutasi[index])
                                                : const SizedBox()
                                          ],
                                        )),
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: currentSegment == 1
                                    //         ? JualEdit(listMutasi[index])
                                    //         : BeliEdit(
                                    //             listMutasi[index]))
                                  ],
                                ),
                              ),
                            );
                          }));
                  
                               
                              
                          
                          })
          
          ],
        ));
  }
}
