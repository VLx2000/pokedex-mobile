import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/poke_colors.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    Color normalColor =
        Color(int.parse(PokeColors.colours[pokemon.tipos[0]['type']['name']]!));
    Color desaturatedColor = Color(
        int.parse(PokeColors.coloursDes[pokemon.tipos[0]['type']['name']]!));
    Color contrastColor = Color(
        int.parse(PokeColors.coloursCon[pokemon.tipos[0]['type']['name']]!));

    double borderValue = 24.0;

    return Container(
      height: 140.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: desaturatedColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(borderValue),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 8,
                  ),
                  child: Text(
                    StringUtils.capitalize(pokemon.name),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: contrastColor,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: normalColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderValue),
                    bottomLeft: Radius.circular(borderValue),
                  ),
                ),
                child: Text(
                  '#${(pokemon.id).toString()}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: contrastColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/pokebola.gif',
                image: pokemon.sprite,
                height: 100.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var aux in pokemon.tipos)
                    Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(PokeColors.colours[aux['type']['name']]!),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        aux['type']['name'].toUpperCase(),
                        style: TextStyle(
                          color: Color(
                            int.parse(
                                PokeColors.coloursCon[aux['type']['name']]!),
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
