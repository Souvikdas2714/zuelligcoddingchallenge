import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/model/language_model.dart';

class CountryFilter extends StatefulWidget {
  const CountryFilter({Key? key}) : super(key: key);

  @override
  State<CountryFilter> createState() => _CountryFilterState();
}

class _CountryFilterState extends State<CountryFilter> {
  LanguageModel? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButton<LanguageModel>(
              value: selectedLanguage,
              elevation: 16,
              isExpanded : true,
              hint: const Text("Select Language"),
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (LanguageModel? newValue) {
                setState(() {
                  selectedLanguage = newValue;
                });
              },
              items: BlocProvider.of<CountryBloc>(context).countryRepository?.language
                .map<DropdownMenuItem<LanguageModel>>((LanguageModel value) {
                return DropdownMenuItem<LanguageModel>(
                  value: value,
                  child: Text(value.name??""),
                );
              }).toList(),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                if(selectedLanguage != null){
                  BlocProvider.of<CountryBloc>(context).add(ContactFilterEvent(selectedLanguage!));
                  Navigator.pop(context);
                }
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
