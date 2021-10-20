import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {

    final ButtonStyle style =
    OutlinedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white)
       );

// ButtonStyle(
//     backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//   )

    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: new BoxDecoration(
                color: Color(0xff073617),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Center(
                      child: Text('Welcome Traveller',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                      ),
                      )
                  ),
                ),
                OutlinedButton(
                  style: style,
                  onPressed: (){
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('I have been here before \n[login]\n'),
                ),
                OutlinedButton(
                  style: style,
                  onPressed: (){
                    Navigator.pushNamed(context, '/new');
                  },
                  child: const Text('Where am I? \n[new user]\n'),
                ),
                OutlinedButton(
                  style: style,
                  onPressed: (){
                    Navigator.pushNamed(context, '/nav');
                  },
                  child: const Text('I want to explore \n[nav]\n'),
                ),],
            ),
          )),
    );
  }
}
