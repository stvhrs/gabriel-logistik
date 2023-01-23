import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';

import '../models/transaksi.dart';

class ProviderData with ChangeNotifier {
  List<Transaksi> backupTransaksi = [];
  List<Transaksi> listTransaksi = [];

  List<Supir> listSupir = [];
  List<Mobil> listMobil = [];
  List<Supir> backupListSupir = [];
  List<Mobil> backupListMobil = [];

  void setData(List<Transaksi> data, bool listen, List<Mobil> mobilData,
      List<Supir> supirData) {
    print('set');
    listTransaksi.clear();
    backupTransaksi.clear();
    listTransaksi.addAll(data);
    backupTransaksi.addAll(data);

    backupListMobil = mobilData;
    backupListSupir = supirData;
    listMobil = mobilData;
    listSupir = supirData;
    (listen) ? notifyListeners() : () {};
  }

  void addMobil(Mobil mobil) {
    listMobil.add(mobil);
    backupListMobil.add(mobil);
    notifyListeners();
  }

  void deleteMobil(Mobil mobil) {
    listMobil.remove(mobil);
    notifyListeners();
  }

  void updateMobil(Mobil mobil) {
    int data =
        listMobil.indexWhere((element) => element.id_mobil == mobil.id_mobil);

    listMobil[data] = mobil;
  }

  void addSupir(Supir supir) {
    listSupir.add(supir);
    backupListSupir.add(supir);
    notifyListeners();
  }

  void deleteSupir(Supir supir) {
    listSupir.remove(supir);
    notifyListeners();
  }

  void updateSupir(Supir supir) {
    int data =
        listSupir.indexWhere((element) => element.id_supir == supir.id_supir);
    listSupir[data] = supir;
  }

  void addTransaksi(Transaksi transaksi) {
    listTransaksi.add(transaksi);
    backupTransaksi.add(transaksi);

    notifyListeners();
  }

  void deleteTransaksi(Transaksi transaksi) {
    listTransaksi.remove(transaksi);
    notifyListeners();
  }

  void updateTransaksi(Transaksi transaksi) {
    int data = listTransaksi
        .indexWhere((element) => element.transaksiId == transaksi.transaksiId);
    listTransaksi[data] = transaksi;
  }

  void searchTransaksi(String val) {
    if (val.isEmpty) {
      listTransaksi.clear();
      listTransaksi.addAll(backupTransaksi);
    } else {
      listTransaksi = backupTransaksi
          .where((element) =>
              element.supir.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchSupir(String val) {
    if (val.isEmpty) {
      listSupir.clear();
      listSupir.addAll(backupListSupir);
    } else {
      listSupir = backupListSupir
          .where((element) =>
              element.nama_supir.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchMobil(String val) {
    if (val.isEmpty) {
      listSupir.clear();
      listSupir.addAll(backupListSupir);
    } else {
      listMobil = backupListMobil
          .where((element) =>
              element.nama_mobil.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
