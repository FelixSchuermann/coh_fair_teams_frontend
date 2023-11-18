import 'dart:convert';

class MVPData {
  final Player one_v_one;
  final Player two_v_two;
  final Player three_v_three;
  final Player four_v_four;

  MVPData({required this.one_v_one, required this.two_v_two, required this.three_v_three, required this.four_v_four});

  factory MVPData.fromJson(Map<String, dynamic> json) {
    return MVPData(
      one_v_one: Player.oneVOneFromJson(json['one_v_one']),
      two_v_two: Player.twoVTwoFromJson(json['two_v_two']),
      three_v_three: Player.threeVThreeFromJson(json['three_v_three']),
      four_v_four: Player.fourVFourFromJson(json['four_v_four']),
    );
  }
}


class Player {
  final String player_name;
  final String faction;
  final int elo;
  final String avatar;
  final int playtime;
  final int wins;
  final int losses;
  final int streak;
  final int rank;
  final int last_match_date;

  Player({
    required this.player_name,
    required this.faction,
    required this.elo,
    required this.avatar,
    required this.playtime,
    required this.wins,
    required this.losses,
    required this.streak,
    required this.rank,
    required this.last_match_date,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
      wins: json['wins'],
      losses: json['losses'],
      streak: json['streak'],
      rank: json['rank'],
      last_match_date: json['last_match_date'],
    );
  }

  factory Player.oneVOneFromJson(Map<String, dynamic> json) {
    return Player.fromJson(json);
  }

  factory Player.twoVTwoFromJson(Map<String, dynamic> json) {
    return Player.fromJson(json);
  }

  factory Player.threeVThreeFromJson(Map<String, dynamic> json) {
    return Player.fromJson(json);
  }

  factory Player.fourVFourFromJson(Map<String, dynamic> json) {
    return Player.fromJson(json);
  }
}

class OneVOne extends Player {
  OneVOne({
    required player_name,
    required faction,
    required elo,
    required avatar,
    required playtime,
    required wins,
    required losses,
    required streak,
    required rank,
    required last_match_date,
  }) : super(
    player_name: player_name,
    faction: faction,
    elo: elo,
    avatar: avatar,
    playtime: playtime,
    wins: wins,
    losses: losses,
    streak: streak,
    rank: rank,
    last_match_date: last_match_date,
  );

  factory OneVOne.fromJson(Map<String, dynamic> json) {
    return OneVOne(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
      wins: json['wins'],
      losses: json['losses'],
      streak: json['streak'],
      rank: json['rank'],
      last_match_date: json['last_match_date'],
    );
  }
}

class TwoVTwo extends Player {
  TwoVTwo({
    required player_name,
    required faction,
    required elo,
    required avatar,
    required playtime,
    required wins,
    required losses,
    required streak,
    required rank,
    required last_match_date,
  }) : super(
    player_name: player_name,
    faction: faction,
    elo: elo,
    avatar: avatar,
    playtime: playtime,
    wins: wins,
    losses: losses,
    streak: streak,
    rank: rank,
    last_match_date: last_match_date,
  );

  factory TwoVTwo.fromJson(Map<String, dynamic> json) {
    return TwoVTwo(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
      wins: json['wins'],
      losses: json['losses'],
      streak: json['streak'],
      rank: json['rank'],
      last_match_date: json['last_match_date'],
    );
  }
}

class ThreeVThree extends Player {
  ThreeVThree({
    required player_name,
    required faction,
    required elo,
    required avatar,
    required playtime,
    required wins,
    required losses,
    required streak,
    required rank,
    required last_match_date,
  }) : super(
    player_name: player_name,
    faction: faction,
    elo: elo,
    avatar: avatar,
    playtime: playtime,
    wins: wins,
    losses: losses,
    streak: streak,
    rank: rank,
    last_match_date: last_match_date,
  );

  factory ThreeVThree.fromJson(Map<String, dynamic> json) {
    return ThreeVThree(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
      wins: json['wins'],
      losses: json['losses'],
      streak: json['streak'],
      rank: json['rank'],
      last_match_date: json['last_match_date'],
    );
  }
}

class FourVFour extends Player {
  FourVFour({
    required player_name,
    required faction,
    required elo,
    required avatar,
    required playtime,
    required wins,
    required losses,
    required streak,
    required rank,
    required last_match_date,
  }) : super(
    player_name: player_name,
    faction: faction,
    elo: elo,
    avatar: avatar,
    playtime: playtime,
    wins: wins,
    losses: losses,
    streak: streak,
    rank: rank,
    last_match_date: last_match_date,
  );

  factory FourVFour.fromJson(Map<String, dynamic> json) {
    return FourVFour(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
      wins: json['wins'],
      losses: json['losses'],
      streak: json['streak'],
      rank: json['rank'],
      last_match_date: json['last_match_date'],
    );
  }
}