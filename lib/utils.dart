import 'package:flutter/material.dart';

enum Directions{
  UP, RIGHT, DOWN, LEFT
}

class ScoreNotification extends Notification{
  int score;
  ScoreNotification(this.score);
}