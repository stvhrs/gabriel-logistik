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
  {
    'id_transaksi': 10,
    'tgl_berangkat': '2021-02-04T12:29:22.953',
    'keterangan': 'test',
    'supir': 'Arip',
    'tujuan': 'Palangka Batu Alam',
    'mobil': 'Hino',
    'keluar': 1600000,
    'ongkos': 3300000,
    'perbaikan_transaksi': []
  },
  {
    'id_transaksi': 9,
    'tgl_berangkat': '2021-02-04T12:28:39.223',
    'keterangan': 'test',
    'supir': 'Arip',
    'tujuan': 'Pangkuh Pupuk',
    'mobil': 'Hino',
    'keluar': 2000000,
    'ongkos': 4200000,
    'perbaikan_transaksi': []
  },
  {
    'id_transaksi': 8,
    'tgl_berangkat': '2021-02-04T12:26:23.728',
    'keterangan': 'test',
    'supir': 'Arip',
    'tujuan': ' Palangka Besi Harapan',
    'mobil': 'Avanza',
    'keluar': 1500000,
    'ongkos': 3300000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'part', 'harga_perbaikan': 95000}
    ]
  },
  {
    'id_transaksi':7,
    'tgl_berangkat': '2021-02-04T12:25:36.969',
    'keterangan': 'test',
    'supir': 'Arip',
    'tujuan': 'Palangka Harapan',
    'mobil': 'Toyota',
    'keluar': 1500000,
    'ongkos': 3300000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'Parkir', 'harga_perbaikan': 250000}
    ]
  },
  {
    'id_transaksi': 6,
    'tgl_berangkat': '2021-02-04T12:24:42.198',
    'keterangan': 'test',
    'supir': 'Arip',
    'tujuan': ' Palangka Csa',
    'mobil': 'Hino',
    'keluar': 1500000,
    'ongkos': 3300000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'Olie', 'harga_perbaikan': 690000}
    ]
  },
  {
    'id_transaksi': 5,
    'tgl_berangkat': '2021-03-03T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Indomoro',
    'mobil': 'Toyota',
    'keluar': 6000000,
    'ongkos': 11500000,
    'perbaikan_transaksi': [  {'nama_perbaikan': 'Tambal Ban', 'harga_perbaikan': 690000}]
  },
  {
    'id_transaksi': 4,
    'tgl_berangkat': '2021-03-03T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Indomoro',
    'mobil': 'Toyota',
    'keluar': 5600000,
    'ongkos': 11500000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'Tambal Ban', 'harga_perbaikan': 70000}
    ]
  },
  {
    'id_transaksi': 3,
    'tgl_berangkat': '2021-03-03T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Csa',
    'mobil': 'Hino',
    'keluar': 1500000,
    'ongkos': 3300000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'Ban', 'harga_perbaikan': 132500}
    ]
  },
  {
    'id_transaksi': 2,
    'tgl_berangkat': '2021-03-03T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Batu Licin Sosis',
    'mobil': 'Hino',
    'keluar': 1750000,
    'ongkos': 3600000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'Tier', 'harga_perbaikan': 245000}
    ]
  },
  {
    'id_transaksi': 1,
    'tgl_berangkat': '2021-03-03T20:06:32.561',
    'keterangan': 'test',
    'supir': 'Kolil',
    'tujuan': 'Palangka Harapan Besi',
    'mobil': 'Hino',
    'keluar': 1500000,
    'ongkos': 3300000,
    'perbaikan_transaksi': [
      {'nama_perbaikan': 'Olie', 'harga_perbaikan': 1607500}
    ]
  }
];
List<Map<String, dynamic>> dummyData2 = [
  {'id_supir': 1, 'nama_supir': 'Kolil', 'nohp_supir': '085728181929'},

  {'id_supir': 3, 'nama_supir': 'Arip', 'nohp_supir': '085728181929'},

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

    for (var element in dummyData.reversed) {
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
