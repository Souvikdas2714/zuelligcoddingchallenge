import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zuelligcoddingchallenge/filter/screen/filter.dart';
import 'package:zuelligcoddingchallenge/route/route_const.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings setting){
    switch (setting.name){
      case RouteName.ALL_CONTACT:
        return MaterialPageRoute(
          builder: (context){
            return Container();
          },
          settings: setting
         );
      case RouteName.FILTER:
        return MaterialPageRoute(
            builder: (context){
              return CountryFilter();
            },
            settings: setting
        );
      default: 
        return MaterialPageRoute(builder:(_) => Container());
    }
  }
}