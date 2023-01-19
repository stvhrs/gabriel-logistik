import 'package:gabriel_logistik/models/perbaikan.dart';

class Transaksi {
  
  int transaksiId;
  String tanggalBerangkat;
  String tanggalPulang;
  String supir;
   String mobil;
  String tujuan;
 
  int gajiSupir;
  int totalCost;
 List<Perbaikan> listPerbaikan;

  Transaksi(
      this.transaksiId,
      this.tanggalBerangkat,
      this.tanggalPulang,
      this.supir,
      this.mobil,
      this.tujuan,
      this.gajiSupir,
      this.totalCost,this.listPerbaikan
     );

  factory Transaksi.fromMap(Map<String, dynamic> data) {
    List<Perbaikan> list_perbaikan=[];
    for (var element in data['perbaikan_transaksi']) {
      list_perbaikan.add(Perbaikan.fromMap(element));
    }
    return Transaksi(
        data['id_transaksi'],
        data['tgl_berangkat'],
        data['tanggalPulang'],
        data['supir'],
        data['mobil'],
        data['tujuan'],
        data['gajiSupir'],
        data['totalCost'],
       
    list_perbaikan
        
        );
  }
}
