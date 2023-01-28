import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/perbaikan.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/supir.dart';

import 'package:gabriel_logistik/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gabriel_logistik/transaksi/transaksi_edit.dart';
import 'package:gabriel_logistik/transaksi/transaksi_view.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/format_tanggal.dart';
import '../helper/input_currency.dart';

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
    return totalHarga;
  }

  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){},
      
      onHover: (v) {

        hover = v;
        setState(() {});
      },
      child: Container(
        color: hover
            ? Colors.amber.shade100
            : widget.index.isEven
                ? Colors.grey.shade200
                : Color.fromARGB(255, 189, 193, 221),
        padding:
            const EdgeInsets.only(top: 14, bottom: 14, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  ' ${widget.index}',
                )),
            Expanded(
                flex: 7,
                child: Text(FormatTanggal.formatTanggal(
                    widget._transaksi.tanggalBerangkat))),
            Expanded(
                flex: 5,
                child: Text(
                  widget._transaksi.supir,
                )),
            Expanded(flex: 7, child: Text(widget._transaksi.mobil)),
            Expanded(flex: 10, child: Text(widget._transaksi.tujuan)),
           
            Expanded(
                flex: 7, child: Text(Rupiah.format(widget._transaksi.ongkos))), Expanded(
                flex: 7, child: Text(Rupiah.format(widget._transaksi.keluar))),
                  Expanded(
                flex: 7, child: Text(Rupiah.format(widget._transaksi.ongkos-widget._transaksi.keluar))),
            Expanded(
                flex: 7,
                child: Text(widget._transaksi.listPerbaikan.isEmpty
                    ? '-'
                    : Rupiah.format(
                        totalPerbaikan(widget._transaksi.listPerbaikan)))),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
             TransaksiView(widget._transaksi, ),
                  const Spacer(),
                  TransaksiEdit(transaksi: widget._transaksi),
                  const Spacer(),
                  Icon(
                    Icons.delete,
                   
                    color: Colors.red.shade700,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
