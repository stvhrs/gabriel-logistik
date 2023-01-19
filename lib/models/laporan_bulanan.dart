import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

class LaporanBulanan {

  String namaSupir;
  List<Transaksi> transaksiBulanIni;
  int totalBersih;
  int? persenanSupir;
  int totalPerbaikan;
  DateTime tanggal;

  LaporanBulanan(this.namaSupir, this.transaksiBulanIni, this.totalBersih,
      this.persenanSupir, this.totalPerbaikan, this.tanggal);


}
