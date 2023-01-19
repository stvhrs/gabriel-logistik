import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchTransaksi extends StatefulWidget {
  const SearchTransaksi({super.key});

  @override
  State<SearchTransaksi> createState() => _SearchTransaksiState();
}

class _SearchTransaksiState extends State<SearchTransaksi> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       
        width: MediaQuery.of(context).size.width * 0.15,
        child: TextFormField(
          onChanged: (val) {
            if (val.isEmpty) {
              Provider.of<ProviderData>(context, listen: false)
                  .restoreSearchTransaksi(val);
            } else {
              Provider.of<ProviderData>(context, listen: false)
                  .searchTransaksi(val);
            }
          },
          decoration: InputDecoration(
            hintText: 'Cari Supir/Mobil',
          ),
        ));
  }
}
