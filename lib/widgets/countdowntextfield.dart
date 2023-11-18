import "package:flutter/material.dart";

import 'dart:ui';


class LoadingBarExample extends StatefulWidget {
  @override
  _LoadingBarExampleState createState() => _LoadingBarExampleState();
}

class _LoadingBarExampleState extends State<LoadingBarExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 10,
        width: MediaQuery.of(context).size.width * 0.8,
        child: LinearProgressIndicator(
          value: _animation.value,
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }
}