import 'keuangan_bulanan.dart';

class KasModel {
  String namaMobil;
  List<KeuanganBulanan> listBulananMobil;
  double totalBersih;
double totalKeluar;
double totalOngkos;
double totalPengeluaran;

  String tahun;

  KasModel(this.namaMobil, this.listBulananMobil, this.totalBersih,
      this.totalKeluar,this.totalOngkos, this.totalPengeluaran, this.tahun);
}
