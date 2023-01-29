import 'package:flutter/material.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchTanggal extends StatefulWidget {
  const SearchTanggal({super.key});

  @override
  State<SearchTanggal> createState() => _SearchTanggalState();
}

class _SearchTanggalState extends State<SearchTanggal> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 35),
        width: MediaQuery.of(context).size.width * 0.15,
        child: TextFormField(
          onChanged: (val) {
            Provider.of<ProviderData>(context, listen: false).searchTanggal =
                val;
            Provider.of<ProviderData>(context, listen: false).searchTransaksi();
          },
          decoration: const InputDecoration(
            hintText: 'DD/MM/YYYY',
          ),
        ));
  }
}
