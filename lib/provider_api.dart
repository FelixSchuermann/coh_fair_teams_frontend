import 'package:coh_fair_teams_frontend/model/matchupoption.dart';
//import 'package:coh_fair_teams_frontend/model/mvp.dart';
import 'package:coh_fair_teams_frontend/model/mvp_combined.dart';
import 'package:coh_fair_teams_frontend/services/fair_teams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/historic_elo.dart';

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

final secondmvpProvider = FutureProvider<MVPData>((ref) async {
  return ref.read(apiProvider).secondmvpPerMode();
});

final combinedMvpProvider = FutureProvider.autoDispose((ref) async {
  final mvps = await ref.watch(mvpProvider.future);
  final secondmvps = await ref.watch(secondmvpProvider.future);
  return {'mvps': mvps, 'secondmvps': secondmvps};
});


final historicEloProvider = FutureProvider<HistoricElo>((ref) async {
  return ref.read(apiProvider).historicElo("one_v_one");
});


final showMainPage = StateProvider<bool>((ref) {
  return false;
});

final showMainPageProvider = FutureProvider<bool>(
    (ref) async {
      final mvpData = ref.listen(mvpProvider, (previous, next) {
        next.whenData((value) {

          Future.delayed(const Duration(seconds: 3), () {
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

Map<String,bool> turnedPics = {"1v1": false, "2v2": false, "3v3": false, "4v4": false};

@immutable
class TurnedPics {
  const TurnedPics({required this.turnedPics});

  // All properties should be `final` on our class.
  final Map<String, bool> turnedPics;


  // Since Todo is immutable, we implement a method that allows cloning the
  // Todo with slightly different content.
  TurnedPics copyWith() {
    return TurnedPics(
      turnedPics: this.turnedPics);
  }
}


class TurnedPicNotifier extends StateNotifier<TurnedPics> {

  TurnedPicNotifier(TurnedPics turnedPics) : super(turnedPics);

  void selected(String modeName) {
    Map<String,bool> myTurnedPics = {"1v1": false, "2v2": false, "3v3": false, "4v4": false};

    if (state.turnedPics[modeName]==true){
      myTurnedPics[modeName]=false;
    }
    else
    {
      myTurnedPics[modeName]=true;
    }

    TurnedPics deepCopiedPics = TurnedPics(turnedPics: myTurnedPics);
    state = deepCopiedPics;
  }

}


final turnedPicNotifierProvider = StateNotifierProvider<TurnedPicNotifier, TurnedPics>(
      (ref) {

        Map<String,bool> myTurnedPics = {"1v1": false, "2v2": false, "3v3": false, "4v4": false};
        TurnedPics my = TurnedPics(turnedPics: myTurnedPics);

        return TurnedPicNotifier(my);
  },
);

