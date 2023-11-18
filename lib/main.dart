import 'package:coh_fair_teams_frontend/model/mvp.dart';
import 'package:coh_fair_teams_frontend/provider_api.dart';
import 'package:coh_fair_teams_frontend/services/fair_teams.dart';
import 'package:coh_fair_teams_frontend/splashscreen.dart';
import 'package:coh_fair_teams_frontend/widgets/eloplotly.dart';
import 'package:coh_fair_teams_frontend/widgets/historicelopage.dart';
import 'package:coh_fair_teams_frontend/widgets/mvppage.dart';
import 'package:coh_fair_teams_frontend/widgets/selectplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'matchupviewer.dart';
import 'model/matchupoption.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';


void main() {
  //ui.platformViewRegistry.registerViewFactory('<iframeElement>', createIframeElement);
  WebViewPlatform.instance = WebWebViewPlatform();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool showMain = ref.watch(showMainPage);
    final main = ref.watch(showMainPageProvider);

    return MaterialApp(
      title: 'Faire Teams für kein Lutschjael',
      // theme: ThemeData(
      //   primarySwatch: Colors.blueGrey,
      //
      // ),
        theme: new ThemeData(scaffoldBackgroundColor: Color(0xFFFFFFFF), primarySwatch: Colors.blueGrey),
      home: showMain ? Homepage() : MVPPage()
      //home: showMain ? Homepage() : HistoricEloPage()
    );
  }
}




// class Homepage extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<Homepage> createState() => _HomepageState();
// }
//
// class _HomepageState extends ConsumerState<Homepage> {
//   @override
//   void initState() {
//     super.initState();
//     // 3. if needed, we can read the provider inside initState
//     final helloWorld = ref.read(helloWorldProvider);
//     print(helloWorld); // "Hello world"
//   }

  // @override
  // Widget build(BuildContext context) {
  //   bool test = ref.watch(testProvider);
  //   bool showMain = ref.watch(showMainPage);
  //   if (showMain){
  //     return
  //   }
  //
  //   final _data2 = ref.watch(mvpProvider);
  //   final splashfinished = ref.watch(splashScreenProvider);
  //   return _data2.when(data: (_)=> Text("mvpdata"), error: (err, s) => Text(err.toString()), loading: () => const Center(
  //       child: CircularProgressIndicator()));
  //
  //   return splashfinished.when(
  //     loading: () => Container(child: Text("Bitte Knien und Demut zeigen vor euren MVP's"),),
  //     error: (err, stack) => Text('Error: $err'),
  //     data: (weather) => Scaffold(
  //       appBar: AppBar(
  //         title: Center(child: Text('COH3 FAIRE TEAMS',style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold) )),
  //       ),
  //       body: test == true ? AllOptionMatchUpViewer() : SelectPlayers(),
  //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //       floatingActionButton: const FloatingButton(),
  //   ));
  //
  //   // if (splashfinished){
  //   //   return Scaffold(
  //   //     appBar: AppBar(
  //   //       title: Center(child: Text('COH3 FAIRE TEAMS',style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold) )),
  //   //     ),
  //   //     body: test == true ? AllOptionMatchUpViewer() : SelectPlayers(),
  //   //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //   //     floatingActionButton: const FloatingButton(),);
  //   // } else {
  //   //   return ElevatedButton(child: Text("HIII"), onPressed: (){ref.read(splashScreenProvider.notifier).state = true;},);
  //   // }
  //   }
  //
  // }


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


