import 'dart:convert';
import 'dart:developer';

import 'package:gabriel_logistik/models/jual_beli_mobil.dart';
import 'package:gabriel_logistik/models/mobil.dart';
import 'package:gabriel_logistik/models/mutasi_child.dart';

import 'package:gabriel_logistik/models/supir.dart';
import 'package:gabriel_logistik/models/transaksi.dart';
import 'package:http/http.dart' as http;

import '../models/mutasi_saldo.dart';
import '../models/perbaikan.dart';

String base = 'https://cahayaover.site/api';

class Service {


  
  static Future<List<MutasiSaldo>> getAllMutasiSaldo() async {
    List<MutasiSaldo> data = [];
    final response = await http.get(
      Uri.parse(
        '$base/mutasiSaldo',
      ),
    );

    for (Map<String, dynamic> element in json.decode(response.body)) {
      List<MutasiChild> mutasiChild = [];
      print(element['detail_mutasi']);
      for (var e in json.decode(element['detail_mutasi'])) {
        print(jsonDecode(e));
      }

      data.add(MutasiSaldo.fromMap(element, mutasiChild));
    }
    return data;
  }

  static Future<List<Transaksi>> getAllTransaksi() async {
    List<Transaksi> data = [];
    final response = await http.get(
      Uri.parse(
        '$base/transaksi',
      ),
    );

    for (Map<String, dynamic> te in json.decode(response.body)) {
      data.add(Transaksi.fromMap(te));
    }

    return data;
  }

  static Future<List<Supir>> getAllSupir() async {
    List<Supir> data = [];
    final response = await http.get(
      Uri.parse(
        '$base/supir',
      ),
    );

    for (Map<String, dynamic> element in json.decode(response.body)) {
      data.add(Supir.fromMap(element));
    }
    return data;
  }

  static Future<List<Perbaikan>> getAllPerbaikan() async {
    List<Perbaikan> data = [];
    final response = await http.get(
      Uri.parse(
        '$base/perbaikan',
      ),
    );
    for (Map<String, dynamic> element in json.decode(response.body)) {
      data.add(Perbaikan.fromMap(element));
    }
    return data;
  }

  static Future<List<JualBeliMobil>> getAlljualBeli() async {
    final response = await http.get(
      Uri.parse(
        '$base/jualBeli',
      ),
    );
    List<JualBeliMobil> data = [];
    for (Map<String, dynamic> element in json.decode(response.body)) {
      data.add(JualBeliMobil.fromMap(element));
    }
    return data;
  }

  static Future<List<Mobil>> getAllMobil(List<Perbaikan> list) async {
    final response = await http.get(
      Uri.parse(
        '$base/mobil',
      ),
    );

    List<Mobil> data = [];
    for (Map<String, dynamic> te in json.decode(response.body)) {
      List<Perbaikan> listPerbaikan = list
          .where((element) =>
              (te['plat_mobil'] as String).trim() == element.mobil.trim())
          .toList();
      data.add(Mobil.fromMap(te, listPerbaikan));
    }
    return data;
  }

  static Future<Supir?> postSupir(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        body: data,
        Uri.parse(
          '$base/supir',
        ),
      );

