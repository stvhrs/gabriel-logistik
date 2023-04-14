import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

class KeuanganBulanan {
  String namaMobil;
  List<Transaksi> transaksiBulanIni;
  List<Perbaikan> pengeluranBulanIni;
  double totalBersih;
  double totalOngkos;
  double totalKeluar;
  double totalSisa;
  double totalPerbaikan;
  String bulan;

  KeuanganBulanan(
      this.namaMobil,
      this.transaksiBulanIni,
      this.pengeluranBulanIni,
      this.totalBersih,
      this.totalOngkos,
      this.totalKeluar,
      this.totalSisa,
      this.totalPerbaikan,
      this.bulan);
}
