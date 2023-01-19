class Supir {
  int id_supir;
  String nama_supir;
  String nohp_supir;

  Supir(this.id_supir, this.nama_supir, this.nohp_supir);

  factory Supir.fromMap(Map<String, dynamic> data) {
    return Supir(data['id_supir'], data['nama_supir'], data['nohp_supir']);
  }
}
