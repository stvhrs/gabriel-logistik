import 'package:flutter/material.dart';
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
          
              Provider.of<ProviderData>(context, listen: false)
                  .searchTransaksi(val);
            
          },
          decoration: const InputDecoration(
            hintText: 'Cari Supir/Mobil',
          ),
        ));
  }
}
