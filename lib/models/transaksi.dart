
class Transaksi {

  String tanggalBerangkat;

  String supir;
  String mobil;
  String tujuan;
  String keterangan;
  double keluar;
  double ongkos;
  double sisa;
  

  Transaksi(
  
      this.tanggalBerangkat,
      this.keterangan,
      this.supir,
      this.mobil,
      this.tujuan,
      this.keluar,
      this.ongkos,
      this.sisa,
     );

  factory Transaksi.fromMap(Map<String, dynamic> data) {
   
    return Transaksi(

        data['tgl_berangkat'],
        data['keterangan']??'',
        data['supir'],
        data['mobil'],
        data['tujuan'],
        data['keluar'],
        data['ongkos'],
        data['sisa'],
        );
  }
 
  static Map<String, dynamic> toMap(Transaksi data) {
    

    return {

      'tgl_berangkat': data.tanggalBerangkat,
      'keterangan': data.keterangan,
      'supir': data.supir,
      'tujuan': data.tujuan,
      'mobil': data.mobil,
      'keluar': data.keluar,
      'ongkos': data.ongkos,
     
    };
  }
}
