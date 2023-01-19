import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../models/transaksi.dart';

class ProviderData with ChangeNotifier {
    
  List<Transaksi> listTransaksi = [];
  List<Transaksi> backupTransaksi = [];
String asu='';
  void addTransaksi(Transaksi transaksi) {
    listTransaksi.add(transaksi);
    backupTransaksi.add(transaksi);

    log('Add');
    notifyListeners();
  }

  void setTransaksi(List<Transaksi> data, bool listen) {
    log('Set');
    listTransaksi.clear();
    backupTransaksi.clear();
    listTransaksi.addAll(data);
    backupTransaksi.addAll(data);
    (listen) ? notifyListeners() : () {};
  }

  void searchTransaksi(String val) {
    log(val);
    List<Transaksi> dummyData = [];

    if (val.isEmpty) {
      listTransaksi.clear();
      listTransaksi.addAll(backupTransaksi);
    } else {
      for (var element in listTransaksi) {
        if (element.supir.toLowerCase().startsWith(val.toLowerCase()) ||
            element.mobil.toLowerCase().startsWith(val.toLowerCase())) {
          dummyData.add(element);
        }
      }
    }
    listTransaksi = dummyData;
    notifyListeners();
  }

  void restoreSearchTransaksi(String val) {
    log('Restore');
    listTransaksi = backupTransaksi;

    notifyListeners();
  }
}
