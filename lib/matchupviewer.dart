import 'package:coh_fair_teams_frontend/model/matchupoption.dart';
import 'package:coh_fair_teams_frontend/widgets/playerinteamdisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchUp extends StatelessWidget {
const MatchUp({
super.key,
required this.matchup,
});

final MatchUpOption matchup;

@override
Widget build(BuildContext context) {
  const Color containerColor = Color(0xFF2DBD3A);
  //return Container(color: containerColor, child: Text(matchup.elo_diff.toString()));
  return Container( width: 200 , height: 200,
    decoration: BoxDecoration(
      color: Colors.white10,
      border: Border.all(
        color: Colors.black,
        width: 1.0, // Set the border width here.
        style: BorderStyle.solid, // Set the border style here. The default is BorderStyle.solid.
      ),
    ),
    child: Center(
      child: ListTile(
        title: Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Container(child: Text(matchup.team_allis_elo_avg.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),)),
            Expanded(child: PlayersInTeamDisplay(playersInTeam: matchup.team_allis, backgroundText: "Team Allis", teamElo: matchup.team_allis_elo_avg, teamWinProbability: matchup.team_allis_win_prob,)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("elo diff", style: TextStyle(fontSize: 20),),
                Text(matchup.elo_diff.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),

              ],
            ),
            //Container(child: Text(matchup.team_ger_elo_avg.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),)),
            Expanded(child: PlayersInTeamDisplay(playersInTeam: matchup.team_ger, backgroundText: "Team Deutsche", teamElo: matchup.team_ger_elo_avg, teamWinProbability: matchup.team_ger_win_prob,)),
          ],)),
        //subtitle: Text(matchup.team_allis_win_prob.toString()),
        focusColor: containerColor,
        //trailing: CircleAvatar(
        //  backgroundImage: NetworkImage(e.avatar),
      ),
    ),
  );
}
}