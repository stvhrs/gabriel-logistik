import 'package:gabriel_logistik/models/perbaikan.dart';

class Mobil {
  String id;
  bool terjual;
  String nama_mobil;
  String keterangan_mobill;
  List<Perbaikan> perbaikan;
  Mobil(this.id,this.terjual,
  this.nama_mobil, this.keterangan_mobill, this.perbaikan);
  factory Mobil.fromMap(Map<String, dynamic> data,List<Perbaikan> list) {


    return Mobil(data['id_mobil'],data['terjual']=='false'?false:true,
        data['plat_mobil'], data['ket_mobil'], list);
  }
}