      if (response.body.isNotEmpty) {
        return Supir.fromMap(json.decode(response.body)["0"]["supir"][0]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Supir?> updateSupir(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        body: data,
        Uri.parse(
          '$base/supir',
        ),
      );

      if (response.body.isNotEmpty) {
        return Supir.fromMap(json.decode(response.body)["0"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String> deleteSupir(String data) async {
    try {
      final response = await http.delete(
        Uri.parse('$base/supir?id_supir=$data'),
      );

      if (response.body.contains('fail')) {
        return '';
      } else {
        return data;
      }
    } catch (e) {
      return '';
    }
  }

  static Future<Mobil?> postMobil(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        body: data,
        Uri.parse(
          '$base/mobil',
        ),
      );

      if (response.body.isNotEmpty) {
        return Mobil.fromMap(json.decode(response.body)["mobil"][0], []);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Mobil?> updateMobil(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        body: data,
        Uri.parse(
          '$base/mobil',
        ),
      );

      if (response.body.isNotEmpty) {
        return Mobil.fromMap(json.decode(response.body)["0"], []);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Mobil?> deleteMobil(Map<String, dynamic> data) async {
    data["terjual"] = "true";
    try {
      final response = await http.put(
        body: data,
        Uri.parse(
          '$base/mobil',
        ),
      );

      if (response.body.isNotEmpty) {
        return Mobil.fromMap(json.decode(response.body)["0"], []);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Perbaikan?> postPerbaikan(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        body: data,
        Uri.parse(
          '$base/perbaikan',
        ),
      );

      if (response.body.isNotEmpty) {
        print(json.decode(response.body)["perbaikan"][0].toString());
        return Perbaikan.fromMap(
          json.decode(response.body)["perbaikan"][0],
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Perbaikan?> updatePerbaikan(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        body: data,
        Uri.parse(
          '$base/perbaikan',
        ),
      );

      if (response.body.isNotEmpty) {
        return Perbaikan.fromMap(
          json.decode(response.body)["0"],
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String?> deletePerbaikan(String data) async {
    final response = await http.delete(
      Uri.parse('$base/perbaikan?id_perbaikan=$data'),
    );

    if (response.body.contains('fail')) {
      return null;
    } else {
      return data;
    }
  }

  static Future<Transaksi?> postTransaksi(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        body: data,
        Uri.parse(
          '$base/transaksi',
        ),
      );
      print(data);
      print(json.decode(response.body)["transaksi"][0]);

      if (response.body.isNotEmpty) {
        return Transaksi.fromMap(json.decode(response.body)["transaksi"][0]);
      } else {
        return null;
      }
    } catch (E) {
      print(E.toString());
      return null;
    }
  }

  static Future<Transaksi?> updateTransaksi(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        body: data,
        Uri.parse(
          '$base/transaksi',
        ),
      );
      print(data);
      print(response.body);
      if (response.body.isNotEmpty) {
        return Transaksi.fromMap(json.decode(response.body)["0"]);
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static Future<String?> deleteTransaksi(String data) async {
    final response = await http.delete(
      Uri.parse('$base/transaksi?id_transaksi=$data'),
    );
    log(response.statusCode.toString());
    if (response.body.contains('fail')) {
      return null;
    } else {
      return data;
    }
  }

  static Future<JualBeliMobil?> postJB(Map<String, dynamic> data) async {
    try {
      Mobil? mobil;
      if (data["jualOrBeli"] == "false") {
        mobil = await updateMobil({
          "id_mobil": data["id_mobil"],
          'plat_mobil': data["plat_mobil"],
          "ket_mobil": data["ket_mobil"],
          "terjual": "true"
        });
        if (mobil == null) {
          return null;
        }
      } else {
        mobil = await postMobil({
          'plat_mobil': data["plat_mobil"],
          "ket_mobil": data["ket_mobil"],
          "terjual": "false"
        });
        if (mobil == null) {
          return null;
        }
      }

      data["id_mobil"] = mobil.id;

      final response = await http.post(
        body: data,
        Uri.parse(
          '$base/jualBeli',
        ),
      );
      print(response.body);
      // if (json.decode(response.body)['status'] == "false") {
      //   log("tidak boleh sama");
      // }
      if (response.body.isNotEmpty) {
        return JualBeliMobil.fromMap(json.decode(response.body)["jualbeli"][0]);
      } else {
        return null;
      }
    } catch (E) {
      print(E.toString());
      return null;
    }
  }

  static Future<JualBeliMobil?> updateJb(Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        body: data,
        Uri.parse(
          '$base/jualBeli',
        ),
      );print(json.decode(response.body));
      
        return JualBeliMobil.fromMap(json.decode(response.body)["0"]);
      
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static Future<List<MutasiSaldo>> postMutasi(
      Map<String, dynamic> mutasi) async {
    List<MutasiSaldo> data = [];
    final response = await http.post(
      body: mutasi,
      Uri.parse(
        '$base/mutasiSaldo',
      ),
    );

    for (Map<String, dynamic> element in json.decode(response.body)) {
      List<MutasiChild> mutasiChild = [];
      print(element['detail_mutasi']);
      for (Map<String, dynamic> e in json.decode(element['detail_mutasi'])) {
        print(e);
      }

      data.add(MutasiSaldo.fromMap(element, mutasiChild));
    }
    return data;
  }
}
