import 'package:flutter/material.dart';

class HomeTestPage extends StatefulWidget {
  @override
  _HomeTestPageState createState() => _HomeTestPageState();
}

class _HomeTestPageState extends State<HomeTestPage>
    with TickerProviderStateMixin {
  AnimationController animationController1;
  AnimationController animationController2;
  Animation _animation1;
  Animation _animation2;
  Animation _animation3;
  Animation _animation4;

  double centerOffsetX = 0.0;
  double leftOffsetX = 0.0;

  double test = 0;

  @override
  void initState() {
    super.initState();
    animationController1 =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    animationController2 =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    animationController1?.dispose();
    animationController2?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrrenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (leftOffsetX == 0.0) {
      leftOffsetX = -scrrenWidth;
    }

    return Material(
      child: Stack(
        children: <Widget>[
          Positioned(
              left: centerOffsetX,
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    if (details.delta.dx > 0) {
                      setState(() {
                        centerOffsetX += details.delta.dx;
                        leftOffsetX += details.delta.dx;
                      });
                    }
                  },
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (centerOffsetX > 100) {
                      animationController1.reset();
                      animationController2.reset();
                      _animation1 =
                      Tween(begin: centerOffsetX, end: scrrenWidth).animate(animationController1)
                        ..addListener(() {
                          setState(() {
                            centerOffsetX = _animation1.value;
                          });
                        });

                      _animation2 =
                      Tween(begin: leftOffsetX, end: 0.0001).animate(animationController1)
                        ..addListener(() {
                          setState(() {
                            leftOffsetX = _animation2.value;
                          });
                        });
                      animationController1.forward();
//                      setState(() {
//                        centerOffsetX = scrrenWidth;
//                        leftOffsetX = 0.0001;
//                      });
                    }
                  },
                  child: Container(
                    width: scrrenWidth,
                    height: screenHeight,
                    color: Colors.redAccent,
                    child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 200,
                          color: Colors.black,
                          child: Center(child: new Text(test.toString(),style: TextStyle(color: Colors.white),)),
                        ),
                    ),
                  ))),
          Positioned(
              left: leftOffsetX,
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    if (details.delta.dx < 0) {
                      setState(() {
                        centerOffsetX += details.delta.dx;
                        leftOffsetX += details.delta.dx;
                      });
                    }
                  },
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (leftOffsetX < -100) {
                      animationController1.reset();
                      animationController2.reset();
                      _animation3 =
                      Tween(begin: centerOffsetX, end: 0.0001).animate(animationController2)
                        ..addListener(() {
                          setState(() {
                            centerOffsetX = _animation3.value;
                          });
                        });

                      _animation4 =
                      Tween(begin: leftOffsetX, end: -scrrenWidth).animate(animationController2)
                        ..addListener(() {
                          setState(() {
                            leftOffsetX = _animation4.value;
                          });
                        });
                      animationController2.forward();

//                      setState(() {
//                        centerOffsetX = 0.0001;
//                        leftOffsetX = -scrrenWidth;
//                      });
                    }
                  },
                  child: Container(
                    width: scrrenWidth,
                    height: screenHeight,
                    color: Colors.green,
                    child: Center(
                        child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 200,
                      color: Colors.black,
                    )),
                  ))),
        ],
      ),
    );
  }
}
