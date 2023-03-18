class Pengeluaran {
  String nama_pengeluran;
  double harga_pengeluaran;
String tanggal;
String keterangan;
  Pengeluaran(this.nama_pengeluran, this.harga_pengeluaran,this.tanggal,this.keterangan);
  static fromMap(Map<String, dynamic> data) {
    return Pengeluaran(data['nama_pengeluran'], data['harga_pengeluaran'],data['tanggal'],data['keterangan']);
  }
   static toMap(Pengeluaran data) {
    return { 'nama_pengeluran':data.nama_pengeluran, 'harga_pengeluaran':data.harga_pengeluaran};
  }
     Map<String, dynamic> toJson() => {
        "nama_pengeluran": nama_pengeluran,
        "harga_pengeluaran": harga_pengeluaran,
    };  
}
