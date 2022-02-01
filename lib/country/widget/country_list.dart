

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/model/contact_model.dart';

class CountryList extends StatelessWidget {
final List<CountryModel> countries;
final CountryBaseState state;
const CountryList({Key? key, required this.countries, required this.state})
: super(key: key);

@override
Widget build(BuildContext context) {
  return Column(
    children: [
      TextFormField(
        onChanged: (String value) {
          if (value.isEmpty) {
            BlocProvider.of<CountryBloc>(context).add(GetAllCountryEvent());
          } else {
            BlocProvider.of<CountryBloc>(context)
                .add(SearchCountryEvent(value));
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          filled: true,
          contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      if (countries.isNotEmpty)
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(countries[index].name ?? ""),
                    subtitle: Text(countries[index].code ?? ""),
                    isThreeLine: true,
                  ),
                );
              }),
        ),
      if (state is CountrySearchState && countries.isEmpty)
        const Expanded(
            child: Center(child: Text("Country Not Available State")))
    ],
  );
}
}