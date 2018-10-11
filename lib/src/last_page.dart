import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class LastPage extends StatefulWidget {

  LastPage({this.statusType});

  final String statusType;

  @override
  LastPageState createState() {
    // TODO: implement createState
    return LastPageState();
  }
}

class LastPageState extends State<LastPage> {

  List<Feedback> feedbackList = [];
  String msg = '';
  String imgPath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.statusType == 'Unhappy') {
      imgPath = 'images/angry.gif';
      msg = 'We are so sorry. What we did wrong?';
      feedbackList = [
        Feedback('Not helpful and not thoughful', false),
        Feedback('Slow and not responsive', false),
        Feedback('Support line is always busy', false),
        Feedback('Confusing', false),
        Feedback('Other', false),
      ];
    }else if (widget.statusType == 'Neutral') {
      imgPath = 'images/mmm.gif';
      msg = 'Neutral is okay. Why is that?';
      feedbackList = [
        Feedback('I never called support', false),
        Feedback('I think they are okay', false),
        Feedback('I don\'t know', false),
      ];
    }else {
      imgPath = 'images/hearteyes.gif';
      msg = 'High five! What makes you satisfied?';
      feedbackList = [
        Feedback('Helpful and thoughful', false),
        Feedback('Quick and responsive', false),
        Feedback('Solved most of my problems', false),
        Feedback('Good knowledge of the product', false),
      ];
    }
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
              child: getPages(_width)
          ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
            height: 50.0,
            child: Center(
                  child: Text(
                    'Finish',
                    style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
                  )),
          )),
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
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  height: 10.0,
                  width: (_width - 32.0 - 15.0) / 4.0,
                  margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                );
              }),
            ),
          ),
          _getContent(),
        ],
    );
  }

  Widget _getContent() {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(tag: widget.statusType,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 40.0),
                  child: GestureDetector(
                      onTapUp: (details) {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        imgPath,
                        width: 100.0,
                        height: 100.0,
                      )
                  ),
                )),
            Text(msg,
            textAlign: TextAlign.center,),
            Expanded(
              child: Center(
                child: Container(
                  height: 50.0 * feedbackList.length + 8.0 + 1.0 * (feedbackList.length),
                  child: Card(
                    child: Column(
                      children:
                      List.generate(feedbackList.length, (int index) {
                        Feedback question = feedbackList[index];
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  question.isSelected = !question.isSelected;
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
                              height: index < feedbackList.length ? 1.0 : 0.0,
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
    );
//    return ;
  }
}

class Feedback {
  final String displayContent;
  bool isSelected;

  Feedback(this.displayContent, this.isSelected);
}