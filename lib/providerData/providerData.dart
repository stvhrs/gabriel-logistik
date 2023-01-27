import 'package:flutter/cupertino.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';

import '../helper/format_tanggal.dart';
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

    backupListMobil.addAll(mobilData);
    backupListSupir.addAll(supirData);
    listMobil.addAll(mobilData);
    listSupir.addAll(supirData);
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
    listSupir.insert(0, supir);
    backupListSupir.insert(0, supir);
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
    notifyListeners();
  }

  void addTransaksi(Transaksi transaksi) {
    listTransaksi.insert(0, transaksi);
    backupTransaksi.insert(0, transaksi);

    notifyListeners();
  }

  void deleteTransaksi(Transaksi transaksi) {
    listTransaksi.remove(transaksi);
    notifyListeners();
  }

  void updateTransaksi(Transaksi transaksi) {
    int data = listTransaksi
        .indexWhere((element) => element.transaksiId == transaksi.transaksiId);
    print(data);
    listTransaksi[data] = transaksi;
    backupTransaksi[data] = transaksi;
    notifyListeners();
  }

  String searchmobile = '';
  String searchsupir = '';
  String searchtujuan = '';
  bool searchPerbaikan = false;
  String searchTanggal = '';
  void searchTransaksi() {
    listTransaksi.clear();
    for (Transaksi data in backupTransaksi) {
      bool skipped = false;

      if (searchmobile.isNotEmpty &&
          !data.mobil.toLowerCase().startsWith(searchmobile.toLowerCase())) {
        skipped = true;
      }
      if (searchsupir.isNotEmpty &&
          !data.supir.toLowerCase().startsWith(searchsupir.toLowerCase())) {
        skipped = true;
      }
      if (searchtujuan.isNotEmpty &&
          !data.tujuan.toLowerCase().startsWith(searchtujuan.toLowerCase())) {
        skipped = true;
      }
      if (searchTanggal.isNotEmpty &&
          !FormatTanggal.formatTanggal(data.tanggalBerangkat)
              .contains(searchTanggal.toLowerCase())) {
        skipped = true;
      }
      if (searchPerbaikan && data.listPerbaikan.isEmpty) {
        skipped = true;
      }

      if (!skipped) {
        listTransaksi.add(data);
      }
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
      listMobil.clear();
      listMobil.addAll(backupListMobil);
    } else {
      listMobil = backupListMobil
          .where((element) =>
              element.nama_mobil.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
