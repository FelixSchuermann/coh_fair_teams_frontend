import 'package:flutter/material.dart';

import '../model/matchupoption.dart';

import 'package:flutter/material.dart';

class PlayersInTeamDisplay extends StatelessWidget {
  final List<PlayerInTeam> playersInTeam;
  final String backgroundText;
  final double teamElo;
  final double teamWinProbability;

  PlayersInTeamDisplay({Key? key, required this.playersInTeam, required this.backgroundText, required this.teamElo, required this.teamWinProbability}) : super(key: key);

  Widget _buildPlayerInTeam(BuildContext context, PlayerInTeam playerInTeam) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width / playersInTeam.length,
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(

          children: [
            Text(
              '${playerInTeam.name}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Faction: ${playerInTeam.player.faction}', style: TextStyle(fontSize: 8)),
                Text('Elo: ${playerInTeam.player.elo}', style: TextStyle(fontSize: 8)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background text with opacity
        Opacity(
          opacity: 0.01,
          child: Center(
            child: Text(
              backgroundText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // The existing content
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container
              (padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              decoration: BoxDecoration(
                border: Border.all(
                color: Colors.blueGrey,
                width: 3,
                )),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: playersInTeam.map((playerInTeam) => _buildPlayerInTeam(context, playerInTeam)).toList(),
              ),
            ),
            Row(
              children: [Text("Team Elo: ${teamElo.toStringAsFixed(1)} with win probability ${teamWinProbability.toStringAsFixed(3)}")],
            mainAxisAlignment: MainAxisAlignment.center,),
          ],
        ),
      ],
    );
  }
}