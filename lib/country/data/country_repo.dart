import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/country/helper/gql/helper_repository.dart';
import 'package:zuelligcoddingchallenge/model/contact_model.dart';
import 'package:zuelligcoddingchallenge/model/language_model.dart';

abstract class CountryRepositoryBase {}

class CountryRepository extends CountryRepositoryBase {
  CountryRepository(this.helperRepository);
  final HelperRepository helperRepository;
  List<LanguageModel> language = [];

  Future<CountryBaseState> getAllCountry(
      GetAllCountryEvent event, Emitter emit) async {
    fetchLanguage();
    List<CountryModel> _countries = [];
    try {
      try {
        QueryResult _res = await helperRepository.gqlClient.query(
            QueryOptions(document: gql(helperRepository.gqlQuery.country)));
        if (_res.hasException) {
          throw Exception("fetch error");
        } else if (_res.data == null) {
          throw Exception("fetch error");
        }
        for (var i in _res.data?["countries"]) {
          try {
            _countries.add(CountryModel.fromMap(i));
          } catch (e, stk) {
            print(e);
          }
        }
      } catch (e, stk) {
        print(e);
        print(stk);
        rethrow;
      }
      if (_countries.isNotEmpty) {
        return CountryAllAvailableState(countries: _countries);
      } else {
        return CountryNotAvailableState();
      }
    } catch (e, st) {
      return CountryNotAvailableState();
    }
  }

  Future<CountryBaseState> searchCountry(
      SearchCountryEvent event, Emitter emit) async {
    List<CountryModel> _countries = [];
    try {
      try {
        QueryResult _res = await helperRepository.gqlClient.query(QueryOptions(
            document: gql(
              helperRepository.gqlQuery.country,
            ),
            variables: {
              "filter": {
                "code": {"eq": event.keyword.toUpperCase()}
              }
            }));
        if (_res.hasException) {
          throw Exception("fetch error");
        } else if (_res.data == null) {
          throw Exception("fetch error");
        }
        for (var i in _res.data?["countries"]) {
          try {
            _countries.add(CountryModel.fromMap(i));
          } catch (e, st) {
            print(i);
            print(e);
            print(st);
          }
        }

      } catch (e, stk) {
        print(e);
        print(stk);
        rethrow;
      }
      return CountrySearchState(countries: _countries, keyword: event.keyword);
    } catch (e, st) {
      print(st);
      print(e);
      return CountryNotAvailableState();
    }
  }

  Future<CountryBaseState> filterCountry(
      ContactFilterEvent event, Emitter emit) async {
    List<CountryModel> _countries = [];
    try {
      try {
        QueryResult _res = await helperRepository.gqlClient.query(QueryOptions(
            document: gql(helperRepository.gqlQuery.country,
            )));
        if (_res.hasException) {
          throw Exception("fetch error");
        } else if (_res.data == null) {
          throw Exception("fetch error");
        }
        for (var i in _res.data?["countries"]) {
          try {
            CountryModel _cnt = CountryModel.fromMap(i);
            if(_cnt.languageMatch(event.languageModel)){
              _countries.add(CountryModel.fromMap(i));
            }
          } catch (e, st) {
            print(i);
            print(e);
            print(st);
          }
        }

      } catch (e, stk) {
        print(e);
        print(stk);
        rethrow;
      }
      return CountryFilterState(countries: _countries);
    } catch (e, st) {
      print(st);
      print(e);
      return CountryNotAvailableState();
    }
  }

  Future<void> fetchLanguage() async {
    try {
      QueryResult _res = await helperRepository.gqlClient.query(QueryOptions(
        document: gql(
          helperRepository.gqlQuery.language,
        ),
      ));
      if (_res.hasException) {
        throw Exception("fetch error");
      } else if (_res.data == null) {
        throw Exception("fetch error");
      }
      for(var i in _res.data?["languages"]){
        try{
          language.add(
            LanguageModel.fromMap(i)
          );
        }catch(e, st){
          print(e);
          print(st);
        }
      }
      print(_res.data);
    } catch (e, st) {
      print(e);
      print(st);
    }
  }
}
