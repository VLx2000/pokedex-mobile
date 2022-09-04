import 'dart:async';

import 'package:api/models/pokemon.dart';
import 'package:api/repositories/api.dart';
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
          title: const Text('Pokedex'),
        ),
        body: Center(
          child: FutureBuilder<List<Pokemon>>(
            future: futurePokemon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Pokemon> list = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: list.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, i) {
                    return FadeInImage.assetNetwork(
                      placeholder: 'assets/pokebola.gif',
                      image: snapshot.data![i].sprite,
                      fit: BoxFit.cover,
                    );
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
