


import 'package:zuelligcoddingchallenge/model/base_model.dart';
import 'package:zuelligcoddingchallenge/model/language_model.dart';

class CountryModel extends BaseModel{
  final String? code;
  final String? name;
  final String? native;
  final String? phone;
  final String? currency;
  final String? emoji;
  final String? emojiU;
  final String? states;
  final String? capital;
  final List<LanguageModel> language;

  CountryModel({
    this.code,
    this.name,
    this.native,
    this.capital,
    this.phone,
    this.currency,
    this.emoji,
    this.emojiU,
    this.states,
    required this.language,
  });
  
  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
  
  @override
  factory CountryModel.fromMap(Map<String, dynamic> mp) {
    List<LanguageModel> _language = [];
    try{
      for(var i in mp["languages"]){
        _language.add(
            LanguageModel.fromMap(i)
        );
      }
    }catch(e){};
    return CountryModel(
      code: mp["code"],
      name: mp["name"],
      native: mp["native"],
      capital: mp["capital"],
      phone: mp["phone"],
      currency: mp["currency"],
      emoji: mp["emoji"],
      emojiU: mp["emojiU"],
      states: mp["states"],
      language : _language,
    );
  }
  
  bool languageMatch(LanguageModel lg){
    for(LanguageModel i in language){
      if(i.code == lg.code){
        return true;
      }
    }
    return false;
  }
}
