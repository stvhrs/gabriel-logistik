import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';
import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

// Future<Uint8List> printPdf(List<Uint8List> listUint8list) async {
//   final document = pw.Document();
//   for (var element in listUint8list) {
//     final pw.MemoryImage memoryImage = pw.MemoryImage(element);

//     document.addPage(pw.Page(
//         margin: const pw.EdgeInsets.all(20),
//         pageFormat: PdfPageFormat.a4,
//         build: ((pw.Context context) {
//           return pw.Align(
//             alignment: pw.Alignment.topCenter,
//             child: pw.Image(memoryImage),
//           );
//         })));
//   }

//   return await document.save();
// }

const Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
};
List<Map<String, dynamic>> pengeluaran = [
  {
    'jenis': 'Pajak',
    'mobil':'AD 1234 FF',
    'harga': 10000,
    'tanggal': DateTime.now().toIso8601String(),
    'keterangan': 'keterangan'
  }
];
List<Map<String, dynamic>> jualBeli = [
  {
    'nama_mobil': 'AD 1234 FF',
    'harga': 0,
    'beli': true,
    'keterangan': 'Ini adalah test ketenarangan',
    'tanggal': DateTime.now().toIso8601String()
  },
];

List<Map<String, dynamic>> transaksi = [
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan Besi',
    'mobil': 'AD 1234 FF',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
];

List<Map<String, dynamic>> supir = [
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },{
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
];

List<Map<String, dynamic>> mobil = [
  {
    'nama_mobil': 'AD 1234 FF',
    'keterangan_mobill': 'HEAD TRONTON',
    'terjual': false,
  },
];

class Service {
  static Future<List<Transaksi>> getAllTransaksi() async {
    List<Transaksi> data = [];

    for (var element in transaksi.reversed) {
      data.add(Transaksi.fromMap(element));
    }

    return data;
  }

  static Future<List<Supir>> getAllSupir() async {
    List<Supir> data = [];
    for (var element in supir) {
      data.add(Supir.fromMap(element));
    }
    return data;
  }

  static Future<List<Pengeluaran>> getAllPengeluaran() async {
    List<Pengeluaran> data = [];
    for (var element in pengeluaran) {
      data.add(Pengeluaran.fromMap(element));
    }
    return data;
  }

  static Future<List<JualBeliMobil>> getAlljualBeli() async {
    List<JualBeliMobil> data = [];
    for (var element in jualBeli) {
      data.add(JualBeliMobil.fromMap(element));
    }
    return data;
  }

  static Future<List<Mobil>> getAllMobil(List<Pengeluaran> list) async {
    List<Mobil> data = [];
    for (var te in mobil) {
  List<Pengeluaran> asu= list.where((element) => (te['nama_mobil'] as String).trim()==element.mobil.trim()).toList();
      data.add(Mobil.fromMap(te,asu));
    }
    return data;
  }

  static Future<String> test() async {
    final response = await http.get(
        Uri.parse(
          'http://localhost/logistik/api/pengirimanConfirmed_read',
        ),
        headers: headers);

    print(response.statusCode);
    if (response.body.isNotEmpty) {
      return response.body.toString();
    } else {
      return 'Eroorrrrrr';
    }
  }

  static Future<String> test2() async {
    Uri uri = Uri.https(
      'localhost',
      '/logistik/api/pengirimanConfirmed_read',
    );
    var response = await http.get(
      uri,
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Asu');
      debugPrint('${response.body}asu2');
      log(response.body.toString());
      debugPrint(response.body.toString());
      return response.body.toString();
    } else {
      throw json.decode(response.body);
    }
  }
}
