import 'package:tic_tac_toe_game/ui/pages/home_page.dart';

class GameModal {
  List gridGame = List.generate(9, (index) => '');

  GameModal();

  addGridGame(int index, var elem) {
    this.gridGame[index] = elem;
  }

  restarGridGame() {
    this.gridGame = List.generate(9, (index) => '');
  }

  get getGridGame => this.gridGame;

  getIndexGridGame(int index) => this.gridGame[index];

  checkWinner(int countGo) {
    IsTypePlayer? winner;
    String? text;

    if (gridGame[0] == gridGame[1] &&
        gridGame[0] == gridGame[2] &&
        gridGame[0] != '') {
      winner = gridGame[0];
    } else if (gridGame[3] == gridGame[4] &&
        gridGame[3] == gridGame[5] &&
        gridGame[3] != '') {
      winner = gridGame[3];
    } else if (gridGame[6] == gridGame[7] &&
        gridGame[6] == gridGame[8] &&
        gridGame[6] != '') {
      winner = gridGame[6];
    } else if (gridGame[6] == gridGame[7] &&
        gridGame[6] == gridGame[8] &&
        gridGame[6] != '') {
      winner = gridGame[6];
    } else

    // Checking Column
    if (gridGame[0] == gridGame[3] &&
        gridGame[0] == gridGame[6] &&
        gridGame[0] != '') {
      winner = gridGame[0];
    } else if (gridGame[1] == gridGame[4] &&
        gridGame[1] == gridGame[7] &&
        gridGame[1] != '') {
      winner = gridGame[1];
    } else if (gridGame[2] == gridGame[5] &&
        gridGame[2] == gridGame[8] &&
        gridGame[2] != '') {
      winner = gridGame[2];
    } else

    // Checking Diagonal
    if (gridGame[0] == gridGame[4] &&
        gridGame[0] == gridGame[8] &&
        gridGame[0] != '') {
      winner = gridGame[0];
    } else if (gridGame[2] == gridGame[4] &&
        gridGame[2] == gridGame[6] &&
        gridGame[2] != '') {
      winner = gridGame[2];
    } else if (countGo >= 9) {
      text = 'Ничья';
    }

    if (winner != null || text != null) {
      return winner ?? text!;
    }
  }
}
