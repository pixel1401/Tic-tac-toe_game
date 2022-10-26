import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/ui/pages/game_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Tic Tac Toe',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
            ),
            Column(
              children: [
                buildBtn(context, text: 'Play with a bot', onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GamePage(),
                    ),
                  );
                }),
                SizedBox(
                  height: 30,
                ),
                buildBtn(context, text: '2 players', onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        isBotPaly: false,
                      ),
                    ),
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton buildBtn(BuildContext context,
      {required String text, required Function onPress}) {
    return ElevatedButton(
        onPressed: () {
          return onPress();
        },
        child: Text(text));
  }
}
