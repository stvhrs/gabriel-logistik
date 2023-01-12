import 'dart:convert';

import 'package:gabriel_logistik/models/transaksi.dart';
 List<Map<String, dynamic>> dummyData = [
      {
        'transaksiId': 1,
        'tanggalBerangkat': '2022-07-20T20:18:04.000Z',
        'tanggalPulang': '2022-07-20T20:18:04.000Z',
        'supir': 'Budi',
        'tujuan': 'Gemolong',
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
  Future<List<Transaksi>> getAllTransaksi() async {
    await Future.delayed(const Duration(seconds: 1), () {});
   
    List<Transaksi> data = [];
    for (var element in dummyData) {
      data.add(Transaksi.fromMap(element));
    }
    return data;
  }
}
