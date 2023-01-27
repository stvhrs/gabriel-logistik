class Mobil {
  int id_mobil;
  String nama_mobil;
  String nopol_mobil;

  Mobil(this.id_mobil, this.nama_mobil, this.nopol_mobil);
  factory Mobil.fromMap(Map<String, dynamic> data) {
    return Mobil(data['id_mobil'], data['nama_mobil'], data['nopol_mobil']);
  }
}

