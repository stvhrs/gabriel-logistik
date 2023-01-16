import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:gabriel_logistik/models/transaksi_model.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

const Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

List<Map<String, dynamic>> dummyData = [
  {
    'transaksiId': 1,
    'tanggalBerangkat': '2022-07-20T20:18:04.000Z',
    'tanggalPulang': '2022-07-20T20:18:04.000Z',
    'supir': 'Budi',
    'tujuan': 'Gemolong',
    'mobil': 'Ford AD 9999 RR',
    'gajiSupir': 100,
    'totalCost': 400,
    'fixCost': [
      {'harga': 100, 'nama': 'bensin'},
      {'harga': 100, 'nama': 'bensin'}
    ],
    'extendedCost': [
      {'harga': 23, 'nama': 'Ban Bocor'},
      {'harga': 100, 'nama': 'Ban Bocor'}
    ]
  },
  {
    'transaksiId': 1,
    'tanggalBerangkat': '2022-07-20T20:18:04.000Z',
    'tanggalPulang': '2022-07-20T20:18:04.000Z',
    'supir': 'Steve',
    'tujuan': 'Gemolong',
    'mobil': 'Carry AD 1234 XX',
    'gajiSupir': 100,
    'totalCost': 400,
    'fixCost': [
      {'harga': 100, 'nama': 'bensin'},
      {'harga': 100, 'nama': 'bensin'}
    ],
    'extendedCost': [
      {'harga': 23, 'nama': 'Ban Bocor'},
      {'harga': 100, 'nama': 'Ban Bocor'}
    ]
  }
];

class Service {
  static Future<List<Transaksi>> getAllTransaksi() async {
    await Future.delayed(const Duration(seconds: 1), () {});

    final response = await http.get(
        Uri.parse('http://localhost/logistik/api/pengirimanConfirmed_read'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Asu');
      log(response.body.toString());
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    print(response.body);
    List<Transaksi> data = [];
    for (var element in dummyData) {
      data.add(Transaksi.fromMap(element));
    }
    return data;
  }

  static Future<String> test() async {
    final response = await http.get(
        Uri.parse('http://localhost/logistik/api/pengirimanConfirmed_read'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('Asu');

      return response.body.toString();
    } else {
      throw json.decode(response.body);
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
      debugPrint(response.body.toString() + 'asu2');
      log(response.body.toString());
      debugPrint(response.body.toString());
      return response.body.toString();
    } else {
      throw json.decode(response.body);
    }
  }
}
