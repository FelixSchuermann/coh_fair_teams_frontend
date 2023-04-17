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
    final forward_button = ref.watch(showButtonToEnterMainPageProvider);

    final one_v_one = MvpColumn(mvpData.one_v_one, "1v1");
    final two_v_two = MvpColumn(mvpData.two_v_two, "2v2");
    final three_v_three = MvpColumn(mvpData.three_v_three, "3v3");
    final four_v_four = MvpColumn(mvpData.four_v_four, "4v4");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.translate(
          offset: Offset(0, -100), // Move the Text widget up by 5 pixels
          child: Text(
          "MVPs",
          style: TextStyle(letterSpacing: 10,
              fontSize: 140,
              fontWeight: FontWeight.bold,
              color: Colors.black, fontFamily: "Orbitron"),
          textAlign: TextAlign.center,
        ),
        ),
        Transform.translate(
          offset: Offset(0, -80), // Move the Text widget up by 5 pixels
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
          height: 20,
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
    width: 200,
          child: RawMaterialButton(
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
        ) : Text("")
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
