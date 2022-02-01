import 'package:zuelligcoddingchallenge/model/base_model.dart';

class LanguageModel extends BaseModel{
  final String? code;
  final String? name;
  final String? native;
  final bool rtl;



  LanguageModel({
    this.code,
    this.name,
    this.native,
    this.rtl = false,
  });

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  @override
  factory LanguageModel.fromMap(Map<String, dynamic> mp) {
    return LanguageModel(
      code: mp["code"],
      name: mp["name"],
      native: mp["native"],
      rtl: mp["rtl"]??false,
    );
  }
}