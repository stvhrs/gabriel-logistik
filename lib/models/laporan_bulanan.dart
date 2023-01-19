import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

class LaporanBulanan {
  Supir supir;
  List<Transaksi> listTransaksi;
  int totalBersih;

  int persenanSupir;
  int totalPerbaikan;
  DateTime tanggal;

  LaporanBulanan(this.supir, this.listTransaksi, this.totalBersih,
      this.persenanSupir, this.totalPerbaikan, this.tanggal);
}
