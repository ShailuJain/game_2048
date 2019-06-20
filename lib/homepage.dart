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

  void swap(Tile a, Tile b) {
    a.swap(b);
  }

  void move(Directions d) {
    if (d == Directions.UP) {
      for (int row = 1; row < this._numRows; row++) {
        for(int col = 0; col < this._numColumns; col++){
          Tile currTile = this._tiles[row][col];
          Tile prevTile = this._tiles[row - 1][col];
          if(!currTile.isEmpty()){
            if(prevTile.isEmpty()){
              this._emptyTilePositions.remove(Pair(prevTile.row, prevTile.column));
              this._emptyTilePositions.add(Pair(currTile.row, currTile.column));
              swap(prevTile, currTile);
            }else if(prevTile == currTile){
              this._emptyTilePositions.add(Pair(currTile.row, currTile.column));
              merge(prevTile, currTile);
            }
          }
        }
      }
    } else if (d == Directions.RIGHT) {
    } else if (d == Directions.DOWN) {
    } else if (d == Directions.LEFT) {}
  }

  List<Widget> initWidgets(h,w) {
    final List<Widget> _widgets = List<Widget>();
    for (int i = 0; i < this._numRows; i++) {
      List<Widget> tiles = List<Widget>();
      for (int j = 0; j < this._numColumns; j++) {
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
    count++;
//    if(count == 1){
      generateRandomTile();
      generateRandomTile();
      setState(() {
        print(count);
      });
//    }
    return Align(
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

  Tile(this.row, this.column, {int value = 0}){
    this.value = value;
  }

  bool isEmpty() {
    return this.value == 0;
  }

  void swap(Tile b) {
    int temp;
    //row swapping
    temp = this.row;
    this.row = b.row;
    b.row = temp;

    //column swapping
    temp = this.column;
    this.column = b.column;
    b.column = temp;

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
