import 'dart:async';

import 'package:pokedex/components/pokemon_card.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/utils/url_api.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late Future<Pokemon> futureSearch;
  Pokemon? poke;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Pokemon?> fetchSearch(String name) async {
    try {
      final response =
          await http.get(Uri.parse('$API_URL${name.replaceAll(" ", "")}'));
      if (response.statusCode == 200) {
        final pokemon = Pokemon.fromJson(jsonDecode(response.body));
        return pokemon;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              suffixIcon: InkWell(
                child: Icon(Icons.search),
              ),
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search ',
            ),
            onSubmitted: (search) async {
              loading = true;
              var aux = await fetchSearch(search);
              setState(() {
                poke = aux;
              });
            }),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Builder(builder: (context) {
            if (poke != null) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: PokemonCard(pokemon: poke!),
              );
            } else if (loading) {
              return const CircularProgressIndicator();
            } else {
              return const Center(
                child: Text('pesquise um pokemon'),
              );
            }
          }),
        ),
      ],
    );
  }
}
