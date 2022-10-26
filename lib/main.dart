import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/ui/pages/game_page.dart';
import 'package:tic_tac_toe_game/ui/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe Game',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/game': (context) => GamePage(),
      },
    );
  }
}
