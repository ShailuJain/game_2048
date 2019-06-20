import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_2048/utils.dart';

import 'colors.dart';

class BoardWidget extends StatefulWidget{
  final int row;
  final int col;

  BoardWidget(this.row, this.col);

  @override
  State<StatefulWidget> createState() => BoardWidgetState(this.row, this.col);

}
class BoardWidgetState extends State<BoardWidget> {
  int count = 0;


  BoardWidgetState(this._numRows, this._numColumns){
    initTileList();
  }

  int _numRows;
  int _numColumns;
  List<Pair<int, int>> _emptyTilePositions;
  List<List<Tile>> _tiles;

  int score = 0;

  void initTileList() {
    this._tiles = List<List<Tile>>();
    this._emptyTilePositions = List<Pair<int, int>>();
    for (int i = 0; i < this._numRows; i++) {
      List<Tile> row = new List<Tile>();
      for (int j = 0; j < this._numColumns; j++) {
        row.add(Tile(i, j));
        this._emptyTilePositions.add(Pair(i, j));
      }
      this._tiles.add(row);
    }
  }

  bool generateRandomTile(){
    Random random = Random();
    int num = 0;
    if(this._emptyTilePositions.length >= 2) {
      num = random.nextInt(this._emptyTilePositions.length - 1);
    }else if(this._emptyTilePositions.length == 1){
      num = 0;
    }else{
      return false;
    }
    Pair p = this._emptyTilePositions.removeAt(num);
    Tile t = this._tiles[p.row][p.col];
    t.value = random.nextInt(10) == 0 ? 4 : 2;
    return true;
  }
  bool merge(Tile a, Tile b) {
    if (a.value == b.value) {
      a.value += b.value;
      b.value = 0;
      return true;
    }
    return false;
  }

  void swapValue(Tile a, Tile b) {
    a.swapValue(b);
  }

  void move(Directions d) {
    int moves = 0;
    if (d == Directions.UP) {
      for (int row = 1; row < this._numRows; row++) {
        for(int col = 0; col < this._numColumns; col++){
          Tile currTile = this._tiles[row][col];
          Tile prevTile = this._tiles[row - 1][col];
          if(!currTile.isEmpty()){
            while(prevTile.isEmpty()){
              this._emptyTilePositions.remove(Pair(prevTile.row, prevTile.column));
              this._emptyTilePositions.add(Pair(currTile.row, currTile.column));
              swapValue(prevTile, currTile);
              if(prevTile.row == 0)
                break;
              currTile = this._tiles[prevTile.row][prevTile.column];
              prevTile = this._tiles[prevTile.row - 1][prevTile.column];
              moves++;
            }
            if(currTile.row != 0) {
              prevTile = this._tiles[currTile.row - 1][currTile.column];
              if (prevTile == currTile) {
                this._emptyTilePositions.add(
                    Pair(currTile.row, currTile.column));
                merge(prevTile, currTile);
                moves++;
              }
            }
          }
        }
      }
    } else if (d == Directions.RIGHT) {
      for (int row = 0; row < this._numRows; row++) {
        for (int col = this._numColumns - 2; col >= 0; col--) {
          Tile currTile = this._tiles[row][col];
          Tile nextTile = this._tiles[row][col + 1];
          if (!currTile.isEmpty()) {
            while (nextTile.isEmpty()) {
              this._emptyTilePositions.remove(Pair(nextTile.row, nextTile.column));
              this._emptyTilePositions.add(Pair(currTile.row, currTile.column));
              swapValue(nextTile, currTile);
              if (nextTile.column == this._numColumns - 1)
                break;
              currTile = this._tiles[nextTile.row][nextTile.column];
              nextTile = this._tiles[nextTile.row][nextTile.column + 1];
              moves++;
            }
            if (currTile.column != this._numColumns - 1) {
              nextTile = this._tiles[currTile.row][currTile.column + 1];
              if (nextTile == currTile) {
                this._emptyTilePositions.add(
                    Pair(currTile.row, currTile.column));
                merge(nextTile, currTile);
                moves++;
              }
            }
          }
        }
      }
    } else if (d == Directions.DOWN) {
      for (int row = this._numRows - 2; row >= 0; row--) {
        for(int col = 0; col < this._numColumns; col++){
          Tile currTile = this._tiles[row][col];
          Tile nextTile = this._tiles[row + 1][col];
          if(!currTile.isEmpty()){
            while(nextTile.isEmpty()){
              this._emptyTilePositions.remove(Pair(nextTile.row, nextTile.column));
              this._emptyTilePositions.add(Pair(currTile.row, currTile.column));
              swapValue(nextTile, currTile);
              if(nextTile.row == this._numRows - 1)
                break;
              currTile = this._tiles[nextTile.row][nextTile.column];
              nextTile = this._tiles[nextTile.row + 1][nextTile.column];
              moves++;
            }
            if(currTile.row != 0) {
              nextTile = this._tiles[currTile.row + 1][currTile.column];
              if (nextTile == currTile) {
                this._emptyTilePositions.add(
                    Pair(currTile.row, currTile.column));
                merge(nextTile, currTile);
                moves++;
              }
            }
          }
        }
      }
    } else if (d == Directions.LEFT) {
      for (int row = 0; row < this._numRows; row++) {
        for(int col = 1; col < this._numColumns; col++){
          Tile currTile = this._tiles[row][col];
          Tile prevTile = this._tiles[row][col - 1];
          if(!currTile.isEmpty()){
            while(prevTile.isEmpty()){
              this._emptyTilePositions.remove(Pair(prevTile.row, prevTile.column));
              this._emptyTilePositions.add(Pair(currTile.row, currTile.column));
              swapValue(prevTile, currTile);
              if(prevTile.column == 0)
                break;
              currTile = this._tiles[prevTile.row][prevTile.column];
              prevTile = this._tiles[prevTile.row][prevTile.column - 1];
              moves++;
            }
            if(currTile.column != 0) {
              prevTile = this._tiles[currTile.row][currTile.column - 1];
              if (prevTile == currTile) {
                this._emptyTilePositions.add(
                    Pair(currTile.row, currTile.column));
                merge(prevTile, currTile);
                moves++;
              }
            }
          }
        }
      }
    }
    setState(() {
      if(moves > 0)
        generateRandomTile();
    });
  }

