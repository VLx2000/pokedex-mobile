import 'dart:async';
import 'package:pokedex/components/pokemon_details.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/url_api.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({super.key, required this.idPokemon});
  final String idPokemon;

  Future<Pokemon> fetchPokemon(String id) async {
    final response = await http.get(Uri.parse('$API_URL/$id'));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Pokemon>(
            future: fetchPokemon(idPokemon),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PokemonDetails(pokemon: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          tooltip: 'Fechar',
          child: const Icon(Icons.close),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
