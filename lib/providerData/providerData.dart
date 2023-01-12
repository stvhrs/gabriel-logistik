import 'package:flutter/cupertino.dart';

import '../models/transaksi.dart';

class ProviderData with ChangeNotifier{


  List<Transaksi> listTransaksi=[];
   void addTransaksi(Transaksi transaksi) {
   listTransaksi.add(transaksi);
    notifyListeners();
  }
  void setTransaksi(List<Transaksi> data) {
   listTransaksi=data;
    notifyListeners();
  }
}