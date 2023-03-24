import 'package:gabriel_logistik/models/mobil.dart';

class JualBeliMobil {
  String mobil;
  double harga;
  String tanggal;
  bool beli;
  String keterangan;
  JualBeliMobil(this.mobil, this.harga, this.tanggal,this.beli, this.keterangan);
  factory JualBeliMobil.fromMap(Map<String, dynamic> data) {
    return JualBeliMobil(
        data['nama_mobil'], data['harga'], data['tanggal'], data['beli'],data['keterangan']);
        
  }
}
