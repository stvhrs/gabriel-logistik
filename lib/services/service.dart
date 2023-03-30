import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';
import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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
    'mobil': 'AD 2345 HWE',
    'harga': 10000,
    'tanggal': DateTime.now().toIso8601String(),
    'keterangan': 'keterangan'
  },
  {
    'jenis': 'Servis',
    'mobil': 'AD 2345 HWE',
    'harga': 10000,
    'tanggal': DateTime.now().toIso8601String(),
    'keterangan': 'keterangan'
  },
  {
    'jenis': 'Cucis',
    'mobil': 'AD 2345 HWE',
    'harga': 10000,
    'tanggal': DateTime.now().toIso8601String(),
    'keterangan': 'keterangan'
  }
];
List<Map<String, dynamic>> jualBeli = [
  {
    'nama_mobil': 'AD 2345 HWE',
    'harga': 0,
    'ket_mobil': 'Head Tronton',
    'beli': true,
    'keterangan': 'Ini adalah test ketenarangan asdasdas',
    'tanggal': DateTime.now().toIso8601String()
  },
];

List<Map<String, dynamic>> transaksi = [
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-02-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },{
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
    {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
  {
    'tgl_berangkat': '2023-03-02T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan',
    'mobil': 'AD 2345 HWE',
    'keluar': 1500000,
    'ongkos': 3300000,
    'sisa': 1800000
  },
];

List<Map<String, dynamic>> supir = [
  {
    'nama_supir': 'Kolil2',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil3',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil4',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil5',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil6',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
  {
    'nama_supir': 'Kolil',
    'nohp_supir': '085728181929',
  },
];

List<Map<String, dynamic>> mobil = [
  {
    'plat_mobil': 'AD 2345 HWE',
    'ket_mobil': 'HEAD TRONTON',
    'terjual': false,
  },
  {
    'plat_mobil': 'AD 2345 HWE2',
    'ket_mobil': 'HEAD TRONTON',
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

    final response = await http.get(
      Uri.parse(
        'https://logistik-project.000webhostapp.com/api/mobil',
      ),
    );

    print(response.body);
    if (response.body.isNotEmpty) {
     
    } else {
    
    }
    List<Map<String, dynamic>> data2=[];
  for (var element in jsonDecode(response.body) ) {
    data2.add(element);
    print(data2);
  }

    List<Mobil> data = [];
    for (var te in mobil) {
      List<Pengeluaran> asu = list
          .where((element) =>
              (te['plat_mobil'] as String).trim() == element.mobil.trim())
          .toList();
      data.add(Mobil.fromMap(te, asu));
    }
    return data;
  }

  static Future<String> postSupir() async {
    log('post SUpir');
    final response = await http.post(
      body: {"nama_supir": "Tanpa ID", "no_hp": "85677899983"},
      Uri.parse(
        'https://logistik-project.000webhostapp.com/api/supir',
      ),
    );

    print(response.statusCode);
    if (response.body.isNotEmpty) {
      return response.body.toString();
    } else {
      return 'Eroorrrrrr';
    }
  }

  static Future<String> updateSupir() async {
    log('post SUpir');
    final response = await http.post(
      body: {"id_supir": "1", "nama_supir": "222", "no_hp": "85677899983"},
      Uri.parse(
        'https://logistik-project.000webhostapp.com/api/supir',
      ),
    );

    print(response.statusCode);
    if (response.body.isNotEmpty) {
      return response.body.toString();
    } else {
      return 'Eroorrrrrr';
    }
  }

  static Future<String> deleteSupir() async {
    log('Delte supir');
    final response = await http.delete(
      body: {"id_supir": '2'},
      Uri.parse(
        'https://logistik-project.000webhostapp.com/api/supir/1',
      ),
    );

    print(response.statusCode);
    if (response.body.isNotEmpty) {
      return response.body.toString();
    } else {
      return 'Eroorrrrrr';
    }
  }

  static Future<String> test3() async {
    log('tes get');
    final response = await http.get(
      Uri.parse(
        'https://logistik-project.000webhostapp.com/api/supir',
      ),
    );

    print(response.body);
    if (response.body.isNotEmpty) {
      return response.body.toString();
    } else {
      return 'Eroorrrrrr';
    }
  }

  static Future<void> pengeluarasn() async {
    log('tes post');
    final response = await http.post(
      body: {
        "id_pengeluaran": "2",
        "plat_mobil": "AD 2345 HWEzz",
        "jenis_p": "Servizzs",
        "harga_p": "30000000",
        "ket_p": "keterangan",
        "tgl_p": "2023-03-01"
      },
      // headers: {"Content-Type": "application/json"},
      Uri.parse(
        'https://logistik-project.000webhostapp.com/api/pengeluaran',
      ),
    );
    log(response.body);
  }

  static Future<String> test2() async {
    log('tes get');
    var response = await http
        .get(Uri.parse('https://logistik-project.000webhostapp.com/api/supir'));
    return response.body;
  
  }
}
