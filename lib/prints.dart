import 'package:flutter/material.dart';
import 'package:gabriel_logistik/examples.dart';
import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:printing/printing.dart';

class LaporanPrint extends StatefulWidget {
  final List<KeuanganBulanan> list;

  const LaporanPrint(
    this.list,
  );

  @override
  State<LaporanPrint> createState() => _LaporanPrintState();
}

class _LaporanPrintState extends State<LaporanPrint> {
  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            primaryColor: const Color.fromARGB(255, 59, 59, 65)),
        child: PdfPreview(
          loadingWidget: const Text('Loading...'),
          onError: (context, error) => const Text('Error...'),
          maxPageWidth: 700,
          pdfFileName: 'Laporan_Bulanan',
          canDebug: false,
          build: (format) => examples[0].builder(
            format,
            widget.list,
          ),
          onPrinted: _showPrintedToast,
          canChangeOrientation: false,
          canChangePageFormat: false,
          onShared: _showSharedToast,
        ),
      ),
    );
  }
}
