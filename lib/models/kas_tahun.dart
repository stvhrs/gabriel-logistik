import 'keuangan_bulanan.dart';

class KasModel {
  String namaMobil;
  List<KeuanganBulanan> listBulananSupir;
  double totalBersih;
  double? totalPersenSupir;
  double totalPengeluaran;
  String tahun;

  KasModel(this.namaMobil, this.listBulananSupir, this.totalBersih,
      this.totalPersenSupir, this.totalPengeluaran, this.tahun);
}
