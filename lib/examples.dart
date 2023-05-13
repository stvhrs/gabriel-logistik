import 'dart:async';
import 'dart:typed_data';

import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:gabriel_logistik/print_bulanan.dart';
import 'package:gabriel_logistik/print_laba.dart';
import 'package:gabriel_logistik/print_mutasi.dart';
import 'package:gabriel_logistik/print_tahunan.dart';
import 'package:pdf/pdf.dart';

import 'models/history_saldo.dart';
import 'models/kas_tahun.dart';

const examples = [
  Example(generateResume, true),
];
const examples3 = [
  Example3(generateResume3, true),
];
const examples2 = [
  Example2(generateResume2, true),
];
const examples4 = [
  Example4(generateResume4, true),
];

class Example3 {
  const Example3(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData3 builder;

  final bool needsData;
}

typedef LayoutCallbackWithData3 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<HistorySaldo> asu, double asx);


  
typedef LayoutCallbackWithData4 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, int ropdownValue2 ,String dropdownValue,String dropdownValue2,
    double totalTransaksi ,
  double totalJualUnit ,
   double totalNotaJual 
  ,
 double totalPerbaikan,
  double tahunMaintain ,
  double toalBeliUnit ,
  double totalNotaBeli,

  double totalPendapatan ,
  double totalPengeluaran ,
  double saldoAkhir ,
  double saldoAwal , );

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<KeuanganBulanan> asu);

typedef LayoutCallbackWithData2 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<KasModel> asu);

class Example {
  const Example(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData builder;

  final bool needsData;
}

class Example2 {
  const Example2(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData2 builder;

  final bool needsData;
}

class Example4 {
  const Example4(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData4 builder;

  final bool needsData;
}
