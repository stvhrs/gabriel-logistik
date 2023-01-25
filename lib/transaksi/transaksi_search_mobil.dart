import 'package:flutter/material.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchMobil extends StatefulWidget {
  const SearchMobil({super.key});

  @override
  State<SearchMobil> createState() => _SearchMobilState();
}

class _SearchMobilState extends State<SearchMobil> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       
        width: MediaQuery.of(context).size.width * 0.15,
        child: TextFormField(
          onChanged: (val) {
            Provider.of<ProviderData>(context, listen: false).searchmobile=val;
              Provider.of<ProviderData>(context, listen: false)
                  .searchTransaksi();
            
          },
          decoration: const InputDecoration(
            hintText: 'Mobil',
          ),
        ));
  }
}
