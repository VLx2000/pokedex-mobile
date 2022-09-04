import 'package:api/views/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeView(),
      /* '/pokemon': (context) => PokemonView(
            idPokemon: ModalRoute.of(context).settings.arguments,
          ), */
    },
  ));
}