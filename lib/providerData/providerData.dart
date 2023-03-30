import 'package:flutter/cupertino.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/pengeluaran.dart';
import 'package:gabriel_logistik/models/supir.dart';

import '../models/transaksi.dart';

List<String> list = <String>[
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];

class ProviderData with ChangeNotifier {
  bool isOwner = true;
  List<Transaksi> backupTransaksi = [];
  List<Transaksi> listTransaksi = [];
  bool logined = false;
  List<JualBeliMobil> listJualBeliMobil = [];
  List<JualBeliMobil> backuplistJualBeliMobil = [];
  List<Pengeluaran> listPengeluaran = [];
  List<Pengeluaran> backupListPengeluaran = [];
  List<Mobil> listMobil = [];
  List<Supir> listSupir = [];
  List<Supir> backupListSupir = [];
  List<Mobil> backupListMobil = [];
  void owner() {
    isOwner == true;
    notifyListeners();
  }

  void admin() {
    isOwner = false;
    notifyListeners();
  }

  void login() {
    logined = true;
    notifyListeners();
  }

  void logout() {
    logined = false;
    notifyListeners();
  }

  void setData(
      List<Transaksi> data,
      bool listen,
      List<Mobil> mobilData,
      List<Supir> supirData,
      List<Pengeluaran> pengeluaran,
      List<JualBeliMobil> jualbeli) {
    print('set');
    listJualBeliMobil.clear();
    backuplistJualBeliMobil.clear();
    listJualBeliMobil.addAll(jualbeli);
    backuplistJualBeliMobil.addAll(jualbeli);

    listPengeluaran.clear();
    backupListPengeluaran.clear();
    listPengeluaran.addAll(pengeluaran);
    backupListPengeluaran.addAll(pengeluaran);

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
    listMobil.removeWhere((element) => mobil.nama_mobil==element.nama_mobil,);
       backupListMobil.removeWhere((element) => mobil.nama_mobil==element.nama_mobil,);

    notifyListeners();
  }

  void updateMobil(Mobil mobil) {
    int data = listMobil
        .indexWhere((element) => element.nama_mobil == mobil.nama_mobil);

    listMobil[data] = mobil;
    notifyListeners();
  }

  void addSupir(Supir supir) {
    listSupir.insert(0, supir);
    backupListSupir.insert(0, supir);
    notifyListeners();
  }

  void deleteSupir(Supir supir) {
    listSupir.remove(supir);
    backupListSupir.remove(supir);
    notifyListeners();
  }

  void updateSupir(Supir supir) {
    int data = listSupir
        .indexWhere((element) => element.nama_supir == supir.nama_supir);
    listSupir[data] = supir;
    notifyListeners();
  }

  void addJualBeliMobil(JualBeliMobil jualBeliMobil) {
    listJualBeliMobil.insert(0, jualBeliMobil);
    backuplistJualBeliMobil.insert(0, jualBeliMobil);
    notifyListeners();
  }

  void deleteJualBeliMobil(JualBeliMobil supir) {
    listJualBeliMobil.remove(supir);
    backuplistJualBeliMobil.remove(supir);
    notifyListeners();
  }

  void updateJualBeliMobil(JualBeliMobil jualBeliMobil) {
    int data = listJualBeliMobil.indexWhere((element) =>
        (element.mobil + element.tanggal) ==
        (jualBeliMobil.mobil + jualBeliMobil.tanggal));
    listJualBeliMobil[data] = jualBeliMobil;
    notifyListeners();
  }

  void addPengeluaran(Pengeluaran pengeluaran) {
    listPengeluaran.insert(0, pengeluaran);
    backupListPengeluaran.insert(0, pengeluaran);
    notifyListeners();
  }

  void deletePengeluaran(Pengeluaran pengeluaran) {
    listPengeluaran.remove(pengeluaran);
    backupListPengeluaran.remove(pengeluaran);
    notifyListeners();
  }

  void updatePengeluaran(Pengeluaran pengeluaran) {
    int data = listPengeluaran.indexWhere((element) =>
        (element.mobil) ==
        (pengeluaran.mobil));
    listPengeluaran[data] = pengeluaran;
    notifyListeners();
  }

  void addTransaksi(Transaksi transaksi) {
    listTransaksi.insert(0, transaksi);
    backupTransaksi.insert(0, transaksi);

    List<Map<String, dynamic>> test = [];
    for (var element in backupTransaksi) {
      test.add(Transaksi.toMap(element));
    }


    notifyListeners();
  }

  void deleteTransaksi(Transaksi transaksi) {
    listTransaksi.remove(transaksi);
    backupTransaksi.remove(transaksi);
    notifyListeners();
  }

  void updateTransaksi(Transaksi transaksi) {
    int data = listTransaksi.indexWhere(
        (element) => element.tanggalBerangkat == transaksi.tanggalBerangkat);

    listTransaksi[data] = transaksi;
    backupTransaksi[data] = transaksi;
    notifyListeners();
  }

  String searchmobile = '';
  String searchsupir = '';
  String searchtujuan = '';
  bool searchPerbaikan = false;

  DateTime? start;
  DateTime? end;
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
      if (start != null) {
        if (DateTime.parse(data.tanggalBerangkat).isBefore(start!) ||
            DateTime.parse(data.tanggalBerangkat).isAfter(end!)) {
          skipped = true;
        }
      }
      if (searchPerbaikan) {
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

  void searchPengeluaran(String val) {
    if (val.isEmpty) {
      listPengeluaran.clear();
      listPengeluaran.addAll(backupListPengeluaran);
    } else {
      listPengeluaran = backupListPengeluaran
          .where((element) =>
              element.mobil.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchJual(String val) {
    if (val.isEmpty) {
      listJualBeliMobil.clear();
      listJualBeliMobil.addAll(backuplistJualBeliMobil);
    } else {
      listJualBeliMobil = backuplistJualBeliMobil
          .where((element) =>
              element.mobil.toLowerCase().startsWith(val.toLowerCase()))
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
