//import 'package:coh_fair_teams_frontend/model/mvp.dart';
import 'dart:math';

import 'package:coh_fair_teams_frontend/model/mvp_combined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider_api.dart';
import 'countdowntextfield.dart';
import 'historicelopage.dart';

// class MVPPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mvps = ref.watch(mvpProvider);
//
//     return mvps.when(
//         loading: () => SizedBox(height: 50, // Adjust the height and width as needed
//             width: 50,
//             child: CircularProgressIndicator()),
//         error: (err, stack) => Text('Error: $err'),
//         data: (_mvps) => Scaffold( body:
//               Center(child: MVPDetail(_mvps))
//
//           ));
//   }
// }
class MVPPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combinedMvps = ref.watch(combinedMvpProvider);

    return combinedMvps.when(
      loading: () => SizedBox(
          height: 50, // Adjust the height and width as needed
          width: 50,
          child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
      data: (data) {
        final _mvps = data['mvps'];
        final _secondmvps = data['secondmvps'];

        // Now you can use both _mvps and _secondmvps in your Scaffold
        return Scaffold(
          body: Center(
            child: MVPDetail(_mvps!, _secondmvps!), // Modify as needed to include _secondmvps
          ),
        );
      },
    );
  }
}



VerticalDivider vertdivider = VerticalDivider(
  color: Colors.black,
  thickness: 2,
  width: 2,
);

class MVPDetail extends ConsumerWidget {
  MVPDetail(this.mvpData, this.secondmvpData);

  final MVPData mvpData;
  final MVPData secondmvpData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forward_button = ref.watch(showButtonToEnterMainPageProvider);
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;

    final one_v_one = MvpColumn(mvpData.one_v_one, "1v1", secondmvpData.one_v_one);
    final two_v_two = MvpColumn(mvpData.two_v_two, "2v2", secondmvpData.two_v_two);
    final three_v_three = MvpColumn(mvpData.three_v_three, "3v3", secondmvpData.three_v_three);
    final four_v_four = MvpColumn(mvpData.four_v_four, "4v4", secondmvpData.four_v_four);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.translate(
          offset: Offset(0, -10), // Move the Text widget up by 5 pixels
          child: Text(
          "MVPs",
          style: TextStyle(letterSpacing: 10,
              fontSize: 120,
              fontWeight: FontWeight.bold,
              color: Colors.black, fontFamily: "Orbitron"),
          textAlign: TextAlign.center,
        ),
        ),

        Transform.translate(
          offset: Offset(0, -8), // Move the Text widget up by 5 pixels
          child: Text(
            "Bitte knien und Demut zeigen",
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Divider(thickness: 5,
          height: 15,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          one_v_one,
          vertdivider,
          two_v_two,
          vertdivider,
          three_v_three,
          vertdivider,
          four_v_four,
        ]),
        Divider(thickness: 5,
          height: 20,
        ),
        const SizedBox(height: 20),
        LoadingBarExample(),
        const SizedBox(height: 30),
        forward_button ? Container(alignment: Alignment.center,
    width: 500,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [BottomSheetExample(),
              RawMaterialButton(
                onPressed: () {
                  ref.read(showMainPage.notifier).state = true;
                },
                elevation: 6.0,
                fillColor: Colors.deepOrange,
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Faire Teams Builder"),

                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

            ],
          ),
        ) : Text("")
      ],
    );
  }
}

class MvpColumn extends StatelessWidget {
  //MvpColumn(this.modeData,this.secondMvpModeData, this.modeName);
  MvpColumn(this.modeData, this.modeName, this.secondModeData);

  final dynamic modeData;
  final String modeName;
  final dynamic secondModeData;

