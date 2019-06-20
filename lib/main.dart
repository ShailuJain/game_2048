import 'package:flutter/material.dart';
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
              child: Row(),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Score',
                        style: this.textStyle1,
                      ),
                      Text(
                        '0',
                        style: this.textStyle2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xffbbada0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Best',
                      style: this.textStyle1,
                    ),
                    Text(
                      '0',
                      style: this.textStyle2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
