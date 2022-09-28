import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:listapi/screen.dart';
import '../offline/game.dart';

class Winner extends StatefulWidget {
  const Winner({Key? key}) : super(key: key);

  @override
  State<Winner> createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
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
              "SELAMAT, KAMU BERHASIL",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                color: Color(0xffF3F7FE),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 50),
              child: Text(
                "point kamu sudah mencapai 100 point ",
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
                    return Screen();
                  }));
                },
                child: Text(
                  "Kembali Ke Menu",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff42B4A4),
                    fontWeight: FontWeight.bold,
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
