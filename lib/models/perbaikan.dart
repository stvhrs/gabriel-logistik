class Perbaikan {
  String nama_perbaikan;
  double harga_perbaikan;

  Perbaikan(this.nama_perbaikan, this.harga_perbaikan);
  factory Perbaikan.fromMap(Map<String, dynamic> data) {
    return Perbaikan(data['nama_perbaikan'], data['harga_perbaikan']);
  }
}
