import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/input_currency.dart';

class TransaksiAdd extends StatefulWidget {
  const TransaksiAdd({super.key});

  @override
  State<TransaksiAdd> createState() => _TransaksiAddState();
}

class _TransaksiAddState extends State<TransaksiAdd> {
  final TextEditingController _controller = TextEditingController();
  int jumlahOpsi = 1;

  List<Transaksi> _updatedTransaksi = [
    Transaksi.fromMap(
      {
        'id_transaksi': 1,
        'tgl_berangkat': '2022-07-20T20:18:04.000Z',
        'tanggalPulang': '2022-07-20T20:18:04.000Z',
        'supir': 'Budi',
        'tujuan': 'Gemolong',
        'mobil': 'Ford AD 9999 RR',
        'gajiSupir': 100,
        'totalCost': 400,
        'perbaikan_transaksi': []
      },
    )
  ];
  List<String> itemsTransaksi = [];
  Widget _buildPartName(int i, BuildContext context) {
    List<Transaksi> transaksi =
        Provider.of<ProviderData>(context, listen: false).listTransaksi;
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: 'Part'),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'Harga'),
                        onChanged: (value) {
                          if (_updatedTransaksi.isNotEmpty) {
                            _updatedTransaksi[i]
                                .listPerbaikan[jumlahOpsi]
                                .harga_perbaikan = NumberFormat.currency(
                                    locale: 'id_ID', symbol: 'Rp ')
                                .parse(value)
                                .toDouble();
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                      ),
                    ),
                  ],
                )));
  }

  Widget _buildSize(widget, String ket, double width) {
    return Container(
      width: width,
      margin: EdgeInsets.only(right: 45, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 7),
              child: Text(
                ket + ' :',
                style: TextStyle(fontSize: 13),
              )),
          widget
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Transaksi> Transaksis =
        Provider.of<ProviderData>(context, listen: false).listTransaksi;

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        actionsPadding:
                            const EdgeInsets.only(right: 15, bottom: 15),
                        content: Container(
                          decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    IntrinsicHeight(
                              child: Container(padding: EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Tambah Transaksi',style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(height: 30,),
                                      Container(
                                        // margin: EdgeInsets.only(bottom: 50),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildSize(
                                                DropDownField(
                                                  onValueChanged: (val) {},
                                                  items: Transaksis.map(
                                                      (e) => e.supir).toList(),
                                                ),
                                                'Pilih Supir',
                                                200),
                                            _buildSize(
                                                DropDownField(
                                                  onValueChanged: (val) {},
                                                  items: Transaksis.map(
                                                      (e) => e.mobil).toList(),
                                                ),
                                                'Pilih Mobil',
                                                200),
                                            _buildSize(TextFormField(),
                                                'Ketik Tujuan', 200),
                                            _buildSize(
                                                WebDatePicker(
                                                  height: 60,
                                                  initialDate: DateTime.now(),
                                                  dateformat: 'dd/MM/yyyy',
                                                  onChange: (value) {},
                                                ),
                                                'Tanggal',
                                                200)
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          _buildSize(
                                              TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  CurrencyInputFormatter()
                                                ],
                                              ),
                                              'Biaya Keluar',
                                              200),
                                          _buildSize(
                                              TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  CurrencyInputFormatter()
                                                ],
                                              ),
                                              'Biaya Ongkos',
                                              200),
                                          _buildSize(TextFormField(),
                                              'Keterangan', 400),
                                        ],
                                      ),
                                      Text(
                                        'Perbaikan :',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      Divider(),
                                      ...List.generate(
                                          jumlahOpsi,
                                          (index) =>
                                              _buildPartName(index, context)),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (jumlahOpsi ==
                                                      _updatedTransaksi
                                                          .length) {
                                                    _updatedTransaksi.add(
                                                        _updatedTransaksi[0]);

                                                    jumlahOpsi = jumlahOpsi + 1;
                                                  }
                                                });
                                              },
                                              icon: const Icon(Icons.add)),
                                          // Text(jumlahOpsi.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  });
            }));
  }
}
