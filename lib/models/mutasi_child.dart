class MutasiChild {
  double qty;
  double harga;
double total;
  String keterangan;

  MutasiChild(
    this.qty,
    this.harga,
    this.keterangan,this.total
  );
  factory MutasiChild.fromMap(Map<String, dynamic> data) {
    return MutasiChild(
      data['qty'],
      data['harga'],
      data['keterangan'],data['total']
    );
  }
}
