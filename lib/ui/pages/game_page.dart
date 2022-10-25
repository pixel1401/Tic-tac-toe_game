import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/botModal/bot.dart';
import 'package:tic_tac_toe_game/botModal/game_modal.dart';
import 'package:tic_tac_toe_game/ui/pages/home_page.dart';
import 'package:tic_tac_toe_game/ui/pages/item.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

GameModal multy = GameModal();

class _GamePageState extends State<GamePage> {
  //!  false = X ; true = O
  bool isTurn = false;

  int countGo = 0;

  bool isEnd = false;

  checkWinner() {
    var checkWin = multy.checkWinner(countGo);

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

  restart() {
    multy.restarGridGame();
    countGo = 0;
    isEnd = false;
    setState(() {});
  }

  handleItemMultiplayer({required int index}) async {
    multy.addGridGame(index, isTurn ? IsTypePlayer.o : IsTypePlayer.x);
    countGo++;
    checkWinner();
    isTurn = !isTurn;
    if (countGo >= 9 || isEnd == true) {
      setState(() {});
      return;
    }
    setState(() {});
  }


  handleBotPlayer({required int index}) {
    multy.addGridGame(index, isTurn ? IsTypePlayer.o : IsTypePlayer.x);
    countGo++;
    checkWinner();
    if (countGo >= 9 || isEnd == true) {
      setState(() {});
      return;
    }
    Bot StupidBot = Bot(gridGame: multy.getGridGame);
    int indexGoBot = StupidBot.firstBot();
    // await Future.delayed(Duration(seconds: 6));
    multy.addGridGame(indexGoBot, IsTypePlayer.o);
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
              changeReplace: handleBotPlayer,
              showElem: multy.getIndexGridGame(index) != ''
                  ? multy.getIndexGridGame(index)
                  : null,
            ));

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Wrap(
              children: [...items.map((e) => e)],
            ),
          )
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
                  restart();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  draw() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Ничья'),
                TextButton(
                    onPressed: () {
                      restart();
                      Navigator.pop(context);
                    },
                    child: Text('Draw'))
              ],
            ),
          );
        });
  }
}
