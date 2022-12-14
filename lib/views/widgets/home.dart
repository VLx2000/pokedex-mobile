import 'dart:async';

import 'package:pokedex/components/pokemon_card.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/utils/url_api.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Pokemon>>? futurePokemonList;
  late List<Pokemon> pokemonList;
  late int _pageNumber;
  final int _numberOfCards = 20;
  final int _nextPageTrigger = 3;

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    pokemonList = [];
    futurePokemonList = fetchPokemonList();
  }

  Future<List<Pokemon>> fetchPokemonList() async {
    try {
      final response = await http
          .get(Uri.parse('$API_URL?offset=$_pageNumber&limit=$_numberOfCards'));
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body);
        List<Pokemon> newPokemonList = [];
        for (var pokemon in (list["results"] as List)) {
          final details = await http.get(Uri.parse(pokemon['url']));
          newPokemonList.add(Pokemon.fromJson(
              details.statusCode == 200 ? jsonDecode(details.body) : []));
        }

        setState(() {
          _pageNumber = _pageNumber + _numberOfCards;
          pokemonList.addAll(newPokemonList);
        });
        return pokemonList;
      } else {
        throw Exception('erro');
      }
    } catch (e) {
      throw Exception('erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
      future: futurePokemonList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Pokemon> list = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: list.length + 1,
            itemBuilder: (context, i) {
              if (i == list.length - _nextPageTrigger) {
                futurePokemonList = fetchPokemonList();
              }
              if (i == list.length) {
                /* return Image.asset('assets/pokebola.gif'); */
                return Container(
                    height: 60.0,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Image.asset('assets/pokebola.gif'));
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: PokemonCard(pokemon: snapshot.data![i]),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
