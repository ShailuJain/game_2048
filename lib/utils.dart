import 'package:flutter/material.dart';

enum Directions{
  UP, RIGHT, DOWN, LEFT
}

class ScoreNotifier extends ChangeNotifier{
 int _score = 0;

 int get score => _score;

 set score(int value) {
   _score = value;
   notifyListeners();
 }
}