  @override
  Widget build(BuildContext context) {
    //PlayerTable modeTable = PlayerTable(playersData: [this.modeData]);
    PlayerTable modeTable = PlayerTable(playersData: [this.modeData]);
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(modeName,
            style: TextStyle(fontSize: 25, color: Colors.red,decoration: TextDecoration.underline )),

        Text(modeData.player_name, style: TextStyle(fontSize: 35, fontFamily: "Orbitron")),
        SizedBox(height: 10),
        PlayerPicView( playersData: [modeData],modeName: modeName,),
        SizedBox(height: 10),
        GlossyTextBar(text: 'ELO: ${modeData.elo}', faction: modeData.faction,),
        SizedBox(height: 10),
        modeTable.animate().scale(),
        SizedBox(height: 2),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text("Contender: ", style: TextStyle(fontSize: 12, color: Colors.grey,)),
        Text("${secondModeData.player_name} at ${secondModeData.elo} ELO with ${secondModeData.faction}", style: TextStyle(fontSize: 12, color: Colors.grey,))],
        )
      ],
    );
  }
}

// class FlipTransition extends AnimatedWidget {
//   final Widget child;
//   final Animation<double> animation;
//
//   FlipTransition({required this.child, required this.animation})
//       : super(listenable: animation);
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//       alignment: FractionalOffset.center,
//       transform: Matrix4.identity()
//         ..setEntry(3, 2, 0.001)
//         ..rotateY(animation.value * 3.1415),
//       child: animation.value > 0.5 ? child : child,
//     );
//   }
// }


class FlipCard extends StatelessWidget {
  final bool toggler;
  final Widget frontCard;
  final Widget backCard;

