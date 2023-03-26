/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:typed_data';

import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'helper/rupiah_format.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(
    PdfPageFormat format,List<KeuanganBulanan> as) async {

  final document = pw.Document();
  var pagetheme=await _myPageTheme(format);
  for (var element in as) {


    document.addPage(pw.Page(margin: const pw.EdgeInsets.all(5),
       
        build: ((pw.Context context) {
          return pw.Container(
      child: pw.Container(
        // elevation:1,
        // color: Colors.white, surfaceTintColor: Colors.grey.shade500,
        // shadowColor: Theme.of(context).colorScheme.primary,
        child: pw.Column(
            crossAxisAlignment:pw. CrossAxisAlignment.start,
            mainAxisSize: pw.MainAxisSize.max,
            children: [
             pw. Padding(
                padding:
                    const pw. EdgeInsets.only(left: 15.0, top: 7.5, bottom: 7.5),
                child: pw.Text(
                  '${element.namaMobil} - ${element .bulan}',
                  // style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              pw.Container(
                decoration: const pw.BoxDecoration(
                  // color: Theme.of(context).colorScheme.primary,
                ),
                padding: const pw. EdgeInsets.only(top: 10, bottom: 12.5, left: 15),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Tanggal',
                          
                        )),
                    pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Supir',
                          
                        )),
                    pw.Expanded(
                        flex: 10,
                        child: pw.Text(
                          'Tujuan',
                          
                        )),
                    pw.Expanded(
                        flex: 7,
                        child: pw.Text(
                          'Ongkos',
                          
                        )),
                    pw.Expanded(
                        flex: 7,
                        child: pw.Text(
                          'Keluar',
                          
                        )),
                    pw.Expanded(
                        flex: 7,
                        child: pw.Text(
                          'Sisa',
                          
                        )),
                  ],
                ),
              ),
              // ...buildChildren(), 
           
               pw.Container(margin: const pw. EdgeInsets.only(top: 40),
                decoration:const pw. BoxDecoration(
                  // color: Colors.red.shade600
                ),
                padding: const pw. EdgeInsets.only(top: 10, bottom: 12.5, left: 15),
                child: pw.Row(
                  children: [
                     pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Tanggal',
                          
                        )),
                    pw.Expanded(
                        flex:1,
                        child: pw.Text(
                          'Nama Pengeluaran',
                          
                        )),
                    pw.Expanded(
                        flex:1,
                        child: pw.Text(
                          'Harga Pengeluaran',
                          
                        )),
                    pw.Expanded(
                        flex: 7,
                        child: pw.Text(
                          'Keterangan Pengeluaran',
                          
                        )),
                   
                  ],
                ),
              ),
           
              // ...buildChildren2()
         element.transaksiBulanIni.isEmpty
                  ? pw.SizedBox()
                  :pw. Padding(
                      padding: const pw. EdgeInsets.only(
                          top: 8, bottom: 8, left: 15, right: 20),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Row(
                            children: [
                              pw.Expanded(flex:2,
                                child: pw.Container(
                                  margin:
                                      const pw. EdgeInsets.only(top: 10, bottom: 0),
                                  child: pw.Text('Total Ongkos ',
                                      ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  margin:
                                      const pw. EdgeInsets.only(top: 10, bottom: 0),
                                  child: pw.Text(textAlign:pw.TextAlign.right,
                                    Rupiah.format(
                                        element.totalOngkos),
                                    
                                  ),
                                ),
                              ),
                              pw.Expanded(flex: 7, child: pw.SizedBox()),
                            ],
                          ),
                            pw.Row(
                            children: [
                              pw.Expanded(flex:4,
                                child:pw. Divider(
                                  height: 7,
                                                       
                                    ),
                              ),pw.Expanded(flex: 9,child: pw.SizedBox())
                            ],
                          ),
                          pw.Row(
                            children: [
                              pw.Expanded(flex:2,
                                child: pw.Container(
                                  margin:
                                      const pw. EdgeInsets.only(top: 10, bottom: 0),
                                  child: pw.Text('Total Keluar ',
                                      ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  margin:
                                      const pw. EdgeInsets.only(top: 10, bottom: 0),
                                  child: pw.Text(textAlign:pw.TextAlign.right,
                                    Rupiah.format(
                                        element.totalKeluar),
                                    
                                  ),
                                ),
                              ),
                              pw.Expanded(flex: 7, child: pw.SizedBox()),
                            ],
                          ),
                            pw.Row(
                            children: [
                              pw.Expanded(flex:4,
                                child:pw. Divider(
                                  height: 7,
                               
                                ),
                              ),pw.Expanded(flex: 9,child: pw.SizedBox())
                            ],
                          ),
                          pw.Row(
                            children: [
                              pw.Expanded(flex:2,
                                child: pw.Container(
                                  margin:
                                      const pw. EdgeInsets.only(top: 10, bottom: 0),
                                  child: pw.Text('Total Sisa ',
                                  ),
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                  margin:
                                      const pw. EdgeInsets.only(top: 10, bottom: 0),
                                  child: pw.Text(textAlign:pw.TextAlign.right,
                                    Rupiah.format(
                                        element.totalSisa),
                                    
                                        
                                  ),
                                ),
                              ),  pw.Expanded(flex: 7, child: pw.SizedBox()),
                            ],
                          ),
                            pw.Row(
                            children: [
                              pw.Expanded(flex:4,
                                child:pw. Divider(
                                  height: 7,
                                                       
                                 
                                ),
                              ),pw.Expanded(flex: 9,child: pw.SizedBox())
                            ],
                          ),
                          pw.Row(
                            children: [
                              pw.Expanded(flex:2,
                                child: pw.Container(
                                    margin:
                                        const pw. EdgeInsets.only(top: 10, bottom: 0),
                                    child: pw.Text(
                                      'Total Pengeluaran',
                                    
                                    )),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                    margin:
                                        const pw. EdgeInsets.only(top: 10, bottom: 0),
                                    child: pw.Text(textAlign:pw.TextAlign.right,
                                      
                                      Rupiah.format(
                                          element.totalPengeluaran),
                                     
                                    )),
                              ),  pw.Expanded(flex: 7, child: pw.SizedBox()),
                            ],
                          ),
                            pw.Row(
                            children: [
                              pw.Expanded(flex:4,
                                child:pw. Divider(
                                  height: 7,
                                                       
                                
                                ),
                              ),pw.Expanded(flex: 9,child: pw.SizedBox())
                            ],
                          ),
                          pw.Row(
                            children: [
                              pw.Expanded(flex:2,
                                child: pw.Container(
                                    margin:
                                        const pw. EdgeInsets.only(top: 10, bottom: 0),
                                    child: pw.Text('Total Bersih ',
                                )),
                              ),
                              pw.Expanded(
                                child: pw.Container(
                                    margin:
                                        const pw. EdgeInsets.only(top: 10, bottom: 0),
                                    child: pw.Text(textAlign:pw.TextAlign.right,
                                      Rupiah.format(
                                        element.totalBersih,
                                      ),
                                      
                                    )),
                              ),  pw.Expanded(flex: 7, child: pw.SizedBox()),
                            ],
                          ),
                            pw.Row(
                            children: [
                              pw.Expanded(flex:4,
                                child:pw. Divider(
                                  height: 7,
                                                       
                               
                                ),
                              ),pw.Expanded(flex: 9,child: pw.SizedBox())
                            ],
                          ),
                        ],
                      ),
                    ),
            ]), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
        })));
  }
  // await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => document.save());

return   await document.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {

  format = format.applyMargin(
      left:1,  //2.0 * PdfPageFormat.cm,
      top: 1,  //4.0 * PdfPageFormat.cm,
      right:1,  // 2.0 * PdfPageFormat.cm,
      bottom:1, ); // 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    // buildBackground: (pw.Context context) {
    //   return pw.FullPage(
    //     ignoreMargins: true,
    //     child: pw.Stack(
    //       children: [
    //       pw.Transform.scale(scale: 0.3,child: pw.Positioned(
    //           child: pw.SvgImage(svg: bgShape),
    //           left: 0,
    //           top: 0,
    //         ), ), 
    //       pw.Transform.scale(scale: 0.4,child:   pw.Positioned(
    //           child: pw.Transform.rotate(
    //               angle: pi, child: pw.SvgImage(svg: bgShape)),
    //           right: 0,
    //           bottom: 0,
    //         )),
    //       ],
    //     ),
    //   );
    // },
  );
}
