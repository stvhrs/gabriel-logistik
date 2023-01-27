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
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Container(
        child: ChoiceChip(backgroundColor: _selected?Theme.of(context).colorScheme.secondary:Colors.grey.shade200,
          padding: EdgeInsets.all(10),
          label: Text(
            'Mengalami Perbaikan',
            style: TextStyle(color: _selected ? Colors.white : Colors.black),
          ),
          labelPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
          selected: _selected,
          onSelected: (value) {
            setState(() {
              _selected = !_selected;
              Provider.of<ProviderData>(context, listen: false)
                  .searchPerbaikan = _selected;
              Provider.of<ProviderData>(context, listen: false)
                  .searchTransaksi();
            });
          },
        ),
      ),
    );
  }
}
