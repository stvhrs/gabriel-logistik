class Mobil {
  int id_mobil;
  String nama_mobil;
  String keterangan_mobill;

  Mobil(this.id_mobil, this.nama_mobil, this.keterangan_mobill);
  factory Mobil.fromMap(Map<String, dynamic> data) {
    return Mobil(data['id_mobil'], data['nama_mobil'], data['keterangan_mobill']);
  }
}

