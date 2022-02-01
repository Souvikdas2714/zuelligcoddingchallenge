import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/country/widget/country_list.dart';
import 'package:zuelligcoddingchallenge/route/route_const.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<CountryBloc>(context).add(GetAllCountryEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_2_rounded),
            tooltip: 'filter',
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.FILTER);
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: BlocBuilder<CountryBloc, CountryBaseState>(
            builder: (context, countryState) {
          if (countryState is CountryNotLoadedState) {
            return const Center(child: CircularProgressIndicator());
          } else if (countryState is CountryAllAvailableState) {
            return CountryList(
              countries: countryState.countries,
              state: countryState,
            );
          } else if (countryState is CountrySearchState) {
            return CountryList(
              countries: countryState.countries,
              state: countryState,
            );
          } else if (countryState is CountryFilterState) {
            return CountryList(
              countries: countryState.countries,
              state: countryState,
            );
          } else {
            return const Center(child: Text("Country Not Available State"));
          }
        }),
      ),
    );
  }
}

