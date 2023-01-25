import 'package:flutter/material.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../helper/dropdown.dart';

class SearchPerbaikan extends StatefulWidget {
  const SearchPerbaikan({super.key});

  @override
  State<SearchPerbaikan> createState() => _SearchPerbaikanState();
}

class _SearchPerbaikanState extends State<SearchPerbaikan> {
  bool _selected=false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       
        width: MediaQuery.of(context).size.width * 0.15,
        child:     ChoiceChip(
            label: Text('Mengalami Perbaikan'),labelPadding: EdgeInsets.all(7),
            selected: _selected,selectedColor: Theme.of(context).secondaryHeaderColor,
            onSelected: (value) {
              setState(() {
             _selected= !_selected;
              Provider.of<ProviderData>(context, listen: false)
                  .searchPerbaikan=_selected;
                      Provider.of<ProviderData>(context, listen: false).searchTransaksi();  
              });
            },
          ),
      
        );
  }
}
