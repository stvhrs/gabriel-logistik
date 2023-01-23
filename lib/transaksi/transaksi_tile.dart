import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

import '../models/perbaikan.dart';

class TransaksiTile extends StatefulWidget {
  final Transaksi _transaksi;
  final int index;

  const TransaksiTile(this._transaksi, this.index);

  @override
  State<TransaksiTile> createState() => _TransaksiTileState();
}

class _TransaksiTileState extends State<TransaksiTile> {
  totalPerbaikan(List<Perbaikan> data) {
    double totalHarga = 0;
    for (var element in data) {
      totalHarga = totalHarga + element.harga_perbaikan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index.isEven
          ? const Color.fromARGB(255, 181, 212, 238)
          : Colors.grey.shade100,
      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 11,
              child: Text(FormatTanggal.formatTanggal(
                  widget._transaksi.tanggalBerangkat))),
          Expanded(flex: 11, child: Text(widget._transaksi.supir)),
          Expanded(flex: 5, child: Text(widget._transaksi.mobil)),
          Expanded(flex: 11, child: Text(widget._transaksi.tujuan)),
          Expanded(
              flex: 11, child: Text(Rupiah.format(widget._transaksi.keluar))),
          Expanded(
              flex: 11, child: Text(Rupiah.format(widget._transaksi.ongkos))),
          Expanded(
              flex: 11,
              child: Text(Rupiah.format(
                  totalPerbaikan(widget._transaksi.listPerbaikan)))),
          const Expanded(flex: 5, child: Text('Action')),
        ],
      ),
    );
  }
}
