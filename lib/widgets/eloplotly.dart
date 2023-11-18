import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;



class EloPlotly extends StatefulWidget {
  const EloPlotly({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EloPlotly> createState() => _EloPlotlyState();
}

class _EloPlotlyState extends State<EloPlotly> {
  Widget _createIframe() {
    final IFrameElement iframe = IFrameElement()
      ..width = '100%'
      ..height = '500'
      ..src = 'https://volle-power-mc.de:9000/'
      ..style.border = 'none';

    return HtmlElementView(viewType: '<iframeElement>');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Embedded Dash App:'),
            SizedBox(
              width: double.infinity,
              height: 500,
              child: _createIframe(),
            ),
          ],
        ),
      ),
    );
  }
}