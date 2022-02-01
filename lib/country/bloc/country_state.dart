
part of 'country_bloc.dart';

abstract class BaseState{
  
}

@immutable
class CountryBaseState extends BaseState{
  
}


@immutable
class CountryNotLoadedState extends CountryBaseState{

}

@immutable
class CountryNotAvailableState extends CountryBaseState{
  
}

@immutable
class CountryAllAvailableState extends CountryBaseState{
  final List<CountryModel> countries;

  CountryAllAvailableState({
    required this.countries,
  });
  
}

@immutable
class CountrySearchState extends CountryBaseState{
  final List<CountryModel> countries;

  CountrySearchState({
    required this.countries,
  });

}
