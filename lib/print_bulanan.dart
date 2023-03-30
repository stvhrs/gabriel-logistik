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
import 'package:collection/collection.dart';
import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'helper/rupiah_format.dart';
import 'models/transaksi.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(
    PdfPageFormat format, List<KeuanganBulanan> as) async {
  pw.TextStyle med = pw.TextStyle(fontSize: 10);
  DateTime dateTime = DateTime.parse(DateTime.now().toIso8601String());
  String yourDateTime = DateFormat('hh:mm dd-MM-yyyy').format(dateTime);
  buildChildren(List<Transaksi> list) {
    if (as.isEmpty) {
      return [pw.SizedBox()];
    } else {
      return list
          .mapIndexed((index, element) => pw.Container(
                width: double.infinity,
                // decoration: BoxDecoration(
                //     color: index.isEven
                //         ? Colors.grey.shade200
                //         : const Color.fromARGB(255, 189, 193, 221)),
                padding: pw.EdgeInsets.only(
                  top: 7,
                  bottom: 7,
                  left: 15,
                ),
                child: pw.Row(children: [
                  pw.Expanded(
                      flex: 5,
                      child: pw.Text(
                          style: med,
                          textAlign: pw.TextAlign.left,
                          '${DateTime.parse(element.tanggalBerangkat).day}, ${DateFormat('EEEE', "id_ID").format(DateTime.parse(element.tanggalBerangkat))}')),
                  pw.Expanded(
                      flex: 4,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        element.supir,
                      )),
                  pw.Expanded(
                      flex: 10,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        element.tujuan,
                      )),
                  pw.Expanded(
                      flex: 7,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format(element.ongkos),
                      )),
                  pw.Expanded(
                      flex: 7,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format(element.keluar),
                      )),

                  pw.Expanded(
                      flex: 7,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format(element.ongkos - element.keluar),
                      )),
                  // Expanded(
                  //   flex: 7,
                  //   child: Text(textAlign: TextAlign.left,
                  //       textAlign: TextAlign.left,
                  //       element. listPerbaikan.isEmpty
                  //           ? ''
                  //           : Rupiah.format(totalPengeluaran.totalPengeluaran(
                  //               element. listPerbaikan)),
                  //       ),
                  // ),
                ]),
              ))
          .toList();
    }
  }

  buildChildren2(List<Pengeluaran> list) {
    if (list.isEmpty) {
      return [];
    } else {
      return list
          .mapIndexed(
            (index, element) => pw.Container(
              width: double.infinity,
              // decoration: BoxDecoration(
              //     color: index.isEven
              //         ? Colors.grey.shade200
              //         :  const Color.fromARGB(255, 189, 193, 221)),
              padding: pw.EdgeInsets.only(
                top: 7,
                bottom: 7,
                left: 15,
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                          textAlign: pw.TextAlign.left,
                          style: med,
                          '${DateTime.parse(element.tanggal).day}, ${DateFormat('EEEE', "id_ID").format(DateTime.parse(element.tanggal))}')),
                  pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        element.jenis,
                      )),

                  pw.Expanded(
                      flex: 5,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format(element.harga),
                      )),
                  pw.Expanded(
                      flex: 7,
                      child: pw.Text(
                        style: med,
                        textAlign: pw.TextAlign.left,
                        element.keterangan,
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
          )
          .toList();
    }
  }

  final document = pw.Document();
  pw.TextStyle bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);
    pw.TextStyle bold2 = pw.TextStyle(fontSize: 15,fontWeight: pw.FontWeight.bold);
  pw.TextStyle small = pw.TextStyle(fontSize: 10);

  var pagetheme = await _myPageTheme(format);
  for (var element in as) {
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
                        child: pw.Text(
                            '${element.namaMobil} - ${element.bulan}',
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: pw.FontWeight.bold)
                            // style: Theme.of(context).textTheme.bodyLarge,
                            ),
                      ),
                      pw.Spacer(),
                      pw.Text(yourDateTime, style: small),
                      pw.Text('   ' +
                          (as.indexOf(element) + 1).toString() +
                          '/' +
                          as.length.toString() +
                          '    ')
                    ]),
                  pw.Container(
                        margin: const pw.EdgeInsets.only(top: 10, bottom: 3),
                        decoration: pw.BoxDecoration(
                            border: pw.Border(top: pw.BorderSide())),
                        child: pw.Center(
                          child: pw.Text(
                              textAlign: pw.TextAlign.center,
                              'Transaksi',
                              style: bold2),
                        )),
                    pw.Container(
                      decoration: pw.BoxDecoration(border: pw.Border.all()
                          // color: Theme.of(context).colorScheme.primary,
                          ),
                      padding:
                          const pw.EdgeInsets.only(top: 5, bottom: 5, left: 15),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 5, child: pw.Text('Tanggal', style: bold)),
                          pw.Expanded(
                              flex: 4, child: pw.Text('Supir', style: bold)),
                          pw.Expanded(
                              flex: 10, child: pw.Text('Tujuan', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Ongkos', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Keluar', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Sisa', style: bold)),
                        ],
                      ),
                    ),
                    ...buildChildren(element.transaksiBulanIni),
                    pw.Container(
                        margin: const pw.EdgeInsets.only(top: 20, bottom: 3),
                        decoration: pw.BoxDecoration(
                            border: pw.Border(top: pw.BorderSide())),
                        child: pw.Center(
                          child: pw.Text(
                              textAlign: pw.TextAlign.center,
                              'Pengeluaran',
                              style: bold2),
                        )),
                    pw.Container(
                      decoration: pw.BoxDecoration(border: pw.Border.all()
                          // color: Colors.red.shade600
                          ),
                      padding:
                          const pw.EdgeInsets.only(top: 5, bottom: 5, left: 15),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 3, child: pw.Text('Tanggal', style: bold)),
                          pw.Expanded(
                              flex: 3, child: pw.Text('Jenis', style: bold)),
                          pw.Expanded(
                              flex: 5,
                              child: pw.Text('Pengeluaran', style: bold)),
                          pw.Expanded(
                              flex: 7,
                              child: pw.Text('Keterangan', style: bold)),
                        ],
                      ),
                    ),
                    ...buildChildren2(element.pengeluranBulanIni),
                    pw.Spacer(),
                    element.transaksiBulanIni.isEmpty
                        ? pw.SizedBox()
                        : pw.Padding(
                            padding: const pw.EdgeInsets.only(
                                top: 8, bottom: 8, left: 15, right: 20),
                            child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text('Total Ongkos ',
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text(
                                            textAlign: pw.TextAlign.right,
                                            Rupiah.format(element.totalOngkos),
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text('Total Keluar ',
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text(
                                            textAlign: pw.TextAlign.right,
                                            Rupiah.format(element.totalKeluar),
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text('Total Sisa ',
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text(
                                            textAlign: pw.TextAlign.right,
                                            Rupiah.format(element.totalSisa),
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child: pw.Text('Total Pengeluaran',
                                              style: small)),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child: pw.Text(
                                              textAlign: pw.TextAlign.right,
                                              Rupiah.format(
                                                  element.totalPengeluaran),
                                              style: small)),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child: pw.Text('Total Bersih ',
                                              style: small)),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child: pw.Text(
                                              textAlign: pw.TextAlign.right,
                                              Rupiah.format(
                                                element.totalBersih,
                                              ),
                                              style: small)),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
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
