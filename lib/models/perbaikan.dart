class Perbaikan {
  String mobil;
  String jenis;
  double harga;
  String tanggal;
  String keterangan;
  Perbaikan(this.mobil,this.jenis, this.harga, this.tanggal, this.keterangan);
  factory Perbaikan.fromMap(Map<String, dynamic> data) {
    return Perbaikan(
        data['mobil'], data['jenis'],data['harga'], data['tanggal'], data['keterangan']);
        
  }
}
