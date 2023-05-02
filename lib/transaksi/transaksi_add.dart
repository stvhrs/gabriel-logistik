import "dart:async";

import "package:gabriel_logistik/helper/rupiah_format.dart";
import "package:gabriel_logistik/models/mobil.dart";
import "package:gabriel_logistik/models/transaksi.dart";

import "package:gabriel_logistik/providerData/providerData.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:rounded_loading_button/rounded_loading_button.dart";
import "package:provider/provider.dart";
import "package:web_date_picker/web_date_picker.dart";

import "../helper/format_tanggal.dart";
import "../helper/input_currency.dart";
import '../services/service.dart';

class TransaksiAdd extends StatefulWidget {
  @override
  State<TransaksiAdd> createState() => _TransaksiAddState();
}

class _TransaksiAddState extends State<TransaksiAdd> {
  List<String> listSupir = [];
  List<String> listMobil = [];
  List<Transaksi> bulkTransaksi = [];
  TextEditingController controlerSisa = TextEditingController();
  TextEditingController controlerOngkos = TextEditingController();
  TextEditingController controlerKeluar = TextEditingController();
  TextEditingController controlerSupir = TextEditingController();
  TextEditingController controlerMobil = TextEditingController();
  TextEditingController controlerKeterangan = TextEditingController();
  TextEditingController controlerTujuan = TextEditingController();
  TextEditingController controlerKetMobil = TextEditingController();
  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false)
        .listSupir
        .map((e) => e.nama_supir)
        .toList()
        .forEach((element) {
      if (listSupir.contains(element)) {
      } else {
        listSupir.add(element);
      }
    });
    List<Mobil> temp =
        Provider.of<ProviderData>(context, listen: false).listMobil;

    temp.removeWhere((element) => element.terjual);
    temp.map((e) => e.nama_mobil).toList().forEach((element) {
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });
    listSupir.insert(0, "Pilih Supir");
    listMobil.insert(0, "Pilih Mobil");
    controlerSupir.text = "Pilih Supir";
    controlerMobil.text = "Pilih Mobil";
    super.initState();
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Transaksi transaksi;
  TextStyle small = const TextStyle(fontSize: 13.5);
  Widget _buildSize(widget, String ket, int flex) {
    return
        //  Container(height: 50,
        //   // margin: EdgeInsets.only(
        //   //     right: ket == "Keterangan Mobil" || ket == "Ketik Tujuan" ? 0 : 50,
        //   //     bottom: ket == "ket_transaksi" ? 20 : 5),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //           margin: const EdgeInsets.only(
        //             right: 7,
        //           ),
        //           child: Text(
        //             "$ket :",
        //             style: const TextStyle(fontSize: 13.5),
        //           )),
        Container(
      margin: const EdgeInsets.only(bottom: 15, left: 10),
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // clipBehavior: Clip.none,
        // alignment: Alignment.centerLeft,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$ket :",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"),
            ),
          ),
          Expanded(
            flex: 3,
            child: widget,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.library_add_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            transaksi = Transaksi.fromMap({
              "id_transaksi": "0",
              "id_mobil": "0",
              "plat_mobil": "Pilih Mobil",
              "id_supir": "0",
              "nama_supir": "Pilih Supir",
              "tanggal": DateTime.now().toIso8601String(),
              "ket_transaksi": "k",
              "tujuan": "0",
              "ongkosan": "0",
              "keluar": "0",
              "sisa": "0"
            });
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.all(0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const Text(
                          "Tambah Transaksi",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) =>
                            IntrinsicHeight(
                          child: Container(
                            height: 2000,
                            padding: const EdgeInsets.only(bottom: 20, top: 15),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  child: Column(
                                    children: [
                                      _buildSize(
                                          WebDatePicker(
                                            lastDate: DateTime.now(),
                                            height: 36,
                                            initialDate: DateTime.now(),
                                            dateformat: "dd/MM/yyyy",
                                            onChange: (value) {
                                              if (value != null) {
                                                transaksi.tanggalBerangkat =
                                                    value.toIso8601String();
                                              }
                                            },
                                          ),
                                          "Tanggal",
                                          1),
                                      _buildSize(
                                          PopupMenuButton<String>(
                                            color: Colors.grey.shade300,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 5, bottom: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(controlerMobil.text,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: "Nunito",
                                                          color: Colors.black)),
                                                  const Icon(Icons
                                                      .arrow_drop_down_sharp)
                                                ],
                                              ),
                                            ),
                                            itemBuilder: (context) => listMobil
                                                .map<PopupMenuItem<String>>(
                                                    (String value) {
                                              return PopupMenuItem<String>(
                                                onTap: () {
                                                  setState(() {
                                                    if (value ==
                                                        "Pilih Mobil") {
                                                      return;
                                                    }
                                                    controlerMobil.text = value;
                                                    transaksi.mobil = value;
                                                    transaksi
                                                        .id_mobil = Provider.of<
                                                                ProviderData>(
                                                            context,
                                                            listen: false)
                                                        .backupListMobil
                                                        .firstWhere((element) =>
                                                            element
                                                                .nama_mobil ==
                                                            value)
                                                        .id;
                                                    controlerKetMobil
                                                        .text = Provider.of<
                                                                ProviderData>(
                                                            context,
                                                            listen: false)
                                                        .listMobil
                                                        .firstWhere((element) =>
                                                            element
                                                                .nama_mobil ==
                                                            value)
                                                        .keterangan_mobill;
                                                  });
                                                },
                                                value: value,
                                                child: Column(
                                                  children: [
                                                    Text(value.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Nunito",
                                                            color:
                                                                Colors.black)),
                                                    const Divider(height: 0),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          "Pilih Mobil",
                                          1),  _buildSize(
                                          TextFormField(
                                            style:
                                                const TextStyle(fontSize: 13),
                                            textInputAction:
                                                TextInputAction.next,
                                            readOnly: true,
                                            controller: controlerKetMobil,
                                            onChanged: (val) {},
                                          ),
                                          "Keterangan Mobil",
                                          1),
                                      _buildSize(
                                          PopupMenuButton<String>(
                                            color: Colors.grey.shade300,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 5, bottom: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(controlerSupir.text,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: "Nunito",
                                                          color: Colors.black)),
                                                  const Icon(Icons
                                                      .arrow_drop_down_sharp)
                                                ],
                                              ),
                                            ),
                                            itemBuilder: (context) => listSupir
                                                .map<PopupMenuItem<String>>(
                                                    (String value) {
                                              return PopupMenuItem<String>(
                                                onTap: () {
                                                  setState(() {
                                                    transaksi.supir = value;
                                                    controlerSupir.text = value;
                                                    transaksi
                                                        .id_supir = Provider.of<
                                                                ProviderData>(
                                                            context,
                                                            listen: false)
                                                        .listSupir
                                                        .firstWhere((element) =>
                                                            element
                                                                .nama_supir ==
                                                            value)
                                                        .id;
                                                  });
                                                },
                                                value: value,
                                                child: Column(
                                                  children: [
                                                    Text(value.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Nunito",
                                                            color:
                                                                Colors.black)),
                                                    const Divider(height: 0),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          "Pilih Supir",
                                          1),
                                      _buildSize(
                                          TextFormField(
                                            style:
                                                const TextStyle(fontSize: 13),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: controlerTujuan,
                                            onChanged: (va) {
                                              transaksi.tujuan = va;
                                              setState(() {});
                                            },
                                          ),
                                          "Ketik Tujuan",
                                          1),
                                    
                                      _buildSize(
                                          TextFormField(
                                            style:
                                                const TextStyle(fontSize: 13),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: controlerOngkos,
                                            onChanged: (va) {
                                              if (va.isNotEmpty &&
                                                  va.startsWith("Rp")) {
                                                transaksi.ongkos =
                                                    Rupiah.parse(va);
                                                if (transaksi.keluar >
                                                    Rupiah.parse(va)) {
                                                  controlerSisa.text =
                                                      "Tidak boleh minus";
                                                  setState(() {});
                                                } else {
                                                  controlerSisa.text =
                                                      Rupiah.format((transaksi
                                                                  .ongkos -
                                                              transaksi.keluar))
                                                          .toString();
                                                  transaksi.sisa =
                                                      transaksi.ongkos -
                                                          transaksi.keluar;
                                                  setState(() {});
                                                }
                                              } else {
                                                transaksi.ongkos = 0;
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              CurrencyInputFormatter()
                                            ],
                                          ),
                                          "Biaya Ongkos",
                                          1),
                                      _buildSize(
                                          TextFormField(
                                            style:
                                                const TextStyle(fontSize: 13),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: controlerKeluar,
                                            onChanged: (va) {
                                              if (va.isNotEmpty &&
                                                  va.startsWith("Rp")) {
                                                transaksi.keluar =
                                                    Rupiah.parse(va);

                                                if (transaksi.ongkos <
                                                    Rupiah.parse(va)) {
                                                  controlerSisa.text =
                                                      "Tidak boleh minus";
                                                  setState(() {});
                                                } else {
                                                  transaksi.sisa =
                                                      transaksi.ongkos -
                                                          transaksi.keluar;
                                                  controlerSisa.text =
                                                      Rupiah.format((transaksi
                                                                  .ongkos -
                                                              transaksi.keluar))
                                                          .toString();
                                                  setState(() {});
                                                }
                                              } else {
                                                transaksi.keluar = 0;
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              CurrencyInputFormatter()
                                            ],
                                          ),
                                          "Biaya Keluar",
                                          1),
                                      _buildSize(
                                          TextFormField(
                                            style:
                                                const TextStyle(fontSize: 13),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: controlerSisa,
                                            readOnly: true,
                                            onChanged: (va) {
                                              if (va.isNotEmpty &&
                                                  va.startsWith("Rp")) {
                                                transaksi.keluar =
                                                    Rupiah.parse(va);
                                              } else {
                                                transaksi.keluar = 0;
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              CurrencyInputFormatter()
                                            ],
                                          ),
                                          "Sisa",
                                          1),
                                      _buildSize(
                                          TextFormField(
                                              style:
                                                  const TextStyle(fontSize: 13),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: controlerKeterangan,
                                              onChanged: (val) {
                                                transaksi.keterangan = val;
                                                setState(() {});
                                              }),
                                          "Keterangan",
                                          2),
                                      const Spacer(),
                                      Container(
                                        child: ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.arrow_right_alt_rounded,
                                              color: Colors.white,
                                            ),
                                            label: const Text(
                                              "Masukan",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                            style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.only(
                                                            right: 15,
                                                            left: 15))),
                                            onPressed: (transaksi.sisa <= 0 ||
                                                    transaksi.supir ==
                                                        "Pilih Supir" ||transaksi.mobil=="Pilih Mobil"||
                                                    transaksi.tujuan.isEmpty ||
                                                    transaksi.ongkos == 0 ||
                                                    transaksi.keluar == 0)
                                                ? null
                                                : () {
                                                    bulkTransaksi
                                                        .add(transaksi);
                                                    controlerKetMobil.text = "";
                                                    controlerMobil.text =
                                                        "Pilih Mobil";
                                                    controlerKeterangan.text =
                                                        "";
                                                    controlerOngkos.text = "";
                                                    controlerKeluar.text = "";
                                                    controlerSisa.text = "";
                                                    controlerSupir.text =
                                                        "Pilih Supir";
                                                    controlerKetMobil.text = "";
                                                    controlerTujuan.text = "";

                                                    transaksi =
                                                        Transaksi.fromMap({
                                                      "id_transaksi": "0",
                                                      "id_mobil": "0",
                                                      "plat_mobil": "Pilih Mobil",
                                                      "id_supir": "0",
                                                      "nama_supir": "Pilih Supir",
                                                      "tanggal": DateTime.now()
                                                          .toIso8601String(),
                                                      "ket_transaksi": "k",
                                                      "tujuan": "0",
                                                      "ongkosan": "0",
                                                      "keluar": "0",
                                                      "sisa": "0"
                                                    });

                                                    setState(() {});
                                                  }),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 12.5,
                                            left: 15,
                                            right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "No",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Tanggal",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  "No Pol",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: Text(
                                                  "Supir",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 10,
                                                child: Text(
                                                  "Tujuan",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Ongkosan",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Keluar",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Sisa",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Aksi",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView(
                                            padding: EdgeInsets.zero,
                                            children: bulkTransaksi.reversed
                                                .toList()
                                                .mapIndexed(
                                                    (index, element) =>
                                                        Container(
                                                          color: index.isEven
                                                              ? Colors
                                                                  .grey.shade200
                                                              : const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  189,
                                                                  193,
                                                                  221),
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          12.5,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            Text(
                                                                          style:
                                                                              small,
                                                                          (index + 1)
                                                                              .toString(),
                                                                        )),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            maxLines:
                                                                                1,
                                                                            FormatTanggal.formatTanggal(element.tanggalBerangkat).toString())),
                                                                    Expanded(
                                                                        flex: 8,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            element.mobil)),
                                                                    Expanded(
                                                                        flex: 5,
                                                                        child:
                                                                            Text(
                                                                          style:
                                                                              small,
                                                                          element
                                                                              .supir,
                                                                        )),
                                                                    Expanded(
                                                                        flex:
                                                                            10,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            element.tujuan)),

                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            Rupiah.format(element.ongkos))),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            Rupiah.format(element.keluar))),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            Rupiah.format(element.sisa))),
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            bulkTransaksi.remove(element);
                                                                            setState(() {});
                                                                          },
                                                                          icon: const Icon(
                                                                            Icons.delete_forever,
                                                                            color:
                                                                                Colors.red,
                                                                          )),
                                                                    )
                                                                    // Expanded(
                                                                    //     flex: 7,
                                                                    //     child: Text(element.listPerbaikan.isEmpty
                                                                    //         ? "-"
                                                                    //         : Rupiah.format(
                                                                    //             totalPerbaikan(element.listPerbaikan)))),
                                                                  ])),
                                                        ))
                                                .toList()),
                                      ),
                                      bulkTransaksi.isEmpty
                                          ? const SizedBox()
                                          : RoundedLoadingButton(
                                              color: Colors.green,
                                              elevation: 10,
                                              successColor: Colors.green,
                                              errorColor: Colors.red,
                                              controller: _btnController,
                                              onPressed: () async {
                                                if (bulkTransaksi.isEmpty ||
                                                    bulkTransaksi.every(
                                                        (element) =>
                                                            element.sisa < 1)) {
                                                  _btnController.error();
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1));
                                                  _btnController.reset();
                                                  return;
                                                }

                                                for (var element
                                                    in bulkTransaksi) {
                                                  var data = await Service
                                                      .postTransaksi({
                                                    "id_mobil":
                                                        element.id_mobil,
                                                    "plat_mobil": element.mobil,
                                                    "id_supir":
                                                        element.id_supir,
                                                    "nama_supir": element.supir,
                                                    "tanggal": element
                                                        .tanggalBerangkat,
                                                    "ket_transaksi":
                                                        element.keterangan,
                                                    "tujuan": element.tujuan,
                                                    "ongkosan": element.ongkos
                                                        .toString(),
                                                    "keluar": element.keluar
                                                        .toString(),
                                                    "sisa":
                                                        element.sisa.toString()
                                                  });

                                                  if (data != null) {
                                                    data.supir = element.supir;
                                                    data.mobil = element.mobil;
                                                    Provider.of<ProviderData>(
                                                            context,
                                                            listen: false)
                                                        .addTransaksi(data);
                                                  } else {
                                                    _btnController.error();
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 1),
                                                        () {});
                                                    _btnController.reset();
                                                    return;
                                                  }
                                                }

                                                _btnController.success();

                                                await Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: const Text("Tambah",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).then((value) => {bulkTransaksi.clear()});
          }),
    );
  }
}
