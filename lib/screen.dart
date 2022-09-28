import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:listapi/online/categori.dart';

import 'offline/game.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  _startEffect() {
    final player = AudioCache();
    player.play("winner.mp3");
  }

  _klik() {
    final player = AudioCache();
    player.play("click.mp3");
  }

  @override
  void initState() {
    super.initState();
    _startEffect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff42B4A4),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PLAY QUIZ.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                color: Color(0xffF3F7FE),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 25, right: 25, bottom: 30),
              child: Text(
                "Kuis dari bahasa Inggris: quiz, adalah padanan kata atau sinonim untuk permainan teka-teki, yang biasanya berhadiah. Pada umumnya, kuis dikenal melalui acara televisi yang disiarkan secara rutin setiap pekan atau setiap hari.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xffF3F7FE),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: 50,
              child: RaisedButton(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  _klik();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Game();
                  }));
                },
                child: Text(
                  "Main Offline",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff42B4A4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    _klik();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Categori(
                        multiplayer: false,
                      );
                    }));
                  },
                  child: Text(
                    "Main Online",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff42B4A4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                child: RaisedButton(
                  elevation: 0,
                  color: Color(0xffFFC23C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    _klik();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Categori(
                        multiplayer: true,
                      );
                    }));
                  },
                  child: Text(
                    "Main Online",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xfffefefe),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
