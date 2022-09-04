import 'dart:async';

import 'package:pokedex/components/pokemon_card.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/api/fetch_pokemon.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Pokemon>> futurePokemon;

  @override
  void initState() {
    super.initState();
    futurePokemon = fetchPokemon();
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
            future: futurePokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Pokemon> list = snapshot.data ?? [];
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
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
