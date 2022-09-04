import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/url_api.dart';

Future<List<Pokemon>> fetchPokemon(int cont, List<Pokemon> pokemonList) async {
  final response = await http.get(Uri.parse('$API_URL?offset=$cont'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final list = jsonDecode(response.body);

    for (var pokemon in (list["results"] as List)) {
      final details = await http.get(Uri.parse(pokemon['url']));
      pokemonList.add(Pokemon.fromJson(
          details.statusCode == 200 ? jsonDecode(details.body) : []));
    }
    return pokemonList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pokemon');
  }
}
