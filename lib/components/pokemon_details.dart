import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/poke_colors.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PokemonDetails extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetails({super.key, required this.pokemon});

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
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: desaturatedColor,
      ),
      child: Ink(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // nome e id
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        StringUtils.capitalize(pokemon.name),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: contrastColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: normalColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(borderValue)),
                    ),
                    child: Text(
                      '#${(pokemon.id).toString()}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: contrastColor,
                      ),
                    ),
                  ),
                ],
              ),
              // foto e types

              FadeInImage.assetNetwork(
                placeholder: 'assets/pokebola.gif',
                image: pokemon.sprite,
                height: 280.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var aux in pokemon.tipos)
                    Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.all(24),
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
                          fontSize: 20,
                        ),
                      ),
                    ),
                ],
              ),
              // stats
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        padding: const EdgeInsets.all(4),
                        lineHeight: 30.0,
                        animationDuration: 1000,
                        percent:
                            (pokemon.height < 50) ? pokemon.height / 50 : 1,
                        center: Text(' HEIGHT: ${pokemon.height / 10}m'),
                        barRadius: const Radius.circular(12),
                        progressColor: normalColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        padding: const EdgeInsets.all(4),
                        lineHeight: 30.0,
                        animationDuration: 1000,
                        percent:
                            (pokemon.weight < 2000) ? pokemon.weight / 2000 : 1,
                        center: Text('WEIGHT: ${pokemon.weight / 10}kg'),
                        barRadius: const Radius.circular(12),
                        progressColor: normalColor,
                      ),
                    ],
                  ),
                  for (var aux in pokemon.stats)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 50,
                          animation: true,
                          padding: const EdgeInsets.all(4),
                          lineHeight: 30.0,
                          animationDuration: 1000,
                          percent: (aux['base_stat'] < 200)
                              ? aux['base_stat'] / 200
                              : 1,
                          center: Text(
                              '${aux['stat']['name'].toUpperCase()}: ${aux['base_stat']}'),
                          barRadius: const Radius.circular(12),
                          progressColor: normalColor,
                        ),
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 80),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
