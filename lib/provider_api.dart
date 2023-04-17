import 'package:coh_fair_teams_frontend/model/matchupoption.dart';
import 'package:coh_fair_teams_frontend/model/mvp.dart';
import 'package:coh_fair_teams_frontend/services/fair_teams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider<String>((_) => 'Hello world');

final countdownProvider = StateProvider<int>((ref) => 5);

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

final matchUpProvider = FutureProvider<List<MatchUpOption>>((ref) async {
  bool completed = ref.read(selectedPlayerProvider).completed;
  if (completed){
    Map<String, bool> players = ref.read(selectedPlayerProvider).playerMap;
    return ref.read(apiProvider).getPlayerData(players);
  }

  return ref.read(apiProvider).getMatchUpTest();
});


final mvpProvider = FutureProvider<MVPData>((ref) async {
  return ref.read(apiProvider).mvpPerMode();
});

final showMainPage = StateProvider<bool>((ref) {
  return false;
});

final showMainPageProvider = FutureProvider<bool>(
    (ref) async {
      final mvpData = ref.listen(mvpProvider, (previous, next) {
        next.whenData((value) {

          Future.delayed(const Duration(seconds: 6), () {
            //ref.read(showMainPage.notifier).state = true;
            ref.read(showButtonToEnterMainPageProvider.notifier).state = true;
            return true;
          });

        });
      });
    return false;});

final showButtonToEnterMainPageProvider = StateProvider<bool>((ref) {
  return false;
});

final testProvider = StateProvider<bool>((ref) => false);


final buttonWasPressed = StateProvider<bool>((ref) => false);


class SelectedPlayerNotifier extends StateNotifier<PlayerSelection> {
  SelectedPlayerNotifier(PlayerSelection initialPlayers) : super(initialPlayers);

  void selected(Map<String, bool> newPlayers) {
    bool valid = true;
    int trueCount = newPlayers.values.where((value) => value).length;

    if (trueCount == 4 || trueCount == 6 || trueCount == 8) {
      valid = true;
    } else {
      valid = false;
    }

    PlayerSelection deepCopiedMap = PlayerSelection(playerMap: newPlayers, completed: valid);
    state = deepCopiedMap;
  }

  void setCompletedToFalse() {
    bool valid = false;

    PlayerSelection deepCopiedMap = PlayerSelection(playerMap: state.playerMap, completed: valid);
    state = deepCopiedMap;
  }

}

@immutable
class PlayerSelection {
  const PlayerSelection({required this.playerMap, required this.completed});

  // All properties should be `final` on our class.
  final Map<String, bool> playerMap;
  final bool completed;

  // Since Todo is immutable, we implement a method that allows cloning the
  // Todo with slightly different content.
  PlayerSelection copyWith({Map<String, bool>? id, bool? completed}) {
    return PlayerSelection(
      playerMap: id ?? this.playerMap,
      completed: completed ?? this.completed,
    );
  }
}


final selectedPlayerProvider = StateNotifierProvider<SelectedPlayerNotifier, PlayerSelection>(
      (ref) {
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
      "Fakex",
    ];

    Map<String, bool> initialPlayers = {};
    for (var player in _players) {
      initialPlayers[player] = false;
    }
    PlayerSelection players=  PlayerSelection(playerMap: initialPlayers, completed: false);

    return SelectedPlayerNotifier(players);
  },
);

