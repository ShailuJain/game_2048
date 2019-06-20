import 'package:flutter/material.dart';
import 'package:game_2048/utils.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xfffaf8ef),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ScoreBoardWidget(),
            ),
            Expanded(
              flex: 2,
              child: BoardWidget(4, 4),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xff8f7a66),
                    child: Text(
                      'New Game',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreBoardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScoreBoardWidgetState();
  }
}

class ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  int score = 0;
  final textStyle1 = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  final textStyle2 = TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  '2048',
                  style: TextStyle(
                    color: Color(0xff776e65),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                    color: Color(0xffbbada0),
                  ),
                  child: NotificationListener<ScoreNotification>(
                    onNotification: (ScoreNotification sn){
                      setState(() {
                        this.score = sn.score;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Score',
                          style: this.textStyle1,
                        ),
                        Text(
                          '${this.score}',
                          style: this.textStyle2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
