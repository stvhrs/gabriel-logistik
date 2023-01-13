class Transaksi {
  
  int transaksiId;
  String tanggalBerangkat;
  String tanggalPulang;
  String supir;
   String mobil;
  String tujuan;
 
  int gajiSupir;
  int totalCost;
  List<Map<String, dynamic>> fixCost;
  List<Map<String, dynamic>> extendedCost;

  Transaksi(
      this.transaksiId,
      this.tanggalBerangkat,
      this.tanggalPulang,
      this.supir,
      this.mobil,
      this.tujuan,
      this.gajiSupir,
      this.totalCost,
      this.fixCost,
      this.extendedCost);

  factory Transaksi.fromMap(Map<String, dynamic> data) {
    return Transaksi(
        data['transaksiId'],
        data['tanggalBerangkat'],
        data['tanggalPulang'],
        data['supir'],
        data['mobil'],
        data['tujuan'],
        data['gajiSupir'],
        data['totalCost'],
        data['fixCost'],
        data['extendedCost']);
  }
}
