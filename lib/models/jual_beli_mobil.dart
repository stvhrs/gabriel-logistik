
class JualBeliMobil {
  String mobil;
  String ketMobil;
  double harga;
  String tanggal;
  bool beli;
  String keterangan;
  JualBeliMobil(this.mobil,this.ketMobil, this.harga, this.tanggal,this.beli, this.keterangan);
  factory JualBeliMobil.fromMap(Map<String, dynamic> data) {
    return JualBeliMobil(
        data['nama_mobil'],data['ket_mobil'], data['harga'], data['tanggal'], data['beli'],data['keterangan']);
        
  }
}
