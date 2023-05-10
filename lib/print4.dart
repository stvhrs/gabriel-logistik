import 'package:flutter/material.dart';
import 'package:gabriel_logistik/examples.dart';
import 'package:gabriel_logistik/models/history_saldo.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class LabaRugi extends StatefulWidget {
 
  final int ropdownValue2 ;final String dropdownValue;final String dropdownValue2;
    final double totalTransaksi ;
  final double totalJualUnit ;
   final double totalNotaJual 
  ;

  final double tahunMaintain ;
  final double toalBeliUnit ;
  final double totalNotaBeli;

  final double totalPendapatan ;
  final double totalPengeluaran ;
  final double saldoAkhir ;
  final double saldoAwal ; 

   LabaRugi(
    this. ropdownValue2 ,this. dropdownValue,this. dropdownValue2,
    this. totalTransaksi ,
  this. totalJualUnit ,
   this. totalNotaJual 
  ,

  this. tahunMaintain ,
  this. toalBeliUnit ,
  this. totalNotaBeli,

  this. totalPendapatan ,
  this. totalPengeluaran ,
  this. saldoAkhir ,
  this. saldoAwal 
  );

  @override
  State<LabaRugi> createState() => _LabaRugiState();
}

class _LabaRugiState extends State<LabaRugi> {
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
          pdfFileName: 'Laporan Laba Rugi',
          canDebug: false,
          build: (format) => examples4[0].builder(
            format,
            widget. ropdownValue2 ,widget. dropdownValue,widget. dropdownValue2,
    widget. totalTransaksi ,
  widget. totalJualUnit ,
   widget. totalNotaJual 
  ,

  widget. tahunMaintain ,
  widget. toalBeliUnit ,
  widget. totalNotaBeli,

  widget. totalPendapatan ,
  widget. totalPengeluaran ,
  widget. saldoAkhir ,
  widget. saldoAwal 
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
