import 'package:intl/intl.dart';

class PlayerRating {
  int? germanData;
  int? americanData;
  int? britishData;
  int? dakData;

  PlayerRating({this.germanData, this.americanData, this.britishData, this.dakData});

  factory PlayerRating.fromJson(Map<String, dynamic> json) {
    return PlayerRating(
      germanData: json['german_data'],
      americanData: json['american_data'],
      britishData: json['british_data'],
      dakData: json['dak_data'],
    );
  }
}

class HistoricPlayer {
  String name;
  Map<DateTime, PlayerRating> historicElo;

  HistoricPlayer({required this.name, required this.historicElo});

  factory HistoricPlayer.fromJson(Map<String, dynamic> json) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    return HistoricPlayer(
      name: json['name'],
      historicElo: (json['historic_elo'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(dateFormat.parse(key), PlayerRating.fromJson(value)),
      ),
    );
  }
}

class HistoricElo {
  String modeName;
  List<HistoricPlayer> player;

  HistoricElo({required this.modeName, required this.player});

  factory HistoricElo.fromJson(Map<String, dynamic> json) {
    return HistoricElo(
      modeName: json['mode_name'],
      player: (json['player'] as List<dynamic>).map((e) => HistoricPlayer.fromJson(e)).toList(),
    );
  }
}