import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class Feedpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var statevalue = appState.selectedpage;

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Feedpage'),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,   // ← Add this.
            children: [
              Text('data'),
            ],
          ),
        ],
      ),
    );
  }
}