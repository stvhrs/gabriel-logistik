/*
 * Copyright (C) 3017, David PHAM-VAN <dev.nfet.net@gmail.com>
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
import 'package:collection/collection.dart';
import 'package:gabriel_logistik/models/history_saldo.dart';
import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:gabriel_logistik/models/mutasi_child.dart';
import 'package:gabriel_logistik/models/mutasi_saldo.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import './helper/format_tanggal.dart';
import 'helper/rupiah_format.dart';
import 'models/transaksi.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 130.0;

Future<Uint8List> generateResume3(
    PdfPageFormat format, List<HistorySaldo> as) async {
final int panjang=as.length;
  pw.TextStyle med = const pw.TextStyle(fontSize: 10);
  DateTime dateTime = DateTime.parse(DateTime.now().toIso8601String());
  String yourDateTime = DateFormat('hh:mm dd-MM-yyyy').format(dateTime);


  final document = pw.Document();
  pw.TextStyle bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);
  pw.TextStyle bold2 =
      pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);
  pw.TextStyle small = const pw.TextStyle(fontSize: 10);

  var pagetheme = await _myPageTheme(format);
los( List<HistorySaldo> data){
   document.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(16),
          build: ((pw.Context context) {
            return pw.Container(
                child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()
                        // color: Colors.red.shade600
                        ),
                    // elevation:1,
                    // color: Colors.white, surfaceTintColor: Colors.grey.shade500,
                    // shadowColor: Theme.of(context).colorScheme.primary,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisSize: pw.MainAxisSize.max,
                        children: [
                          pw.Row(children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(
                                  left: 15.0, top: 7.5, bottom: 7.5),
                              child: pw.Text('Mutasi Saldo',
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold)
                                  // style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                            ),
                            pw.Spacer(),
                            pw.Text(yourDateTime, style: small),
                            // pw.Text('  ' ${as.indexOf(element) + 1}/${as.length} '   ')
                          ]),
                          pw.Container(
                            decoration: pw.BoxDecoration(border: pw.Border.all()
                                // color: Theme.of(context).colorScheme.primary,
                                ),
                            padding: const pw.EdgeInsets.only(
                                top: 5, bottom: 5, left: 15),
                            child: pw.Row(
                              children: [
                                pw.Expanded(
                                    flex: 5,
                                    child: pw.Text('Tanggal', style: bold)),
                                pw.Expanded(
                                    flex: 5,
                                    child: pw.Text('Sumber', style: bold)),
                                pw.Expanded(
                                    flex: 5,
                                    child: pw.Text('Detail', style: bold)),
                                pw.Expanded(
                                    flex: 5,
                                    child: pw.Text('Mutasi', style: bold)),
                                pw.Expanded(
                                    flex: 5,
                                    child: pw.Text('Saldo', style: bold)),
                                // pw.Expanded(
                                //     flex: 7, child: pw.Text('Sisa', style: bold)),
                              ],
                            ),
                          ),
                          ...data          .mapIndexed((index, element) => pw.Container(
                width: double.infinity,
                // decoration: BoxDecoration(
                //     color: index.isEven
                //         ? Colors.grey.shade300
                //         : const Color.fromARGB(255, 189, 193, 221)),
                padding: const pw.EdgeInsets.only(
                  top: 7,
                  bottom: 7,
                  left: 15,
                ),
                child: pw.Row(children: [
                  pw.Expanded(
                      flex: 5,
                      child: pw.Text(
                        style: med,
                        FormatTanggal.formatTanggal(element.tanggal.toString())
                            .toString(),
                        textAlign: pw.TextAlign.left,
                      )),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        element.sumber,
                      )),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        element.detail,
                      )),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format(element.harga),
                      )),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format(element.sisaSaldo),
                      )),
                ]),
              ))
          .toList()
                        ])));
          })));
}
List<HistorySaldo> temp=[];
temp.addAll(as);
  for (var i = 0; i < as.length; i++) {
    
    if (i % 28 == 0&&i>0) {
los(as.getRange(i-28, i).toList());
for (var element in as.getRange(i-28, i).toList()) {
  temp.remove(element);
}

    } else if(as.length<=28){los(as);
    }else if(i+1==as.length&&i%28!=0){
los(temp);
    }
  
  }
  return await document.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm); // );
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
