import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/botModal/bot.dart';
import 'package:tic_tac_toe_game/botModal/game_modal.dart';
import 'package:tic_tac_toe_game/ui/pages/game_page.dart';
import 'package:tic_tac_toe_game/ui/pages/item.dart';

enum IsTypePlayer { x, o }

typedef TurnFunc = void Function({required int index});

GameModal gameModal = GameModal();


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //!  false = X ; true = O
  bool isTurn = false;

  int countGo = 0;

  bool isEnd = false;

  checkWinner() {
    var checkWin = gameModal.checkWinner(countGo);

    if (checkWin != null) {
      if (checkWin.runtimeType == String) {
        isEnd = true;
        _showWinDialog(text: 'DROW');
      } else {
        isEnd = true;
        _showWinDialog(text: 'Winn');
      }
    }
  }

  changeReplace({required int index}) async {
    gameModal.addGridGame(index, isTurn ? IsTypePlayer.o : IsTypePlayer.x);
    print(gameModal.getGridGame);
    countGo++;
    checkWinner();

    // isTurn = !isTurn;

    if (countGo >= 9 || isEnd == true) {
      setState(() {});
      return;
    }

    Bot StupidBot = Bot(gridGame: gameModal.getGridGame);
    int indexGoBot = StupidBot.firstBot();
    // await Future.delayed(Duration(seconds: 6));
    gameModal.addGridGame(indexGoBot, IsTypePlayer.o);
    countGo++;
    setState(() {});
    checkWinner();
  }

  @override
  Widget build(BuildContext context) {
    List<Item> items = List.generate(
        9,
        (index) => Item(
              isTurn: isTurn,
              index: index,
              changeReplace: changeReplace,
              showElem: gameModal.getIndexGridGame(index) != ''
                  ? gameModal.getIndexGridGame(index)
                  : null,
            ));

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Wrap(
              children: [...items.map((e) => e)],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GamePage(),
                  ),
                );
              },
              child: Text('GEME MLTY'))
        ],
      ),
    );
  }

  void _showWinDialog({IsTypePlayer? winner, String? text}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + '${text ?? winner}' + " \" is Winner!!!"),
            actions: [
              TextButton(
                child: Text("Play Again"),
                onPressed: () {
                  gameModal.restarGridGame();
                  countGo = 0;
                  isEnd = false;
                  setState(() {});
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
