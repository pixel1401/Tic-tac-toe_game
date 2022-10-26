
import 'package:tic_tac_toe_game/ui/pages/game_page.dart';

class Bot {
  // индекс
  int? goIndex;
  // Сетка игры
  List gridGame = [];

  // получаем позицию оппонента 
  List postionOpponent = List.generate(8, (index) => 0);

  // индексы стороны где должна быт наша фигурка
  List indexSide = [];

  // Определяем сторону где больше фигурок противника (row1 = 0 , row2 = 1 ,column3 = 3 ...)
  late int indexProbablySide;

  Bot({required this.gridGame});

  checkPosition(int index) {
    switch (index) {
      case 0:
        postionOpponent[0]++;
        postionOpponent[3]++;
        postionOpponent[7]++;
        break;
      case 1:
        postionOpponent[0]++;
        postionOpponent[4]++;
        break;
      case 2:
        postionOpponent[0]++;
        postionOpponent[5]++;
        postionOpponent[6]++;
        break;
      case 3:
        postionOpponent[1]++;
        postionOpponent[3]++;
        break;
      case 4:
        postionOpponent[1]++;
        postionOpponent[4]++;
        postionOpponent[6]++;
        postionOpponent[7]++;
        break;
      case 5:
        postionOpponent[1]++;
        postionOpponent[5]++;
        break;
      case 6:
        postionOpponent[2]++;
        postionOpponent[3]++;
        postionOpponent[6]++;
        break;
      case 7:
        postionOpponent[2]++;
        postionOpponent[4]++;
        break;
      case 8:
        postionOpponent[2]++;
        postionOpponent[5]++;
        postionOpponent[7]++;
        break;
      default:
    }
  }

  // 1
  setPositionOpponent() {
    for (var i = 0; i < gridGame.length; i++) {
      var item = gridGame[i];
      if (item == '') continue;

      if (item == IsTypePlayer.x) {
        checkPosition(i);
        continue;
      }
    }
  }

  // 2
  setProbablySyde() {
    for (var i = 0; i < postionOpponent.length; i++) {
      int item = postionOpponent[i];
      if (item == 2) {
        searchSideItemIndex(i);
        print(indexSide);
      }
    }
  }

  // получаем индексы стороны = indexSide
  searchSideItemIndex(int side) {
    switch (side) {
      case 0:
        return indexSide.addAll([0, 1, 2]);
      case 1:
        return indexSide.addAll([3, 4, 5]);
      case 2:
        return indexSide.addAll([6, 7, 8]);
      case 3:
        return indexSide.addAll([0, 3, 6]);
      case 4:
        return indexSide.addAll([1, 4, 7]);
      case 5:
        return indexSide.addAll([2, 5, 8]);
      case 6:
        return indexSide.addAll([6, 4, 2]);
      case 7:
        return indexSide.addAll([0, 4, 8]);
      default:
    }
  }

  // 3 находим индекс пустой ячеики стороны (возможно null , когда ячейка занята наши фигуркой)
  setIndexGoSide() {
    for (var i = 0; i < indexSide.length; i++) {
      int index = indexSide[i];
      if (gridGame[index] == '') {
        goIndex = index;
      }
    }
  }

  getIndexForGoBot() {
    if (goIndex != null) {
      return goIndex;
    } else {
      for (var i = 0; i < gridGame.length; i++) {
        if (gridGame[i] == '') {
          return i;
        }
      }
    }
  }

  firstBot() {
    setPositionOpponent();
    setProbablySyde();
    setIndexGoSide();
    return getIndexForGoBot();
  }
}
