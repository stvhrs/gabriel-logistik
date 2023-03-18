import 'package:flutter/material.dart';
import 'package:gabriel_logistik/helper/format_tanggal.dart';
import 'package:gabriel_logistik/providerData/providerData.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchTanggal extends StatefulWidget {
  const SearchTanggal({super.key});

  @override
  State<SearchTanggal> createState() => _SearchTanggalState();
}

class _SearchTanggalState extends State<SearchTanggal> {
  String _selecteRange = 'Pilih Rentang Tanggal';
  DateTimeRange? picked;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.date_range_rounded),
            InkWell(
              child: Text(
                _selecteRange,
              ),
              onTap: () async {
                dateTimeRangePicker() async {
                  picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 4),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Column(
                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 600, minHeight: 500),
                                child: Theme(
                                  data: ThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: const Color.fromARGB(
                                          255, 75, 84, 167),
                                      surface: Color.fromARGB(255, 75, 84, 167),
                                    ),

                                    // Here I Chaged the overline to my Custom TextStyle.
                                    textTheme: TextTheme(
                                        overline: TextStyle(fontSize: 16)),
                                    dialogBackgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: child!,
                                ))
                          ],
                        );
                      });
                  print(picked);
                  if (picked != null) {
                    _selecteRange = FormatTanggal.formatTanggal(
                            picked!.start.toIso8601String()) +
                        ' - ' +
                        FormatTanggal.formatTanggal(
                            picked!.end.toIso8601String());
                    Provider.of<ProviderData>(context, listen: false).start =
                        picked!.start;
                    Provider.of<ProviderData>(context, listen: false).end =
                        picked!.end;
                    Provider.of<ProviderData>(context, listen: false)
                        .searchTransaksi();
                    setState(() {});
                  }

                  ;
                }

                dateTimeRangePicker();
              },
            ),
            _selecteRange == 'Pilih Rentang Tanggal'
                ? SizedBox()
                : IconButton(
                    onPressed: () {
                      picked = null;
                      _selecteRange = 'Pilih Rentang Tanggal';
                      Provider.of<ProviderData>(context, listen: false).start =
                          null;
                      Provider.of<ProviderData>(context, listen: false).end =
                          null;
                      Provider.of<ProviderData>(context, listen: false)
                          .searchTransaksi();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
          ],
        ),
      ),
    );
  }
}
