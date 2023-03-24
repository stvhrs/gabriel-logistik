class Pengeluaran {
  String mobil;
  String jenis;
  double harga;
  String tanggal;
  String keterangan;
  Pengeluaran(this.mobil,this.jenis, this.harga, this.tanggal, this.keterangan);
  factory Pengeluaran.fromMap(Map<String, dynamic> data) {
    return Pengeluaran(
        data['mobil'], data['jenis'],data['harga'], data['tanggal'], data['keterangan']);
        
  }
}
