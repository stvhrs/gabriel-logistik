import 'package:gabriel_logistik/models/transaksi.dart';

import 'laporan_bulanan.dart';

class KasModel {

  String namaSupir;
  List<BulanSupir> listBulananSupir;
  double totalBersih;
  double? totalPersenSupir;
  double totalPerbaikan;


  KasModel(this.namaSupir, this.listBulananSupir, this.totalBersih,
      this.totalPersenSupir, this.totalPerbaikan,);


}
