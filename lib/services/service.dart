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
    'id_transaksi': 1,
    'tgl_berangkat': '2022-07-20T20:18:04.000Z','keterangan':'test keterangan',
    'supir': 'Budi',
    'tujuan': 'Gemolong',
    'mobil': 'Ford AD 9999 RR',
    'keluar': 100,
    'ongkos': 400,
    'perbaikan_transaksi': [{'nama_perbaikan':'Ban BridgeStone','harga_perbaikan':100000}]
  },
  {
    'id_transaksi': 1,
    'tgl_berangkat': '2022-07-20T20:18:04.000Z','keterangan':'test keterangan',
    'supir': 'Ahamad',
    'tujuan': 'Gemolong',
    'mobil': 'Ford AD 9999 RR',
    'keluar': 100,
    'ongkos': 400,
    'perbaikan_transaksi': []
  },
  {
    'id_transaksi': 1,
    'tgl_berangkat': '2022-07-20T20:18:04.000Z','keterangan':'test keterangan',
    'supir': 'Cahyo',
    'tujuan': 'Gemolong',
    'mobil': 'Ford AD 9999 RR',
    'keluar': 100,
    'ongkos': 400,
    'perbaikan_transaksi': []
  },
  {
    'id_transaksi': 1,
    'tgl_berangkat': '2022-07-20T20:18:04.000Z','keterangan':'test keterangan',
    'supir': 'Doni',
    'tujuan': 'Gemolong',
    'mobil': 'Ford AD 9999 RR',
    'keluar': 100,
    'ongkos': 400,
    'perbaikan_transaksi': []
  },
];
List<Map<String, dynamic>> dummyData2 = [
  {'id_supir': 1, 'nama_supir': 'Steve', 'nohp_supir': '085728181929'}
];
List<Map<String, dynamic>> dummyData3 = [
  {'id_mobil': 1, 'nama_mobil': 'Avanza', 'nopol_mobil': 'AD 4349 AWE'}
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
