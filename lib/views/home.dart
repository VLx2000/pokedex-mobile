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
  late Future<List<Pokemon>> futurePokemonList;
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
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xff212529),
          title: Image.network(
            'https://fontmeme.com/permalink/220904/3a93b3a770f738e70b9f89412489ef6d.png',
            height: 44,
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Pokemon>>(
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
                    return PokemonCard(pokemon: snapshot.data![i]);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
