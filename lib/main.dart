import 'package:pokedex/views/home.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/views/pokemon.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const HomeView());
        }
        if (settings.name == '/pokemon') {
          var args = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => PokemonView(idPokemon: args as String));
        }
        return MaterialPageRoute(builder: (context) => const UnknownScreen());
      },
    ),
  );
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('404!'),
      ),
    );
  }
}
