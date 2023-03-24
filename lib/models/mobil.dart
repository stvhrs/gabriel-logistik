import 'package:gabriel_logistik/models/pengeluaran.dart';

class Mobil {
  String nama_mobil;
  String keterangan_mobill;
  List<Pengeluaran> pengeluaran;
  Mobil(
  this.nama_mobil, this.keterangan_mobill, this.pengeluaran);
  factory Mobil.fromMap(Map<String, dynamic> data,List<Pengeluaran> list) {


    return Mobil(
        data['nama_mobil'], data['keterangan_mobill'], list);
  }
}
