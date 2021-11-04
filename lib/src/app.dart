import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:survey_app/src/last_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _animateController;
  AnimationController _longPressController;
  AnimationController _secondStepController;
  AnimationController _thirdStepController;
  AnimationController _fourStepController;

  double overall = 3.0;
  String overallStatus = "Good";
  int curIndex = 0;
  String usingTimes = 'Daily';

  bool isFairly = false;
  bool isClear = false;
  bool isEasy = false;
  bool isFriendly = false;

  List<SecondQuestion> usingCollection = [
    SecondQuestion('daily', 'Daily'),
    SecondQuestion('onceAWeek', 'Once a week'),
    SecondQuestion('onceAMonth', 'Once a month'),
    SecondQuestion('everyMoths', 'Every 2-3 months'),
    SecondQuestion('lessThanYears', 'Less than 5 a years'),
  ];

  Animation<double> longPressAnimation;
  Animation<double> secondTranformAnimation;
  Animation<double> thirdTranformAnimation;
  Animation<double> fourTranformAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _longPressController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fourStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    longPressAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
            parent: _longPressController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    fourTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fourStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    secondTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _longPressController.addListener(() {
      setState(() {});
    });

    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });

    _fourStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
    _fourStepController.dispose();
    _longPressController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startLongPressAnimation() async {
    try {
      await _longPressController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSecondStepAnimation() async {
    try {
      await _secondStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFourStepAnimation() async {
    try {
      await _fourStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    curIndex += 1;
                    if (curIndex == 1) {
                      _startSecondStepAnimation();
                    } else if (curIndex == 2) {
                      _startThirdStepAnimation();
                    } else if (curIndex == 3) {
                      _startFourStepAnimation();
                    }
                  });
                },
                child: Center(
                    child: Text(
                  curIndex < 3 ? 'Continue' : 'Finish',
                  style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
                )),
              ),
            ))
          : null,
    );
  }

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
//                color: Colors.blue,
          margin: EdgeInsets.only(top: 30.0),
          height: 10.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (int index) {
              return Container(
                decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                  color: index <= curIndex ? Colors.orangeAccent : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 10.0,
                width: (_width - 32.0 - 15.0) / 4.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
              );
            }),
          ),
        ),
        curIndex == 0
            ? _getFirstStep()
            : curIndex == 1
                ? _getSecondStep()
                : curIndex == 2
                    ? _getThirdStep()
                    : _getFourStep(),
      ],
    );
  }

  Widget _getFirstStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Question 1'),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text('Overall, how would you rate our service?')),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                overallStatus,
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Slider(
                  activeColor: Colors.orangeAccent,
                  inactiveColor: Colors.orangeAccent,
                  value: overall,
                  onChanged: (value) {
                    setState(() {
                      overall = value.round().toDouble();
                      _getOverallStatus(overall);
                    });
                  },
                  label: '${overall.toInt()}',
                  divisions: 30,
                  min: 1.0,
                  max: 5.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getSecondStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - secondTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: secondTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 2'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('How often do you typically use our service?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 258.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  usingTimes = using.identifier;
                                });
                              },
                              child: Container(
                                height: 50.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                usingTimes = value;
                                              });
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                    Divider(
                                      height: index < usingCollection.length
                                          ? 1.0
                                          : 0.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ThirdQuestion> thirdQuestionList = [
    ThirdQuestion('Fairly cheaper price', false),
    ThirdQuestion('Clear tracking system', false),
    ThirdQuestion('Easy to use', false),
    ThirdQuestion('Friendly customer service', false),
  ];
  Widget _getThirdStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 3'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('What do you like about our service?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 213.0,
                      child: Card(
                        child: Column(
                          children: List.generate(thirdQuestionList.length,
                              (int index) {
                            ThirdQuestion question = thirdQuestionList[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      question.isSelected =
                                          !question.isSelected;
//                                  isFairly = !isFairly;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: question.isSelected
                                        ? Colors.orangeAccent.withAlpha(100)
                                        : Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: Colors.orangeAccent,
                                            value: question.isSelected,
                                            onChanged: (bool value) {
//                                          print(value);
                                              setState(() {
                                                question.isSelected = value;
                                              });
                                            }),
                                        Text(question.displayContent)
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: index < thirdQuestionList.length
                                      ? 1.0
                                      : 0.0,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFourStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - fourTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: fourTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 4'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text(
                        'When you need help or has concerns related with our product, how satisfied are you with our customer support\'s performance?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 213.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
//                              onTapU
//                        onLongPress: () {
//                          _startLongPressAnimation();
//                          },
//                                onTapUp: (detail) {
//                          print(detail);
//                         _longPressController.reset();
//                      },
                                      onTapUp: (detail) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LastPage(
                                                          statusType: 'Unhappy',
                                                        )));
                                      },
                                      child: Transform.scale(
                                          scale: longPressAnimation.value,
                                          child: Hero(
                                            tag: 'Unhappy',
                                            child: Image.asset(
                                              'images/angry.gif',
                                              width: 50.0,
                                              height: 50.0,
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Unhappy'),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
//                              onTapU
//                        onLongPress: () {
//                          _startLongPressAnimation();
//                          },
//                                onTapUp: (detail) {
//                          print(detail);
//                         _longPressController.reset();
//                      },
                                      onTapUp: (detail) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LastPage(
                                                          statusType: 'Neutral',
                                                        )));
                                      },
                                      child: Hero(
                                        tag: 'Neutral',
                                        child: Transform.scale(
                                            scale: longPressAnimation.value,
                                            child: Image.asset(
                                              'images/mmm.gif',
                                              width: 50.0,
                                              height: 50.0,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Neutral'),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
//                              onTapU
//                        onLongPress: () {
//                          _startLongPressAnimation();
//                          },
//                                onTapUp: (detail) {
//                          print(detail);
//                         _longPressController.reset();
//                      },
                                      onTapUp: (detail) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LastPage(
                                                          statusType:
                                                              'Satisfied',
                                                        )));
                                      },
                                      child: Transform.scale(
                                          scale: longPressAnimation.value,
                                          child: Hero(
                                            tag: 'Satisfied',
                                            child: Image.asset(
                                              'images/hearteyes.gif',
                                              width: 50.0,
                                              height: 50.0,
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Satisfied'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getOverallStatus(double overall) {
    switch (overall.toInt()) {
      case 1:
        overallStatus = 'Bad';
        break;
      case 2:
        overallStatus = 'Normal';
        break;
      case 3:
        overallStatus = 'Good';
        break;
      case 4:
        overallStatus = 'Very Good';
        break;
      default:
        overallStatus = 'Excellent';
        break;
    }
  }
}

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key key, this.controller, this.screenWidth, this.onStartAnimation})
      : width = Tween<double>(
          begin: screenWidth,
          end: 40.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        alignment = Tween<AlignmentDirectional>(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topStart,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(2.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 40.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0.0),
          end: EdgeInsets.only(top: 30.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        numberOfStep = IntTween(
          begin: 1,
          end: 4,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final VoidCallback onStartAnimation;
  final Animation<double> controller;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<AlignmentDirectional> alignment;
  final Animation<BorderRadius> radius;
  final Animation<EdgeInsets> movement;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<int> numberOfStep;
  final double screenWidth;
  final double overral = 3.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          alignment: alignment.value,
          children: <Widget>[
            Opacity(
              opacity: 1.0 - opacity.value,
              child: Column(
                children: <Widget>[
                  Container(
//                color: Colors.blue,
                    margin: EdgeInsets.only(top: 30.0),
                    height: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfStep.value, (int index) {
                        return Container(
                          decoration: BoxDecoration(
                            //  color: Colors.orangeAccent,
                            color:
                                index == 0 ? Colors.orangeAccent : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 10.0,
                          width: (screenWidth - 15.0) / 5.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
//                color: Colors.blue,
                      margin: EdgeInsets.only(top: 34.0),
//                height: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Question 1'),
                          Container(
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text(
                                  'Overall, how would you rate our service?')),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 50.0),
                            child: Text(
                              'Good',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity:
                  controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: StylizedFlutterLogo(
                        colorFilter: ColorFilter.matrix(<double>[
                          1,
                          0,
                          0,
                          0,
                          255,
                          0.9,
                          -1,
                          0.4,
                          0,
                          171,
                          0,
                          0,
                          -1,
                          0,
                          64,
                          0,
                          0,
                          0,
                          1,
                          0,
                        ]),
                        size: 100,
                      ),
                    ),
                  ),
                  Text(
                    'Your opinion in 3 minutes.',
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
                    child: Text(
                      'By answering this 3 minutes survey, you help us improve our service event better for you',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: GestureDetector(
                onTap: onStartAnimation,
                child: Transform.scale(
                  scale: scale.value,
                  child: Container(
                    margin: movement.value,
                    width: width.value,
                    child: GestureDetector(
                      child: Container(
                        height: height.value,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: radius.value),
                        child: Center(
                          child: controller.status == AnimationStatus.dismissed
                              ? Text(
                                  'Take the survey',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
//            Opacity(
//              opacity: 1.0 - opacity.value,
//              child:
//            ),
          ],
        );
      },
    );
  }
}

class SecondQuestion {
  final String identifier;
  final String displayContent;

  SecondQuestion(this.identifier, this.displayContent);
}

class ThirdQuestion {
  final String displayContent;
  bool isSelected;

  ThirdQuestion(this.displayContent, this.isSelected);
}

class StylizedFlutterLogo extends StatelessWidget {
  final ColorFilter colorFilter;
  final double size;

  const StylizedFlutterLogo({this.colorFilter, this.size});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: colorFilter,
      child: FlutterLogo(size: size),
    );
  }
}
