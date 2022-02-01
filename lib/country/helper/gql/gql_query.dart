
part of 'helper_repository.dart';


class GqlQuery{
  GqlQuery._();
  static final GqlQuery _instance = GqlQuery._();
  static GqlQuery get instance => _instance;
  
  String get country => """
  query Countries(\$filter: CountryFilterInput) {
      countries(filter: \$filter) {
        code
        name
        native
        phone
        capital
        currency
        emoji
        emojiU
        languages{
          code
          name
          native
          rtl
        }
      }
    }
  """;

  String get language => """
  query languages(\$input: LanguageFilterInput) {
      languages(filter: \$input) {
        code
        name
        native
        rtl
      }
    }
  """;
}