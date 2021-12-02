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
    return Text("This is your home screen - "
        "the place where you can access all your GreenPeeps tools! "
        "You can always return here by clicking the home icon on the bottom bar.",
      style: style,
    );
  }

  Widget Text2(){
    return Text("The bottom bar also contains three other icons that link to the other features of this app."
    "\nIn the Habits section, you can get recommendations for small changes "
        "you can make in your everyday life that can make small reductions in your carbon footprint.",
      style: style,
    );
  }

  Widget Text3(){
    return Text("In the Learn section, we present you with easily digestible and "
        "curated information about climate science, emissions, the science of habit change, "
        "and other helpful knowledge to assist you on your way to becoming more carbon conscious.  ",
      style: style,
    );
  }

  Widget Text4(){
    return Text("In the Profile section, you will see your personal details and "
        "information that we collect about your lifestyle as it pertains to emissions. "
        "You'll also see your Leaf count. ",
      style: style,
    );
  }

  Widget Text5(){
    return Text("Leaves are the basic unit of impact that we measure for you as you use our app. "
        "The more climate friendly habits you adopt into your life, the more leaves you get. "
        "We'll talk more about leaves later in your orientation to the app.",
      style: style,
    );
  }

  Widget Text6(){
    return Text("Note: Soon you'll also be able to access your own personal carbon footprint estimate here - a feature that's coming in the next phase of our development.",
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
    _textList.add(Text5());
    _textList.add(Text6());
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




