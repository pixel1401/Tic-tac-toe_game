import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/modals/bot.dart';
import 'package:tic_tac_toe_game/modals/game_modal.dart';
import 'package:tic_tac_toe_game/ui/pages/item.dart';

enum IsTypePlayer { x, o }

typedef TurnFunc = void Function({required int index});

GameModal gameModel = GameModal();

class GamePage extends StatefulWidget {
  // false => 2 player ; true => bot
  bool isBotPaly;

  GamePage({super.key, this.isBotPaly = true});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //!  false = X ; true = O
  bool isTurn = false;

  int countGo = 0;

  bool isEnd = false;

  int playerX = 0;
  int playerO = 0;

  checkWinner() {
    var checkWin = gameModel.checkWinner(countGo);

    if (checkWin != null) {
      if (checkWin.runtimeType == String) {
        isEnd = true;
        _showWinDialog(text: 'DRAW');
      } else {
        isEnd = true;
        String nameWinner = '';
        setState(() {
          switch (checkWin) {
            case IsTypePlayer.o:
              playerO++;
              nameWinner = 'O';
              break;
            case IsTypePlayer.x:
              playerX++;
              nameWinner = 'X';
              break;
            default:
          }
        });
        _showWinDialog(text: nameWinner);
      }
    }
  }

  initValue() {
    playerO = 0;
    playerX = 0;
    countGo = 0;
    isTurn = false;
    isEnd = false;
    restart();
  }

  restart() {
    gameModel.restarGridGame();
    countGo = 0;
    isEnd = false;
    setState(() {});
  }

  handleItemMultiplayer({required int index}) async {
    gameModel.addGridGame(index, isTurn ? IsTypePlayer.o : IsTypePlayer.x);
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
    gameModel.addGridGame(index, isTurn ? IsTypePlayer.o : IsTypePlayer.x);
    countGo++;
    checkWinner();
    if (countGo >= 9 || isEnd == true) {
      setState(() {});
      return;
    }
    Bot StupidBot = Bot(gridGame: gameModel.getGridGame);
    int indexGoBot = StupidBot.firstBot();
    // await Future.delayed(Duration(seconds: 6));
    gameModel.addGridGame(indexGoBot, IsTypePlayer.o);
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
              changeReplace:
                  widget.isBotPaly ? handleBotPlayer : handleItemMultiplayer,
              showElem: gameModel.getIndexGridGame(index) != ''
                  ? gameModel.getIndexGridGame(index)
                  : null,
            ));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              initValue();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Row(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildAvaPlayer(text: 'Player O', count: playerO),
            buildAvaPlayer(text: 'Player X', count: playerX),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                initValue();
              },
              icon: Icon(Icons.restart_alt))
        ],
      ),
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

  Container buildAvaPlayer({required String text, required int count}) {
    return Container(
      child: Column(
        children: [
          Text(text),
          SizedBox(
            height: 2,
          ),
          Text(count.toString())
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
