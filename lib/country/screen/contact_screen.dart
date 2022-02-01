import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/model/contact_model.dart';

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
      ),
      body: BlocBuilder<CountryBloc, CountryBaseState>(
          builder: (context, countryState) {
        if (countryState is CountryNotLoadedState) {
          return const Center(child: CircularProgressIndicator());
        } else if (countryState is CountryAllAvailableState) {
          return CountryList(countries: countryState.countries,);
        } else if (countryState is CountrySearchState) {
          return CountryList(countries: countryState.countries,);
        }else {
          return const Center(child: Text("Country Not Available State"));
        }
      }),
    );
  }
}

class CountryList extends StatelessWidget {
  final List<CountryModel> countries;
  const CountryList({Key? key, required this.countries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: countries.length+1,
        itemBuilder: (BuildContext context, int index) {
          if(index == 0){
            return Column(
              children: [
                TextFormField(
                  onChanged: (String value){
                    if(value.isEmpty){
                    }else{
                      BlocProvider.of<CountryBloc>(context).add(SearchCountryEvent(value));
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    filled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10,)
              ],
              
            );
          }
          return  Card(
            child: ListTile(
              title: Text(countries[index].name??""),
              subtitle:
                  Text(countries[index].name??""),
              isThreeLine: true,
            ),
          );
        });
  }
}
