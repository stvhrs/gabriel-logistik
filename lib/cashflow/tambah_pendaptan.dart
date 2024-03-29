import 'dart:async';
import 'dart:developer';

import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/models/mutasi_child.dart';
import 'package:gabriel_logistik/models/mutasi_saldo.dart';


import 'package:gabriel_logistik/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/input_currency.dart';

class TambahPendapatan extends StatefulWidget {
  final bool pendapatan;
  const TambahPendapatan(this.pendapatan);

  @override
  State<TambahPendapatan> createState() => _TambahPendapatanState();
}

class _TambahPendapatanState extends State<TambahPendapatan> {
  int jumlahOpsi = 1;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late MutasiSaldo mutasi;
  @override
  void initState() {
    mutasi= MutasiSaldo.fromMap(
    {
       "id_mutasi": "0",
        "pendapatan_mutasi":widget.pendapatan? "true":"false",
        "tanggal_mutasi": DateTime.now().toIso8601String(),
        "keterangan_mutasi": "ket",
        
        "total_mutasi": "0"
    },
  [ MutasiChild.fromMap(
          {
                "keterangan": "Keterangan",
                "harga": "0",
                "qty": "0",
                "total": "0"
            },
        )]);
    super.initState();
  }

  List<TextEditingController> total = [TextEditingController()];

  List<TextEditingController> qty = [TextEditingController()];