  const FlipCard({
    required this.toggler,
    required this.backCard,
    required this.frontCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: toggler
            ? SizedBox(key: const ValueKey('front'), child: frontCard)
            : SizedBox(key: const ValueKey('back'), child: backCard),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey(toggler) == widget!.key;
        final rotationY = isFront ? rotateAnimation.value : min(
            rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)
            ..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}


class PlayerPicView extends ConsumerWidget {
  final List<dynamic> playersData;
  final String modeName;

  PlayerPicView({required this.playersData, required this.modeName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final turned = ref.watch(turnedPicNotifierProvider);


    return GestureDetector(
      onTap: () {ref.read(turnedPicNotifierProvider.notifier).selected(modeName);},
      child: FlipCard(
        toggler: turned.turnedPics[modeName]! ,
        frontCard: playerPicBackPage(playerData: playersData[0],),
        backCard: Container(
      child: Image.network(playersData[0].avatar,)).animate()
        .fadeIn() // uses `Animate.defaultDuration`
        .scale() // inherits duration from fadeIn
        .move(delay: 300.ms, duration: 800.ms).boxShadow(delay: 200.milliseconds).elevation(delay: 500.milliseconds),

      ),
    );


    return Column(
      children: [
        Container(
            child: Image.network(playersData[0].avatar)).animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(delay: 300.ms, duration: 800.ms).boxShadow(delay: 200.milliseconds).elevation(delay: 500.milliseconds),
        ElevatedButton(onPressed: () {
          ref.read(turnedPicNotifierProvider.notifier).selected(modeName);
          }, child: Text("test")),
        turned.turnedPics[modeName]! ? Text("ja"): Text("nein")
      ],
    ); // runs after the above w/new duration
  }
}

class playerPicBackPage extends StatelessWidget {

  final dynamic playerData;

  playerPicBackPage({required this.playerData});

  @override
  Widget build(BuildContext context) {


    return Container(width: 192, height: 192, decoration: BoxDecoration(color: Colors.black,
        border: Border(
        right: BorderSide(color: Colors.black),
    bottom: BorderSide(color: Colors.black),
    )), child: Center(child: Table(
    columnWidths: {
    0: IntrinsicColumnWidth(),
    1: IntrinsicColumnWidth(),
    },

    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    border: TableBorder.all(color: Colors.black, width: 0.0),
    children: [

    TableRow(children: [Text("Wins",style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, )),Text('${playerData.wins}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.right,)]),
    TableRow(children: [Text("Losses",style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, )),Text('${playerData.losses}', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.right,)]),
      TableRow(children: [Text('COH3', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold, ),textAlign: TextAlign.left,), Text('${(playerData.playtime/60).roundToDouble().toString()} h', style: TextStyle(fontSize: 18, color: Colors.lightGreen, fontWeight: FontWeight.bold, ),textAlign: TextAlign.right,)]),
    ],
    )));
  }
}




double winLossRatio(int wins, int losses) {
  if (wins == 0 && losses == 0) {
    return 0;
  }

  return (wins / (wins + losses)) * 100;
}

String winLossPercentage(int wins, int losses) {
  return "${winLossRatio(wins, losses).toStringAsFixed(2)}%";
}


class PlayerTable extends StatelessWidget {
  final List<dynamic> playersData;

  PlayerTable({required this.playersData});

  @override
  Widget build(BuildContext context) {
    int games = playersData[0].wins+playersData[0].losses;

    return DataTable(
      headingTextStyle: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
      //border: TableBorder.all(color: Colors.black, width: 1),
      columnSpacing: 18,
      columns: const <DataColumn>[
        //DataColumn(label: Center(child: Text('ELO', textAlign: TextAlign.center), )),
        //DataColumn(label: Center(child: Text('Faction')), ),
        DataColumn(label: Center(child: Text('Rank')),),
        DataColumn(label: Center(child: Text('Streak')), ),
        DataColumn(label: Center(child: Text('Win ratio')),),
        DataColumn(label: Center(child: Text('Matches'), widthFactor: 0.7,),numeric: true ),
        DataColumn(label: Center(child: Text('Last Match')),),
      ],
      rows: playersData.map((playerData) {
        final lastMatchDate = DateTime.fromMillisecondsSinceEpoch(playerData.last_match_date * 1000);
        final dateFormatter = DateFormat.yMMMd();


        return DataRow(cells: [
          //DataCell(Center(child: Container(child: Text('${playerData.elo}', style: TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,), width: 40,))),
          //DataCell(Center(child: Text(playerData.faction, style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold)))),
          DataCell(Center(widthFactor: 0.5,child: Text('${playerData.rank}', style: TextStyle(fontSize: 25, color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center,))),
          //DataCell(Text('${playerData.streak}')),
          DataCell(playerData.streak > 0 ? Center(child: Text('${playerData.streak}', style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold))): Center(child: Text('${playerData.streak}', style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)))),
          DataCell(Center(child: Text('${winLossPercentage(playerData.wins, playerData.losses)}', style: TextStyle(fontSize: 18)))),
          DataCell(Text('$games')),
          DataCell(Center(child: Text(dateFormatter.format(lastMatchDate)))),
        ]);
      }).toList(),
    );
  }
}


class PlayerVerticalTable extends StatelessWidget {
  final dynamic playerData;

  PlayerVerticalTable({required this.playerData});

  @override
  Widget build(BuildContext context) {
    final lastMatchDate = DateTime.fromMillisecondsSinceEpoch(playerData.last_match_date * 1000);
    final dateFormatter = DateFormat.yMMMd().add_jm();

    return Table(
      columnWidths: {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: Colors.black, width: 1.0),
      children: [
        TableRow(children: [Text('ELO: ${playerData.elo}'), Text('Wins: ${playerData.wins}')]),
        TableRow(children: [Text('Faction: ${playerData.faction}'), Text('Losses: ${playerData.losses}')]),
        TableRow(children: [Text('Rank: ${playerData.rank}'), Text('Last Match: ${dateFormatter.format(lastMatchDate)}')]),
        TableRow(children: [Text('Streak: ${playerData.streak}'), Text('')]),
      ],
    );
  }
}

class GlossyTextBar extends StatelessWidget {
  final String text;
  final String faction;



  GlossyTextBar({required this.text, required this.faction});

  @override
  Widget build(BuildContext context) {
    var factionImage = Image.asset('assets/$faction.png');
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;

    return Container(width: devWidth/6,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff262626),
            Color(0xff0d0d0d),
            Color(0xff0d0d0d),
          ],
          stops: [0.0, 0.8, 1.0],
        ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Container(width: 30, height: 30,child: factionImage),
          Text(
            text,textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontFamily: "Orbitron",
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}