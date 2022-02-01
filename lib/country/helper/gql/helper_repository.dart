import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zuelligcoddingchallenge/country/bloc/country_bloc.dart';
import 'package:zuelligcoddingchallenge/model/contact_model.dart';

part 'gql_query.dart';
part 'gql_client.dart';

abstract class HelperRepositoryBase{
  
}

class HelperRepository extends HelperRepositoryBase{
  HelperRepository._();
  static final HelperRepository _instance = HelperRepository._();
  static HelperRepository get instance => _instance;
  GraphQLClient get gqlClient => Gql.client;
  GqlQuery get gqlQuery => GqlQuery.instance;
  
  
}