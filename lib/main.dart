import 'package:coh_fair_teams_frontend/provider_api.dart';
import 'package:coh_fair_teams_frontend/services/fair_teams.dart';
import 'package:coh_fair_teams_frontend/widgets/selectplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'matchupviewer.dart';
import 'model/matchupoption.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faire Teams für kein Lutschjael',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    bool test = ref.watch(testProvider);


    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('COH3 FAIRE TEAMS',style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold) )),
        ),
        body: test == true ? AllOptionMatchUpViewer() : SelectPlayers(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingButton(),);
  }
}

class FloatingButton extends ConsumerWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool validPlayerCount = ref.watch(selectedPlayerProvider).completed;
    bool buttonPress = ref.watch(buttonWasPressed);

    dynamic floater(){

      if (!buttonPress){
        if (validPlayerCount){
          return FloatingActionButton(
            onPressed: () {
              ref.read(testProvider.notifier).state = true;
              ref.read(buttonWasPressed.notifier).state = true;
            },
            backgroundColor: Colors.deepOrange,
            child: const Icon(Icons.accessible_forward_outlined),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          );}
          else {
            return const Text("Bitte eine gültige Anzahl an Spielern anwählen!");
          } }
          else {
            return const Text("");
          }

      }

    return Container(
      width: 200,
      height: 50,
      child: floater(),
    );
  }
}



class AllOptionMatchUpViewer extends ConsumerWidget {
  const AllOptionMatchUpViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _data = ref.watch(matchUpProvider);


    return _data.when(
      data: (_data) {
        return SingleChildScrollView(
          child: Align(alignment: Alignment.topCenter,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ..._data.map((e) => FractionallySizedBox(widthFactor: 0.9,child: MatchUpListView(match: e))),
              ],
            ),
          ),
        );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),

    );
  }
}



class MatchUpListView extends StatelessWidget {
  const MatchUpListView({
    super.key,
    required this.match,
  });

  final MatchUpOption match;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      InkWell(
        child: MatchUp(matchup: match),
        ),

    ]);
  }
}