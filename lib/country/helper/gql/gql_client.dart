part of 'helper_repository.dart';

class Gql{
  static GraphQLClient get client {
    return GraphQLClient(
      link: HttpLink("https://countries.trevorblades.com/graphql"), 
      cache: GraphQLCache(
        store: InMemoryStore(),
      )
    );
  }
  
}



