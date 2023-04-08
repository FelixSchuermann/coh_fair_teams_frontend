import 'dart:convert';

class MatchUpOption {
  final List<PlayerInTeam> team_allis;
  final double team_allis_elo_avg;
  final double team_allis_win_prob;
  final List<PlayerInTeam> team_ger;
  final double team_ger_elo_avg;
  final double team_ger_win_prob;
  final double elo_diff;

  MatchUpOption({
    required this.team_allis,
    required this.team_allis_elo_avg,
    required this.team_allis_win_prob,
    required this.team_ger,
    required this.team_ger_elo_avg,
    required this.team_ger_win_prob,
    required this.elo_diff,
  });

  factory MatchUpOption.fromJson(Map<String, dynamic> json) {
    return MatchUpOption(
      team_allis: (json['team_allis'] as List).map((e) => PlayerInTeam.fromJson(e as Map<String, dynamic>)).toList(),
      team_allis_elo_avg: json['team_allis_elo_avg'].toDouble(),
      team_allis_win_prob: json['team_allis_win_prob'].toDouble(),
      team_ger: (json['team_ger'] as List).map((e) => PlayerInTeam.fromJson(e as Map<String, dynamic>)).toList(),
      team_ger_elo_avg: json['team_ger_elo_avg'].toDouble(),
      team_ger_win_prob: json['team_ger_win_prob'].toDouble(),
      elo_diff: json['elo_diff'].toDouble(),
    );
  }
}

class PlayerInTeam {
  final String name;
  final Player player;

  PlayerInTeam({required this.name, required this.player});

  factory PlayerInTeam.fromJson(Map<String, dynamic> json) {
    String key = json.keys.first;
    return PlayerInTeam(
      name: key,
      player: Player.fromJson(json[key] as Map<String, dynamic>),
    );
  }
}

class Player {
  final String faction;
  final int elo;

  Player({required this.faction, required this.elo});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      faction: json['faction'] as String,
      elo: json['elo'] as int,
    );
  }
}
