import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/country/helper/gql/helper_repository.dart';
import 'package:zuelligcoddingchallenge/country/screen/contact_screen.dart';

void main() {
  runApp(
    RepositoryProvider<HelperRepository>(
      create:(BuildContext context) => HelperRepository.instance,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => CountryBloc(
                CountryNotLoadedState(),
              helperRepository: RepositoryProvider.of<HelperRepository>(context)
            )
          ),
        ],
        child: const MyApp()
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const  ContactScreen(),
    );
  }
}
