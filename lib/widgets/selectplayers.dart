import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coh_fair_teams_frontend/provider_api.dart';

class SelectPlayers extends ConsumerWidget {
  const SelectPlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, bool> selectedPlayers =
        ref.watch(selectedPlayerProvider).playerMap;

    final List<String> _players = [
      "Schmu",
      "St. Jordi Corporation",
      "Hammerdon",
      "Silvio Guastatori",
      "LeCharly",
      "Ghetto GSG9",
      "Graf_Marcula",
      "Reifen Ralle",
      "Masuka",
      "Saviako",
      "Fakex"
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Wer will zocken?',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _players.map((player) {

                  return ChoiceChip(
                    label: Text(
                      player,
                      style: TextStyle(fontSize: 18),
                    ),
                    selected: selectedPlayers[player]!,
                    selectedColor: Colors.grey,
                    backgroundColor: Theme.of(context).indicatorColor,
                    onSelected: (bool value) {
                      // setState(() {
                      //   _selectedPlayers[player] = value;
                      // });
                      Map<String, bool> current =
                          ref.read(selectedPlayerProvider).playerMap;
                      current[player] = value;
                      ref
                          .read(selectedPlayerProvider.notifier)
                          .selected(current);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
