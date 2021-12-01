import 'package:flutter/material.dart';

class InfoDialog extends StatefulWidget {
  const InfoDialog({Key? key}) : super(key: key);

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
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
    return Text("GreenPeeps is on a mission to help people to develop more climate friendly habits. "
        "We do this by learning about you, teaching you important lessons about how your habits generate emissions, "
        "and then helping you to find new more climate friendly habits. ",
      style: style,
    );
  }

  Widget Text2(){
    return Text("With your help, we hope to make a collective impact to avoid the worst outcomes of climate change. "
        "Every government must contribute to this change, "
        "and while we push for that, we can all do our own part to make change "
        "toward long-term sustainability for our people on this planet.  ",
      style: style,
    );
  }

  Widget Text3(){
    return Text("Oh... and on behalf of the GreenPeeps team, "
        "we want to thank you for your interest in making a difference for climate change and for checking us out. "
        "We always love your feedback and please send your thoughts and suggestions to Feedback@GreenPeeps.com",
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
  Widget build(BuildContext context) {
    // use init fn
    _textList.clear();
    _textList.add(Text1());
    _textList.add(Text2());
    _textList.add(Text3());

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