  List<Widget> initWidgets(h,w) {
    final List<Widget> _widgets = List<Widget>();
//    print("Tiles");
    for (int i = 0; i < this._numRows; i++) {
      List<Widget> tiles = List<Widget>();
      for (int j = 0; j < this._numColumns; j++) {
//        print(_tiles[i][j]);
        tiles.add(
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: h / this._numRows,
                  width: w / this._numColumns,
                  margin: EdgeInsets.all(5),
                  decoration: new BoxDecoration(color: Color(0x33eee4da)),
                ),
                TileWidget(this._numRows, this._numColumns, value: this._tiles[i][j].value),
              ],
            ),
          ),
        );
      }
      _widgets.add(
        Expanded(
          child: Row(
            children: tiles,
          ),
        ),
      );
    }
    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    var initialX;
    var initialY;
    var distanceX;
    var distanceY;
    count++;
    if(count == 1){
      generateRandomTile();
      generateRandomTile();
      setState(() {

      });
    }
    return GestureDetector(
      onPanStart: (DragStartDetails details){
        initialX = details.globalPosition.dx;
        initialY = details.globalPosition.dy;
      },
      onPanUpdate: (DragUpdateDetails details){
        distanceX = details.globalPosition.dx - initialX;
        distanceY = details.globalPosition.dy - initialY;
      },
      onPanEnd: (DragEndDetails details){
        initialX = 0.0;
        initialY = 0.0;
        if(distanceX.abs() > distanceY.abs()){
          if(distanceX > 0){
            move(Directions.RIGHT);
          }else if(distanceX < 0){
            move(Directions.LEFT);
          }
        }else {
          if(distanceY > 0){
            move(Directions.DOWN);
          }else if(distanceY < 0){
            move(Directions.UP);
          }
        }
      },
      child: Align(
        alignment: Alignment.center,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Color(0xffbbada0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: this.initWidgets(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  final int colSize;
  final int rowSize;
  final value;

  TileWidget(this.rowSize, this.colSize, {this.value = 0});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / this.rowSize,
      width: MediaQuery.of(context).size.width / this.colSize,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: this.value == 0? Colors.transparent : color[this.value],
      ),
      child: Center(
        child: Text(
          '${this.value == 0?'' : this.value}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: this.value == 8 || this.value == 16 || this.value == 32 || this.value == 64 ? Colors.white : Colors.black ,
          ),
        ),
      ),
    );
  }
}

class Tile{
  int row;
  int column;
  int _value = 0;

  int get value => _value;

  set value(int value) {
    _value = value;
  }

  Tile(this.row, this.column);

  bool isEmpty() {
    return this.value == 0;
  }

  @override
  String toString() {
    return "Current tile row = ${this.row} column = ${this.column} value = ${this.value}";
  }

  void swapValue(Tile b) {
    int temp;
    //row swapping
//    temp = this.row;
//    this.row = b.row;
//    b.row = temp;
//
//    //column swapping
//    temp = this.column;
//    this.column = b.column;
//    b.column = temp;

    //value swapping
    temp = this.value;
    this.value = b.value;
    b.value = temp;
  }

  @override
  bool operator ==(other) {
    return this.value == other.value;
  }
}

class Pair<E, T> {
  int row;
  int col;

  Pair(this.row, this.col);

  @override
  bool operator ==(other) {
    return row == other.row && col == other.col;
  }
}
