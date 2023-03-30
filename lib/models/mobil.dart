import 'package:gabriel_logistik/models/pengeluaran.dart';

class Mobil {
  bool terjual;
  String nama_mobil;
  String keterangan_mobill;
  List<Pengeluaran> pengeluaran;
  Mobil(this.terjual,
  this.nama_mobil, this.keterangan_mobill, this.pengeluaran);
  factory Mobil.fromMap(Map<String, dynamic> data,List<Pengeluaran> list) {


    return Mobil(data['terjual']=='true'?true:false,
        data['plat_mobil'], data['ket_mobil'], list);
  }
}
