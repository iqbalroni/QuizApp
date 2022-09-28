import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:listapi/offline/game.dart';
import 'package:listapi/online/categori.dart';
import 'package:listapi/online/play.dart';
import 'package:listapi/screen.dart';

class Gameover extends StatefulWidget {
  final int skor;
  final bool online;
  const Gameover({Key? key, required this.skor, required this.online})
      : super(key: key);

  @override
  State<Gameover> createState() => _GameoverState();
}

class _GameoverState extends State<Gameover> {
  _startEffect() {
    final player = AudioCache();
    player.play("gameover.mp3");
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
        color: Color(0xffF96666),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GAMEOVER..!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                color: Color(0xffF3F7FE),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: Text(
                "point kamu " +
                    widget.skor.toString() +
                    " kurang " +
                    (100 - widget.skor).toString() +
                    " point untuk menang",
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
                  widget.online
                      ? Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                          return Categori(
                            multiplayer: false,
                          );
                        }))
                      : Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                          return Game();
                        }));
                },
                child: Text(
                  "Coba Main Lagi",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xffF96666),
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
                      return Screen();
                    }));
                  },
                  child: Text(
                    "Kembali Ke Menu",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xffF96666),
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
