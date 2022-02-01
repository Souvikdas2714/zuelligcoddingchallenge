import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zuelligcoddingchallenge/country/data/country_repo.dart';
import 'package:zuelligcoddingchallenge/country/helper/gql/helper_repository.dart';
import 'package:zuelligcoddingchallenge/model/contact_model.dart';
import 'package:zuelligcoddingchallenge/model/language_model.dart';




part 'country_event.dart';
part 'country_state.dart';


class CountryBloc extends Bloc<CountryBaseEvent, CountryBaseState>{
  final HelperRepository helperRepository;
  CountryRepository? countryRepository;

  CountryBloc(
    state,
    {
      required this.helperRepository,
    }) : super(state){
    countryRepository = CountryRepository(helperRepository);
    on<GetAllCountryEvent>((event, emit) async{
      await _getAllCountry(event, emit);
    });
    on<SearchCountryEvent>((event, emit) async{
      await _getSearchCountry(event, emit);
    });
    on<ContactFilterEvent>((event, emit) async{
      await _filterCountry(event, emit);
    });
  }
  
  _getAllCountry(GetAllCountryEvent event , Emitter emit)async{
    emit(await countryRepository?.getAllCountry(event, emit));
  }

  _getSearchCountry(SearchCountryEvent event , Emitter emit)async{
    emit(await countryRepository?.searchCountry(event, emit));
  }

  _filterCountry(ContactFilterEvent event , Emitter emit)async{
    emit(await countryRepository?.filterCountry(event, emit));
  }
  
  
}