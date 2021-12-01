import 'package:flutter/material.dart';

class HabitInfoDialog extends StatefulWidget {
  const HabitInfoDialog({Key? key}) : super(key: key);

  @override
  _HabitInfoDialogState createState() => _HabitInfoDialogState();
}

class _HabitInfoDialogState extends State<HabitInfoDialog> {
  final TextStyle style = TextStyle(
    fontSize: 20,
  );
  // Box Variables
  final double _boxPadding = 15.0;
  final double _boxElevation = 5.0; // The height of shadow beneath box
  final Color _boxColor = const Color.fromRGBO(248, 244, 219, 1);

  List<Widget> _textList = [];
  int _textIndex = 0;

  Widget Text1(){
    return Text("In this section you'll see all of the habits recommended for you. "
        "Some might be habits that you already have, and when that happens, "
        "you can put those habits into your profile by clicking "
        "\"This is an existing habit\"",
      style: style,
    );
  }

  Widget Text2(){
    return Text("When you see a habit that you want to adopt in your life, "
        "you can click the + button to add it to your Habits in Progress list. "
        "We know it takes time to make new habits stick. ",
      style: style,
    );
  }

  Widget Text3(){
    return Text("That's why we'll check in with you over the course of 14 days to see if you're having sucess with these habits. "
        "Typically, doing something for 14 days is enough to entrench it into your routine, "
        "but we also let you Complete the habit when you feel you're done. ",
      style: style,
    );
  }

  Widget Text4(){
    return Text("To make sure that you don't get overloaded, "
        "we have a maximum of three habits that you can work on at any given time. "
        "Don't worry though, your recommendations will be waiting for you and "
        "you can always add a new one once you complete a habit on your list.",
      style: style,
    );
  }




  _nextText() {
    if(_textIndex < _textList.length - 1) {
      setState((){
        _textIndex += 1;
      });

    } else {
      Navigator.pop(context);
    }

  }

  _backText() {
    if(_textIndex > 0) {
      setState((){
        _textIndex -= 1;
      });
    }
  }

  @override
  void initState() {
    _textList.clear();
    _textList.add(Text1());
    _textList.add(Text2());
    _textList.add(Text3());
    _textList.add(Text4());

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: _boxColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
          height: 400,
          padding: EdgeInsets.symmetric(horizontal: _boxPadding + 10,
              vertical: _boxPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                elevation: 0,
                toolbarHeight: 30,
                backgroundColor: _boxColor,
                automaticallyImplyLeading: false, // No back arrow
                actions: <Widget>[
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context).pop(); // Closes popup
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.black,
                    splashRadius: 15,
                  )
                ],
              ),
              Spacer(),
              _textList[_textIndex],
              Spacer(),
              Row(
                children: [
                  Visibility(
                    visible: _textIndex > 0,
                    child: ElevatedButton(
                      onPressed: () {
                        _backText();
                      },
                      child: const Text("< Back"),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(0, 154, 6, 1),
                      ),
                    ),
                  ),

                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _nextText();
                    },
                    child: (_textIndex < _textList.length  - 1 )
                        ? const Text("Next >")
                        : const Text("Done!"),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(0, 154, 6, 1),
                    ),
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}




