import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

const Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

List<Map<String, dynamic>> dummyData = [
  // {
  //   'id_transaksi': 1,
  //   'tgl_berangkat': '2021-02-20T20:18:04.000Z',
  //   'keterangan': 'test keterangan',
  //   'supir': 'Kolil',
  //   'tujuan': 'Palangka CSA Keramik',
  //   'mobil': 'Ford',
  //   'keluar': 1200000,
  //   'ongkos': 3300000,
  //   'perbaikan_transaksi': [
  //     {'nama_perbaikan': 'Ban MRF', 'harga_perbaikan': 100000}
  //   ]
  // },
  // {
  //   'id_transaksi': 2,
  //   'tgl_berangkat': '2021-02-20T20:18:04.000Z',
  //   'keterangan': 'test keterangan',
  //   'supir': 'Arip',
  //   'tujuan': 'Palangka CSA Kotak',
  //   'mobil': 'Ford',
  //   'keluar': 1500000,
  //   'ongkos': 3200000,
  //   'perbaikan_transaksi': [
  //     {'nama_perbaikan': 'Olie', 'harga_perbaikan': 100000}

  //   ]
  // },
  // {
  //   'id_transaksi': 3,
  //   'tgl_berangkat': '2021-02-20T20:18:04.000Z',
  //   'keterangan': 'test keterangan',
  //   'supir': 'Kolil',
  //   'tujuan': 'Palangka CSA Aplus',
  //   'mobil': 'Toyota',
  //   'keluar': 500000,
  //   'ongkos': 3300000,
  //   'perbaikan_transaksi': [
  //     {'nama_perbaikan': 'Parkir', 'harga_perbaikan': 100000}
  //   ]
  // },
  //  {
  //   'id_transaksi': 4,
  //   'tgl_berangkat': '2023-02-20T20:18:04.000Z',
  //   'keterangan': 'test keterangan',
  //   'supir': 'Arip',
  //   'tujuan': 'Palangka Beras',
  //   'mobil': 'Ford',
  //   'keluar': 150000,
  //   'ongkos': 200000,
  //   'perbaikan_transaksi': [
  //     {'nama_perbaikan': 'Ban BridgeStone', 'harga_perbaikan': 100000}
  //   ]
  // },
  // {
  //   'id_transaksi': 5,
  //   'tgl_berangkat': '2021-01-20T20:18:04.000Z',
  //   'keterangan': 'test keterangan',
  //   'supir': 'Arip',
  //   'tujuan': 'Palangka CSA Keramik',
  //   'mobil': 'Ford',
  //   'keluar': 1500000,
  //   'ongkos': 2000000,
  //   'perbaikan_transaksi': [
  //     {'nama_perbaikan': 'Ban MRF', 'harga_perbaikan': 100000}
  //   ]
  // },
  // {
  //   'id_transaksi': 6,
  //   'tgl_berangkat': '2021-01-20T20:18:04.000Z',
  //   'keterangan': 'test keterangan',
  //   'supir': 'Arip',
  //   'tujuan': 'Palangka CSA Kotak',
  //   'mobil': 'Ford',
  //   'keluar': 500000,
  //   'ongkos': 1500000,
  //   'perbaikan_transaksi': [
  //     {'nama_perbaikan': 'Olie', 'harga_perbaikan': 100000}

  //   ]
  // },
  // {
  //   'id_transaksi': 7,
  //   'tgl_berangkat': '2021-01-20T20:18:04.000Z',
  //   'keterangan': 'test keterangan',
  //   'supir': 'Kolil',
  //   'tujuan': 'Palangka CSA Aplus',
  //   'mobil': 'Ford',
  //   'keluar': 500000,
  //   'ongkos': 1700000,
  //   'perbaikan_transaksi': [
  //     {'nama_perbaikan': 'Parkir', 'harga_perbaikan': 100000}
  //   ]
  // },
   {
    'id_transaksi': 8,
    'tgl_berangkat': '2023-01-20T20:18:04.000Z',
    'keterangan': 'test keterangan',
    'supir': 'Arip',
    'tujuan': 'Palangka Beras',
    'mobil': 'Hino',
    'keluar': 200000,
    'ongkos': 330000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'Part', 'harga_perbaikan': 100000}
    ]
  },
  
];
List<Map<String, dynamic>> dummyData2 = [
  {'id_supir': 1, 'nama_supir': 'Kolil', 'nohp_supir': '085728181929'},
  {'id_supir': 2, 'nama_supir': 'Budi', 'nohp_supir': '085728181929'},
  {'id_supir': 3, 'nama_supir': 'Arip', 'nohp_supir': '085728181929'},
  {'id_supir': 4, 'nama_supir': 'Ahmad', 'nohp_supir': '085728181929'},
  {'id_supir': 5, 'nama_supir': 'Cahyo', 'nohp_supir': '085728181929'}
];
List<Map<String, dynamic>> dummyData3 = [
  {'id_mobil': 1, 'nama_mobil': 'Hino', 'nopol_mobil': 'AD 4349 AWE'},
  {'id_mobil': 2, 'nama_mobil': 'Toyota', 'nopol_mobil': 'AD 4349 AWE'},
  {'id_mobil': 3, 'nama_mobil': 'Ford', 'nopol_mobil': 'AD 4349 AWE'},
  {'id_mobil': 4, 'nama_mobil': 'Avanza', 'nopol_mobil': 'AD 4349 AWE'}
];

class Service {
  static Future<List<Transaksi>> getAllTransaksi() async {
    List<Transaksi> data = [];

    for (var element in dummyData) {
      data.add(Transaksi.fromMap(element));
    }

    return data;
  }

  static Future<List<Supir>> getAllSupir() async {
    List<Supir> data = [];
    for (var element in dummyData2) {
      data.add(Supir.fromMap(element));
    }
    return data;
  }

  static Future<List<Mobil>> getAllMobil() async {
    List<Mobil> data = [];
    for (var element in dummyData3) {
      data.add(Mobil.fromMap(element));
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
