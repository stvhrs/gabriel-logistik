import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:gabriel_logistik/models/history_saldo.dart';
import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/keuangan_bulanan.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:gabriel_logistik/models/supir.dart';

import '../models/mutasi_saldo.dart';
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
  bool logined = false;

  List<Transaksi> backupTransaksi = [];
  List<Transaksi> listTransaksi = [];

  List<JualBeliMobil> listJualBeliMobil = [];
  List<JualBeliMobil> backuplistJualBeliMobil = [];

  List<Perbaikan> listPerbaikan = [];
  List<Perbaikan> backupListPerbaikan = [];

  List<Mobil> listMobil = [];
  List<Mobil> backupListMobil = [];

  List<Supir> listSupir = [];
  List<Supir> backupListSupir = [];

  List<HistorySaldo> listHistorySaldo = [];
    List<HistorySaldo> backupListHistorySaldo = [];

  List<MutasiSaldo> listMutasiSaldo = [];
List<KeuanganBulanan> printed=[];
  double totalSaldo = 0;
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
      List<Perbaikan> perbaikan,
      List<JualBeliMobil> jualbeli,
      List<MutasiSaldo> listMutasi) {
    print('set');
    listJualBeliMobil.clear();
    backuplistJualBeliMobil.clear();
    listJualBeliMobil.addAll(jualbeli);
    backuplistJualBeliMobil.addAll(jualbeli);

    listPerbaikan.clear();
    backupListPerbaikan.clear();
    listPerbaikan.addAll(perbaikan);
    backupListPerbaikan.addAll(perbaikan);

    listTransaksi.clear();
    backupTransaksi.clear();
    listTransaksi.addAll(data);
    backupTransaksi.addAll(data);

    backupListMobil.addAll(mobilData);
    backupListSupir.addAll(supirData);

    listMobil.addAll(mobilData);
    listSupir.addAll(supirData);

    listMutasiSaldo.clear();
    listMutasiSaldo.addAll(listMutasi);
    calculateSaldo();

    (listen) ? notifyListeners() : () {};
  }

  void calculateSaldo() {
    totalSaldo = 0;
    listTransaksi.every((e) {
      totalSaldo += e.sisa;
      return true;
    });

    listPerbaikan.every((e) {
      totalSaldo -= e.harga;
      return true;
    });

    listJualBeliMobil.every((e) {
      if (e.beli) {
        totalSaldo -= e.harga;
      } else {
        totalSaldo += e.harga;
      }

      return true;
    });

    listMutasiSaldo.every((e) {
      if (e.pendapatan) {
        totalSaldo += e.totalMutasi;
      } else {
        totalSaldo -= e.totalMutasi;
      }
      return true;
    });
    //  notifyListeners();
  }

  void calculateMutasi() {
    listHistorySaldo.clear();
    listTransaksi.every((e) {
      listHistorySaldo.add(HistorySaldo(
          'Transaksi', 0, e.mobil, e.sisa, e.tanggalBerangkat, true));
      return true;
    });

    listPerbaikan.every((e) {
      listHistorySaldo.add(
          HistorySaldo('Perbaikan', 0, e.mobil, -e.harga, e.tanggal, false));
      return true;
    });

    listJualBeliMobil.every((e) {
      if (e.beli) {
        listHistorySaldo.add(
            HistorySaldo('Beli Mobil', 0, e.mobil, -e.harga, e.tanggal, true));
      } else {
        listHistorySaldo.add(
            HistorySaldo('Jual Mobil', 0, e.mobil, e.harga, e.tanggal, false));
      }

      return true;
    });

    listMutasiSaldo.every((e) {
      if (e.pendapatan) {
        listHistorySaldo.add(HistorySaldo(
            'Uang Masuk', 0, e.keterangan, e.totalMutasi, e.tanggal, true));
      } else {
        listHistorySaldo.add(HistorySaldo(
            'Uang Keluar', 0, e.keterangan, -e.totalMutasi, e.tanggal, false));
      }
      return true;
    });
    listHistorySaldo.sort((a, b) =>
        DateTime.parse(b.tanggal).compareTo(DateTime.parse(a.tanggal)));
        backupListHistorySaldo.addAll(listHistorySaldo);
    double incrementMutasi = 0;
    incrementMutasi += totalSaldo;
    for (var i = 0; i < listHistorySaldo.length; i++) {
      print(incrementMutasi);
      // if (i == 0) {
      //   listHistorySaldo[0].sisaSaldo = totalSaldo;
      //   return;
      // }
     
        listHistorySaldo[i].sisaSaldo = incrementMutasi -= listHistorySaldo[i].harga;
        log('pendatapan');
     
      
      // if (i == 0) {
      //   listHistorySaldo[0].sisaSaldo = totalSaldo;
      // }
    }
    //  notifyListeners();
  }
 void addmutasi(MutasiSaldo mutasi) {
    listMutasiSaldo.add(mutasi);
   
    notifyListeners();
  }
   void deleteMutasi(MutasiSaldo mobil) {
    listMutasiSaldo.removeWhere(
      (element) => mobil.id == element.id,
    );
  
    notifyListeners();
  }
    void updateMutasi(MutasiSaldo mobil) {
    int data = listMutasiSaldo
        .indexWhere((element) => element.id == mobil.id);

    listMutasiSaldo[data] = mobil;
  
    notifyListeners();
  }
  void addMobil(Mobil mobil) {
    listMobil.add(mobil);
    backupListMobil.add(mobil);
    notifyListeners();
  }

  void deleteMobil(Mobil mobil) {
    listMobil.removeWhere(
      (element) => mobil.nama_mobil == element.nama_mobil,
    );
    backupListMobil.removeWhere(
      (element) => mobil.nama_mobil == element.nama_mobil,
    );

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

  void addPerbaikan(Perbaikan Perbaikan) {
    listPerbaikan.insert(0, Perbaikan);
    backupListPerbaikan.insert(0, Perbaikan);
    notifyListeners();
  }

  void deletePerbaikan(Perbaikan Perbaikan) {
    listPerbaikan.remove(Perbaikan);
    backupListPerbaikan.remove(Perbaikan);
    notifyListeners();
  }

  void updatePerbaikan(Perbaikan Perbaikan) {
    int data = listPerbaikan
        .indexWhere((element) => (element.mobil) == (Perbaikan.mobil));
    listPerbaikan[data] = Perbaikan;
    notifyListeners();
  }

  void addTransaksi(Transaksi transaksi) {
    listTransaksi.insert(0, transaksi);
    backupTransaksi.insert(0, transaksi);

    List<Map<String, dynamic>> test = [];
    for (var element in backupTransaksi) {
      test.add(Transaksi.toMap(element));
    }
    // calculateSaldo();
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
   DateTime? startMutasi;
  DateTime? endMutasi;
   void searchHistorySaldo() {

    listHistorySaldo.clear();
    for (var element in backupListHistorySaldo) {
      
    
      bool skipped = false;

     
      if (startMutasi != null) {
        if (DateTime.parse( element.tanggal).isBefore(startMutasi!) ||
            DateTime.parse( element.tanggal).isAfter(endMutasi!)) {
          skipped = true;
        }
      }
     

      if (!skipped) {
        listHistorySaldo.add( element);
      }
    }
     notifyListeners();
  }
  void searchTransaksi(bool listen) {
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
    listen? notifyListeners():'';
    
  }

  void searchSupir(String val,bool listen) {
    if (val.isEmpty) {
      listSupir.clear();
      listSupir.addAll(backupListSupir);
    } else {
      listSupir = backupListSupir
          .where((element) =>
              element.nama_supir.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    listen? notifyListeners():'';
  }

  void searchperbaikan(String val,bool listen) {
    if (val.isEmpty) {
      listPerbaikan.clear();
      listPerbaikan.addAll(backupListPerbaikan);
    } else {
      listPerbaikan = backupListPerbaikan
          .where((element) =>
              element.mobil.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
   listen? notifyListeners():'';
  }

  void searchJual(String val,bool listen) {
    if (val.isEmpty) {
      listJualBeliMobil.clear();
      listJualBeliMobil.addAll(backuplistJualBeliMobil);
    } else {
      listJualBeliMobil = backuplistJualBeliMobil
          .where((element) =>
              element.mobil.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    listen? notifyListeners():'';
  }

  void searchMobil(String val,bool listen) {
    if (val.isEmpty) {
      listMobil.clear();
      listMobil.addAll(backupListMobil);
    } else {
      listMobil = backupListMobil
          .where((element) =>
              element.nama_mobil.toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    listen? notifyListeners():'';
  }
}
