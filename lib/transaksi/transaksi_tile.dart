import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/models/transaksi.dart';

class TransaksiTile extends StatefulWidget {
  final Transaksi _transaksi;
  final int index;

  TransaksiTile(this._transaksi, this.index);

  @override
  State<TransaksiTile> createState() => _TransaksiTileState();
}

class _TransaksiTileState extends State<TransaksiTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index.isEven
          ? Color.fromARGB(255, 181, 212, 238)
          : Colors.grey.shade100,
      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 11,
              child: Text(FormatTanggal.formatTanggal(
                  widget._transaksi.tanggalBerangkat))),
          Expanded(
              flex: 11,
              child: Text(FormatTanggal.formatTanggal(
                  widget._transaksi.tanggalPulang))),
          Expanded(flex: 5, child: Text(widget._transaksi.supir)),
          Expanded(flex: 11, child: Text(widget._transaksi.mobil)),
          Expanded(
              flex: 11,
              child: Text(widget._transaksi.tujuan)),
          Expanded(
              flex: 11, child: Text(widget._transaksi.gajiSupir.toString())),
          Expanded(flex: 11, child: Text(widget._transaksi.tujuan)),
          Expanded(flex: 5, child: Text('Action')),
        ],
      ),
    );
  }
}
