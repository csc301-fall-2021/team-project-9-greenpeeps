import 'package:flutter/material.dart';

class InfoBox extends StatefulWidget {
  final VoidCallback done;
  const InfoBox({Key? key, required this.done}) : super(key: key);

  @override
  _InfoBoxState createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
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
      widget.done();
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
    _textList.clear();
    _textList.add(Text1());
    _textList.add(Text2());
    _textList.add(Text3());

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Material(
                color: _boxColor,
                elevation: _boxElevation,
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: _boxPadding + 10,
                    vertical: _boxPadding),
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.transparent,
                        ),
                        _textList[_textIndex],
                        Divider(
                          color: Colors.transparent,
                        ),
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
                        )
                        // Spacer()
                      ],
                    )
                ),
              );
            },
        childCount: 1,
        ),
      );
    }
  }




