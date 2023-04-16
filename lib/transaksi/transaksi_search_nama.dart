import 'package:flutter/material.dart'; 
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchNama extends StatefulWidget {
  const SearchNama({super.key});

  @override
  State<SearchNama> createState() => _SearchNamaState();
}

class _SearchNamaState extends State<SearchNama> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 35),
        width: MediaQuery.of(context).size.width * 0.15,
        child: TextFormField(
                              style: TextStyle(fontSize:13),textInputAction: TextInputAction.next,
          onChanged: (val) {
            Provider.of<ProviderData>(context, listen: false).searchsupir = val;
            Provider.of<ProviderData>(context, listen: false).searchTransaksi(true);
          },
          decoration: const InputDecoration(
            hintText: 'Supir',
          ),
        ));
  }
}
