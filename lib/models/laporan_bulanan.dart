import 'package:gabriel_logistik/models/transaksi.dart';

class BulanSupir {

  String namaSupir;
  List<Transaksi> transaksiBulanIni;
  double totalBersih;
  double? persenanSupir;
  double totalPerbaikan;
  String bulan;

  BulanSupir(this.namaSupir, this.transaksiBulanIni, this.totalBersih,
      this.persenanSupir, this.totalPerbaikan, this.bulan);


}
