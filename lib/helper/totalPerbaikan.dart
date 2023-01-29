
import '../models/perbaikan.dart';

class TotalPerbaikan{
static  totalPerbaikan(List<Perbaikan> data) {
    double totalHarga = 0;
    for (var element in data) {
      totalHarga = totalHarga + element.harga_perbaikan;
    }
    return totalHarga;
  }
    
}