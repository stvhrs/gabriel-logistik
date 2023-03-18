import 'dart:async';
import 'dart:typed_data';

import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:gabriel_logistik/resume.dart';
import 'package:pdf/pdf.dart';





const examples = <Example>[
  Example( generateResume,true),

];

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<KeuanganBulanan> asu);

class Example {
  const Example( this.builder, [this.needsData = false]);



  final LayoutCallbackWithData builder;

  final bool needsData;
}
