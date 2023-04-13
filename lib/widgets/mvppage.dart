import 'package:coh_fair_teams_frontend/model/mvp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider_api.dart';
import 'countdowntextfield.dart';

class MVPPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mvps = ref.watch(mvpProvider);

    return mvps.when(
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (_mvps) => Scaffold(body: Center(child: MVPDetail(_mvps))));
  }
}

VerticalDivider vertdivider = VerticalDivider(
  color: Colors.black,
  thickness: 2,
  width: 20,
);

class MVPDetail extends ConsumerWidget {
  MVPDetail(this.mvpData);

  final MVPData mvpData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final one_v_one = MvpColumn(mvpData.one_v_one, "1v1");
    final two_v_two = MvpColumn(mvpData.two_v_two, "2v2");
    final three_v_three = MvpColumn(mvpData.three_v_three, "3v3");
    final four_v_four = MvpColumn(mvpData.four_v_four, "4v4");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
            child: Text(
              "MVPs",
              style: TextStyle(letterSpacing: 10,
                  fontSize: 140,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, fontFamily: "Orbitron"),
              textAlign: TextAlign.center,
            )),
        const Center(
            child: Text(
              "Bitte knien und Demut zeigen",
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
              textAlign: TextAlign.center,
            )),
        Divider(thickness: 10,
          height: 100,
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
        const SizedBox(height: 30),
        LoadingBarExample()
      ],
    );
  }
}

class MvpColumn extends StatelessWidget {
  MvpColumn(this.modeData, this.modeName);

  final dynamic modeData;
  final String modeName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(modeName,
            style: TextStyle(fontSize: 25, color: Colors.red,decoration: TextDecoration.underline )),
        VerticalDivider(thickness: 10, color: Colors.black,),
        SizedBox(height: 10),
        Text(modeData.player_name, style: TextStyle(fontSize: 40, fontFamily: "Orbitron")),
        SizedBox(height: 20),
        Container(
            child: Image.network(modeData.avatar)).animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(delay: 300.ms, duration: 800.ms).boxShadow(delay: 200.milliseconds).elevation(delay: 500.milliseconds), // runs after the above w/new duration
        SizedBox(height: 10),
        Text("ELO: ${modeData.elo}",
            style: TextStyle(fontSize: 30, color: Colors.green)),
        Text("Faction: ${modeData.faction}",
            style: TextStyle(fontSize: 22, color: Colors.black))
      ],
    );
  }
}
