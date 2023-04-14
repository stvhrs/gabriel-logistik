
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

import 'package:flutter/material.dart';

import '../helper/format_tanggal.dart';

class HpTransaksiTile extends StatefulWidget {
  final Transaksi _transaksi;
  final int index;

   const HpTransaksiTile(this._transaksi, this.index);

  @override
  State<HpTransaksiTile> createState() => _HpTransaksiTileState();
}

class _HpTransaksiTileState extends State<HpTransaksiTile> {
 
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: hover
            ? Colors.amber.shade100
            : widget.index.isEven
                ? Colors.grey.shade200
                :  const Color.fromARGB(255, 189, 193, 221),
        padding:
             const EdgeInsets.only(top: 14, bottom: 14,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Expanded(
                flex: 7,
                child:Text(style:const TextStyle(fontSize: 10, ),maxLines:1,FormatTanggal.formatTanggal(
                    widget._transaksi.tanggalBerangkat).toString())),
         
            Expanded(flex: 8, child: Text(style:const TextStyle(fontSize: 10, ),widget._transaksi.mobil)),
            Expanded(flex: 10, child: Text(style:const TextStyle(fontSize: 10, ),widget._transaksi.tujuan)),
            Expanded(
                flex: 7, child: Text(style:const TextStyle(fontSize: 10, ),Rupiah.format(widget._transaksi.ongkos))),
            Expanded(
                flex: 7, child: Text(style:const TextStyle(fontSize: 10, ),Rupiah.format(widget._transaksi.keluar))),
            // Expanded(
            //     flex: 7,
            //     child: Text(style:TextStyle(fontSize: 10, ),Rupiah.format(
            //         widget._transaksi.sisa))),
            // Expanded(
            //     flex: 7,
            //     child: Text(style:TextStyle(fontSize: 10, ),widget._transaksi.listPerbaikan.isEmpty
            //         ? '-'
            //         : Rupiah.format(
            //             totalPerbaikan(widget._transaksi.listPerbaikan)))),
           
          ],
        ),
      );
  
  }
}
