
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/country/helper/gql/helper_repository.dart';
import 'package:zuelligcoddingchallenge/model/contact_model.dart';

abstract class CountryRepositoryBase{
  
}

class CountryRepository extends CountryRepositoryBase{
  CountryRepository(this.helperRepository);
  final HelperRepository helperRepository;
  List<CountryModel> countries = [];

  Future<CountryBaseState> getAllCountry(
      GetAllCountryEvent event , Emitter emit)async{
    List<CountryModel> _countries = [];
    try{
      if(countries.isNotEmpty){
        _countries=countries;
      }else{
        try{
          QueryResult _res = await helperRepository.gqlClient.query(
              QueryOptions(document: gql(helperRepository.gqlQuery.country))
          );
          if (_res.hasException) {
            throw Exception("fetch error");
          }else if(_res.data == null){
            throw Exception("fetch error");
          }
          for(var i in _res.data?["countries"]){
            try{
              _countries.add(
                CountryModel.fromMap(i)
              );
            }catch(e, stk){
              print(e);
            }
          }
          print(_res);
        }catch(e,stk){
          print(e);
          print(stk);
          rethrow;
        }
      }
      if(_countries.isNotEmpty){
        return CountryAllAvailableState(countries: _countries);
      }else{
        return CountryNotAvailableState();
      }
    }catch(e, st){
      return CountryNotAvailableState();
    }
  }

  Future<CountryBaseState> searchCountry(
      SearchCountryEvent event , Emitter emit)async{
    List<CountryModel> _countries = [];
    try{
      if(countries.isNotEmpty){
        _countries=countries;
      }else{
        try{
          QueryResult _res = await helperRepository.gqlClient.query(
              QueryOptions(document: gql(helperRepository.gqlQuery.country))
          );
          if (_res.hasException) {
            throw Exception("fetch error");
          }else if(_res.data == null){
            throw Exception("fetch error");
          }
          for(var i in _res.data?["countries"]){
            try{
              _countries.add(
                  CountryModel.fromMap(i)
              );
            }catch(e, stk){
              print(e);
            }
          }
          print(_res);
        }catch(e,stk){
          print(e);
          print(stk);
          rethrow;
        }
      }
      _countries.removeWhere((CountryModel e) {
        try{
          return !e.code!.toLowerCase().contains(event.keyword.toLowerCase());
        }catch(e){
          return false;
        }
      });
      return CountrySearchState(countries: _countries);
    }catch(e, st){
      return CountryNotAvailableState();
    }
  }
    

}