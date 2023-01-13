import 'dart:convert';

import 'package:gabriel_logistik/models/transaksi_model.dart';
 List<Map<String, dynamic>> dummyData = [
      {
        'transaksiId': 1,
        'tanggalBerangkat': '2022-07-20T20:18:04.000Z',
        'tanggalPulang': '2022-07-20T20:18:04.000Z',
        'supir': 'Budi',
        'tujuan': 'Gemolong',
        'mobil':'Ford AD 9999 RR',
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
        'mobil':'Carry AD 1234 XX',
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
static  Future<List<Transaksi>> getAllTransaksi() async {
    await Future.delayed(const Duration(seconds: 1), () {});
   
    List<Transaksi> data = [];
    for (var element in dummyData) {
      data.add(Transaksi.fromMap(element));
    }
    return data;
  }
}
