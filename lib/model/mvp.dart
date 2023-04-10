import 'dart:convert';

class MVPData {
  final OneVOne one_v_one;
  final TwoVTwo two_v_two;
  final ThreeVThree three_v_three;
  final FourVFour four_v_four;

  MVPData({required this.one_v_one, required this.two_v_two, required this.three_v_three, required this.four_v_four});

  factory MVPData.fromJson(Map<String, dynamic> json) {
    return MVPData(
      one_v_one: OneVOne.fromJson(json['one_v_one']),
      two_v_two: TwoVTwo.fromJson(json['two_v_two']),
      three_v_three: ThreeVThree.fromJson(json['three_v_three']),
      four_v_four: FourVFour.fromJson(json['four_v_four']),
    );
  }
}

class Player {
  final String player_name;
  final String faction;
  final int elo;
  final String avatar;
  final int playtime;

  Player({required this.player_name, required this.faction, required this.elo, required this.avatar, required this.playtime});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
    );
  }
}

class OneVOne extends Player {
  OneVOne({required player_name, required faction, required elo, required avatar, required playtime})
      : super(player_name: player_name, faction: faction, elo: elo, avatar: avatar, playtime: playtime);

  factory OneVOne.fromJson(Map<String, dynamic> json) {
    return OneVOne(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
    );
  }
}

class TwoVTwo extends Player {
  TwoVTwo({required player_name, required faction, required elo, required avatar, required playtime})
      : super(player_name: player_name, faction: faction, elo: elo, avatar: avatar, playtime: playtime);

  factory TwoVTwo.fromJson(Map<String, dynamic> json) {
    return TwoVTwo(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
    );
  }
}

class ThreeVThree extends Player {
  ThreeVThree({required player_name, required faction, required elo, required avatar, required playtime})
      : super(player_name: player_name, faction: faction, elo: elo, avatar: avatar, playtime: playtime);

  factory ThreeVThree.fromJson(Map<String, dynamic> json) {
    return ThreeVThree(
      player_name: json['player_name'],
      faction: json['faction'],
      elo: json['elo'],
      avatar: json['avatar'],
      playtime: json['playtime'],
    );
  }
}

class FourVFour extends Player {
  FourVFour({required player_name, required faction, required elo, required avatar, required playtime})
      : super(player_name: player_name, faction: faction, elo: elo, avatar: avatar, playtime: playtime);

  factory FourVFour.fromJson(Map<String, dynamic> json) {
    return FourVFour(
        player_name: json['player_name'],
        faction: json['faction'],
        elo: json['elo'],
        avatar: json['avatar'],
        playtime: json['playtime'],
    );
  }
}