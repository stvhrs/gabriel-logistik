class JualBeliMobil {
  String id;
  String id_mobil;
  String mobil;
  String ketMobil;
  double harga;
  String tanggal;
  bool beli;
  String keterangan;
  JualBeliMobil(this.id, this.id_mobil, this.mobil, this.ketMobil, this.harga,
      this.tanggal, this.beli, this.keterangan);
  factory JualBeliMobil.fromMap(Map<String, dynamic> data) {
    return JualBeliMobil(
        data['id_jb'],
        data['id_mobil'],
        data['plat_mobil'],
        'ketarangan[]',
        double.parse(data['harga_jb']),
        data['tgl_jb'],
        data['beli_jb'] == "true",
        data['ket_jb']);
  }
}
