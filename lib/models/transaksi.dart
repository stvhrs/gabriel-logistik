import 'package:gabriel_logistik/models/perbaikan.dart';

class Transaksi {
  int transaksiId;
  String tanggalBerangkat;

  String supir;
  String mobil;
  String tujuan;
String keterangan;
  double keluar;
  double ongkos;
  List<Perbaikan> listPerbaikan;

  Transaksi(
      this.transaksiId,
      this.tanggalBerangkat,
this.keterangan,
      this.supir,
      this.mobil,
      this.tujuan,
      this.keluar,
      this.ongkos,
      this.listPerbaikan);

  factory Transaksi.fromMap(Map<String, dynamic> data) {
    List<Perbaikan> listPerbaikan = [];
    for (var element in data['perbaikan_transaksi']) {
      listPerbaikan.add(Perbaikan.fromMap(element));
    }
    return Transaksi(
        data['id_transaksi'],
        data['tgl_berangkat'],
      data['keterangan'],
        data['supir'],
        data['mobil'],
        data['tujuan'],
        data['keluar'],
        data['ongkos'],
        listPerbaikan);
  }
}
