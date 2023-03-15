class Perbaikan {
  String nama_perbaikan;
  double harga_perbaikan;

  Perbaikan(this.nama_perbaikan, this.harga_perbaikan);
  factory Perbaikan.fromMap(Map<String, dynamic> data) {
    return Perbaikan(data['nama_perbaikan'], data['harga_perbaikan']);
  }
   static toMap(Perbaikan data) {
    return { 'nama_perbaikan':data.nama_perbaikan, 'harga_perbaikan':data.harga_perbaikan};
  }
     Map<String, dynamic> toJson() => {
        "nama_perbaikan": nama_perbaikan,
        "harga_perbaikan": harga_perbaikan,
    };  
}
