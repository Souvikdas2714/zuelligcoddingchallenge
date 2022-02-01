
part of 'country_bloc.dart';

abstract class BaseEvent{
  
}


@immutable
class CountryBaseEvent extends BaseEvent{}

@immutable
class CountryNotLoadedEvent extends BaseEvent{}

@immutable
class GetAllCountryEvent extends CountryBaseEvent{
  
}

@immutable
class SearchCountryEvent extends CountryBaseEvent{
  final String keyword;
  SearchCountryEvent(this.keyword);
}
