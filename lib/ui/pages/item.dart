import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/ui/pages/home_page.dart';

class Item extends StatefulWidget {
  bool isTurn;
  TurnFunc changeReplace;
  int index;
  IsTypePlayer? showElem;

  Item(
      {super.key,
      required this.isTurn,
      required this.index,
      required this.showElem,
      required this.changeReplace});
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  // false = X ; true = O
  bool? isState;

  @override
  Widget build(BuildContext context) {
    if (widget.showElem != null) {
      switch (widget.showElem!) {
        case IsTypePlayer.x:
          isState = false;
          break;
        case IsTypePlayer.o:
          isState = true;
          break;
      }
    } else {
      isState = null;
    }

    var widthArea = MediaQuery.of(context).size.width - 30;
    return TextButton(
        onPressed: () {
          if (isState != null) return;
          if (widget.isTurn) {
            isState = true;
          } else if (widget.isTurn == false) {
            isState = false;
          }

          widget.changeReplace(index: widget.index);

          setState(() {});
        },
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Container(
            width: widthArea / 3,
            height: widthArea / 3,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black)),
            child: isState == null
                ? null
                : isState == true
                    ? zero(widthArea)
                    : cross(widthArea)));
  }

  Icon cross(widthArea) {
    return Icon(
      Icons.close,
      size: widthArea / 3,
    );
  }

  Icon zero(widthArea) {
    return Icon(
      Icons.circle_outlined,
      size: widthArea / 3,
    );
  }
}
