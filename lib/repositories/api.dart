import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:api/models/pokemon.dart';

Future<List<Pokemon>> fetchPokemon() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));

  List<Pokemon>? pokemonList = [];

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
