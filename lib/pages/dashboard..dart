import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/dashboard/ranguman_tile.dart';
import 'package:gabriel_logistik/helper/rupiah_format.dart';
import 'package:gabriel_logistik/logout.dart';
import 'package:provider/provider.dart';

import '../providerData/providerData.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  String jumlahSupir = '';
  String jumlahMobil = '';
  String jumlahTransaksiBulanini = '';
  String saldoSaatIni = '';
  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false).startMutasi = null;
    Provider.of<ProviderData>(context, listen: false).endMutasi = null;

    Provider.of<ProviderData>(context, listen: false).start = null;
    Provider.of<ProviderData>(context, listen: false).end = null;
    Provider.of<ProviderData>(context, listen: false).searchsupir = '';
    Provider.of<ProviderData>(context, listen: false).searchtujuan = '';
    Provider.of<ProviderData>(context, listen: false).searchmobile = '';
    Provider.of<ProviderData>(context, listen: false).searchTransaksi(false);
    Provider.of<ProviderData>(context, listen: false).calculateSaldo();
    //  Provider.of<ProviderData>(context, listen: false).searchHistorySaldo();
    Provider.of<ProviderData>(context, listen: false).calculateMutasi();
    jumlahSupir = Provider.of<ProviderData>(context, listen: false)
        .backupListSupir
        .length
        .toString();
    jumlahMobil = Provider.of<ProviderData>(context, listen: false)
        .backupListMobil
        .length
        .toString();
    jumlahTransaksiBulanini = Provider.of<ProviderData>(context, listen: false)
        .backupTransaksi
        .where((element) =>
            DateTime.parse(element.tanggalBerangkat).month ==
                DateTime.now().month &&
            DateTime.parse(element.tanggalBerangkat).year ==
                DateTime.now().year)
        .toList()
        .length
        .toString();
    saldoSaatIni = Rupiah.format(
        Provider.of<ProviderData>(context, listen: false).totalSaldo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            children: [
              Image.asset('images/title.png'),
              Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                      Provider.of<ProviderData>(context, listen: false).isOwner
                          ? 'images/boss.png'
                          : 'images/admin.png',

                      // color: Colors.white,
                    ),
                  ),
                  Text(
                    Provider.of<ProviderData>(context, listen: false).isOwner
                        ? 'Hi Owner !'
                        : 'Hi Admin !',
                    style: TextStyle(
                        fontFamily: 'Nunito', fontWeight: FontWeight.bold),
                  ),
                  // Spacer(),
                  VerticalDivider(), VerticalDivider()
                ],
              ),
              Logout()
            ],
          ),
        ),

       Padding(
         padding: const EdgeInsets.all(25.0),
         child: Column(
           children: [
             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [Rangkuman(Colors.green, saldoSaatIni, 'Saldo', Icons.attach_money_rounded),
                 Rangkuman(Colors.blue, jumlahMobil, 'Jumlah Mobil', Icons.fire_truck_rounded),
                   Rangkuman(Colors.orange, jumlahMobil, 'Jumlah Supir', Icons.people_alt_rounded),
                   Rangkuman(Colors.brown, jumlahTransaksiBulanini, 'Transaksi Bulan ini', Icons.people_alt_rounded),

               ],
             ),
           ],
         ),
       ),

      ],
    );
  }
}
