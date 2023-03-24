class Supir {

  String nama_supir;
  String nohp_supir;

  Supir(this.nama_supir, this.nohp_supir);

  factory Supir.fromMap(Map<String, dynamic> data) {
    return Supir( data['nama_supir'], data['nohp_supir']);
  }
}
