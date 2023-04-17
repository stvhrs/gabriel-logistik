
import 'package:gabriel_logistik/models/mutasi_child.dart';

class MutasiSaldo {
 
String id;
  double totalMutasi;
 List<MutasiChild> listMutasi;
  String tanggal;
  bool pendapatan;
  String keterangan;


  MutasiSaldo(this.id,this.totalMutasi, this.listMutasi,this.tanggal,this.pendapatan,this.keterangan);
 factory MutasiSaldo.fromMap(Map<String, dynamic> data,List<MutasiChild> wkwk) {
    return MutasiSaldo(data['id'],
        data['totalMutasi'],wkwk, data['tanggal'], data['pendapatan'],data['keterangan'] );
        
  }
}