  List<TextEditingController> harga = [TextEditingController()];
  TextEditingController totalMutasi = TextEditingController();
  Widget _buildPartName(int i, BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: i == 0 ? 5 : 15),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 4,
                        child: SizedBox(
                            height: 36,
                            child: TextFormField(textInputAction: TextInputAction.next,
                              style: const TextStyle(fontSize: 13.5),
                              onChanged: (value) {
                                if (_updatedmutasi.isNotEmpty) {
                                  _updatedmutasi[i].keterangan = value;
                                }
                              },
                              decoration:
                                  const InputDecoration(hintText: 'Part'),
                            ))),
                    Expanded(
                        flex: 4,
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormField(textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 13.5),
                            controller: harga[i],
                            decoration:
                                const InputDecoration(hintText: 'Harga'),
                            onChanged: (value) {
                              if (_updatedmutasi.isNotEmpty) {
                                _updatedmutasi[i].harga =
                                    Rupiah.parse(value).toDouble();
                                total[i].text = Rupiah.format(
                                 _updatedmutasi[i].qty *
                                     _updatedmutasi[i].harga);
                              }
                              if (_updatedmutasi.isNotEmpty) {
                                _updatedmutasi[i].total =
                                    _updatedmutasi[i].qty *
                                        _updatedmutasi[i].harga;
                                double calculateTotalAll = 0;

                                for (var element in _updatedmutasi) {
                                  calculateTotalAll += element.total;
                                }
                                totalMutasi.text =
                                    Rupiah.format(calculateTotalAll);
                                mutasi.totalMutasi = calculateTotalAll;
                                print(calculateTotalAll);
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter()
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormField(textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 13.5),
                            controller: qty[i],
                            decoration: const InputDecoration(hintText: 'Qty'),
                            onChanged: (value) {
                              _updatedmutasi[i].qty = double.parse(value);
                              // qty[i].text = double.parse(value).toString();
                              total[i].text = Rupiah.format(
                                  _updatedmutasi[i].qty *
                                      _updatedmutasi[i].harga);
                              log('total mas');
                              if (_updatedmutasi.isNotEmpty) {
                                _updatedmutasi[i].total =
                                    _updatedmutasi[i].qty *
                                        _updatedmutasi[i].harga;
                                double calculateTotalAll = 0;

                                for (var element in _updatedmutasi) {
                                  calculateTotalAll += element.total;
                                }
                                mutasi.totalMutasi = calculateTotalAll;
                                print(calculateTotalAll);
                                totalMutasi.text =
                                    Rupiah.format(calculateTotalAll);
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 20),
                          child: TextFormField(textInputAction: TextInputAction.next,
                            style: const TextStyle(fontSize: 13.5),
                            readOnly: true,
                            controller: total[i],
                            decoration:
                                const InputDecoration(hintText: 'Total'),
                            onChanged: (value) {},
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter()
                            ],
                          ),
                        )),
                  ],
                )));
  }

  final List<MutasiChild> _updatedmutasi = [
    MutasiChild.fromMap(
      {'keterangan': '', 'harga': "0", 'qty': "0", 'total': "0"},
    )
  ];
  @override
  Widget build(BuildContext context) {
    mutasi.pendapatan = widget.pendapatan;
    print(mutasi.pendapatan);
    return Container(
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    widget.pendapatan ? Colors.green : Colors.red)),
            child: Text(
              widget.pendapatan ? 'Uang Masuk' : 'Uang Keluar',
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).primaryColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            widget.pendapatan ? 'Uang Masuk' : 'Uang Keluar',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 13,
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      titlePadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)),
                        child: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) =>
                                  IntrinsicHeight(
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 600),
                              padding: const EdgeInsets.only(
                                  bottom: 20, left: 20, right: 20, top: 15),
                              width: MediaQuery.of(context).size.width * 0.52,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        // margin: EdgeInsets.only(bottom: 50),
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: 150,
                                            height: 36,
                                            child: WebDatePicker(
                                              height: 60,
                                              initialDate: DateTime.now(),
                                              dateformat: 'dd/MM/yyyy',
                                              onChange: (value) {
                                                if (value != null) {
                                                  mutasi.tanggal =
                                                      value.toIso8601String();
                                                }
                                              },
                                            )),
                                        SizedBox(
                                          width: 150,
                                          height: 36,
                                          child: TextFormField(textInputAction: TextInputAction.next,
                                            style: const TextStyle(fontSize: 13.5),
                                            decoration: const InputDecoration(
                                                hintText: 'Keterangan'),
                                            onChanged: (v) {
                                              mutasi.keterangan = v;
                                            },
                                          ),
                                        )
                                      ],
                                    )),
                                    const Divider(height: 12),
                                    const Divider(height: 12),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(3),
                                              topRight: Radius.circular(3))),
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                        left: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                'Deskripsi',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Harga',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                  ))),
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Qty',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                  ))),
                                          Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.only(left: 20),
                                                child: Text(
                                                  'Total',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              )),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),SizedBox(height: MediaQuery.of(context).size.height*0.35,
                                      child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      ...List.generate(
                                        jumlahOpsi,
                                        (index) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                flex: 15,
                                                child: _buildPartName(
                                                    index, context)),
                                            Expanded(
                                              flex: 1,
                                              child: index == 0
                                                  ? const SizedBox()
                                                  : Container(
                                                      margin: const EdgeInsets.only(
                                                          left: 5),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            if (jumlahOpsi > 1) {
                                                              _updatedmutasi.remove(
                                                                  _updatedmutasi[
                                                                      index]);
                                                              jumlahOpsi =
                                                                  jumlahOpsi - 1;
                                                              total.remove(
                                                                  total[index]);
                                                              harga.remove(
                                                                  harga[index]);
                                                              qty.remove(
                                                                  qty[index]);
                                                              double
                                                                  calculateTotalAll =
                                                                  0;

                                                              for (var element
                                                                  in _updatedmutasi) {
                                                                calculateTotalAll +=
                                                                    element.total;
                                                              }
                                                              totalMutasi.text =
                                                                  Rupiah.format(
                                                                      calculateTotalAll);
                                                              mutasi.totalMutasi =
                                                                  calculateTotalAll;
                                                              print(
                                                                  calculateTotalAll);
                                                              setState(() {});
                                                            }
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          )),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      )])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (jumlahOpsi ==
                                                    _updatedmutasi.length) {
                                                  _updatedmutasi.add(
                                                    MutasiChild.fromMap({
                                                      'keterangan': '',
                                                      'harga': 0,
                                                      'qty': 1,
                                                      'total': 0
                                                    }),
                                                  );

                                                  jumlahOpsi = jumlahOpsi + 1;
                                                  total.add(
                                                      TextEditingController());
                                                  harga.add(
                                                      TextEditingController());
                                                  qty.add(
                                                      TextEditingController());
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.add_circle,
                                              color: Colors.green,
                                              size: 25,
                                            )),
                                      ),
                                    ),
                                       const Divider(height: 12),
                                    const Divider(height: 12),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text('Total ${widget.pendapatan?"Masuk :":"Keluar :"}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                        SizedBox(
                                            height: 36,
                                            width: 150,
                                            child: TextFormField(textInputAction: TextInputAction.next,
                                             style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                              readOnly: true,
                                              controller: totalMutasi,
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.white),
          ),
                                                  
                                                  fillColor: Colors.white,
                                                  hintText: ''),
                                            )),
                                      ],
                                    ),const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(margin: const EdgeInsets.only(top: 10),
                                    child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [RoundedLoadingButton(width: 120,color: Colors.red,controller:
                                         RoundedLoadingButtonController(), onPressed: (){
                                          Navigator.of(context).pop();
                                         }, child: const Text('Batal',
                                                style: TextStyle(color: Colors.white))),
                                          RoundedLoadingButton(width: 120,
                                        color: Colors.green,
                                        successColor: Colors.green,
                                        errorColor: Colors.red,
                                        controller: _btnController,
                                        onPressed: () async {
                                          bool empty = false;

                                          for (var element in _updatedmutasi) {
                                            if (element.keterangan == '' ||
                                                mutasi.keterangan == '' ||
                                                element.total <= 0) {
                                              empty = true;
                                            }
                                          }
                                          if (empty) {
                                            _btnController.error();
                                            _btnController.reset();
                                            return;
                                          } else {
                                            for (var element
                                                in _updatedmutasi) {
                                              mutasi.listMutasi.add(element);
                                            }
                                          }

                                          await Future.delayed(
                                              const Duration(seconds: 3), () {
                                            Provider.of<ProviderData>(context,
                                                    listen: false)
                                                .addmutasi(mutasi);
                                            _btnController.success();
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 2), () {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text('Simpan',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )])),
                                    ),const Spacer()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                    );
                  }).then((value) {
                    jumlahOpsi=1;
                    total.clear();
                    qty.clear();
                    harga.clear();
                       total.add(
                                                      TextEditingController());
                                                  harga.add(
                                                      TextEditingController());
                                                  qty.add(
                                                      TextEditingController());
                _updatedmutasi.clear();
                _updatedmutasi.add(MutasiChild.fromMap(
                  {'keterangan': '', 'harga': 0, 'qty': 1, 'total': 0},
                ));
                mutasi = MutasiSaldo.fromMap(
                  {
                    'pendapatan': true,
                    'keterangan': '',
                    'id': '1',
                    'tanggal': DateTime.now().toIso8601String(),
                    'mutasi': [].map((e) => MutasiChild.fromMap(e)).toList(),
                    'totalMutasi': 0
                  },[ MutasiChild.fromMap(
          {'keterangan': 'Sewa Ruko', 'harga': 0, 'qty': 1, 'total': 0},
        )]
                  
                );
                setState(() {
                  
                });
              });
            }));
  }
}
