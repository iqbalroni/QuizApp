import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listapi/component/gameover.dart';
import 'package:listapi/component/winner.dart';
import 'package:audioplayers/audioplayers.dart';

class Play extends StatefulWidget {
  final String kunci;
  final String judul;
  const Play({Key? key, required this.kunci, required this.judul})
      : super(key: key);

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  String result = "";
  String qoute = "";
  String answer = "";
  int Skor = 0;
  int NumberSoal = 0;
  int nyawa = 3;
  int soal = 0;
  bool loadqoute = true;
  bool hasil = false;
  bool load = false;
  bool level = true;
  TextEditingController jawaban = TextEditingController();
  Random random = new Random();
  static AudioCache player = AudioCache();

  List<dynamic> mylist = [];

  _startEffect() {
    final player = AudioCache();
    player.play("start.mp3");
  }

  _generateQoute() async {
    Uri url = Uri.parse("https://iqbalroni.github.io/soal_kuis/kategori/" +
        widget.kunci +
        ".json");
    var response = await http.get(url);
    int acak = random.nextInt(json.decode(response.body).length);
    var object = json.decode(response.body)[acak]['question'];

    var kunci = json.decode(response.body)[acak]['key'];

    return setState(() {
      mylist = [
        kunci,
        json.decode(response.body)[acak]['A'],
        json.decode(response.body)[acak]['B'],
        json.decode(response.body)[acak]['C'],
      ];
      mylist.shuffle();
      soal = soal + 1;
      answer = json.decode(response.body)[acak]['key'].toString();
      qoute = object.toString();
      loadqoute = false;
      NumberSoal = acak;
    });
  }

  _plusPoint() async {
    final player = AudioCache();
    player.play("benar.mp3");
    setState(() {
      Skor = Skor + 5;
    });
  }

  _minPoint() async {
    setState(() {
      nyawa = nyawa - 1;
    });
    if (nyawa <= 0) {
      _gameOver();
    } else {
      final player = AudioCache();
      player.play("salah.mp3");
    }
  }

  _klik() {
    final player = AudioCache();
    player.play("click.mp3");
  }

  _gameOver() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'GAME OVER',
      desc: 'Total ' + Skor.toString() + ' Point Kamu',
      dismissOnTouchOutside: false,
      btnOkOnPress: () {
        _klik();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Gameover(
            skor: Skor,
            online: true,
          );
        }));
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    _startEffect();
    _generateQoute();
  }

  _jawaban(jwb) async {
    String soalnya = answer.toLowerCase().replaceAll(' ', '');
    String jawab = jwb.toString().toLowerCase().replaceAll(' ', '');

    if (jawab.toString() == soalnya.toString()) {
      setState(() {
        _plusPoint();
        loadqoute = true;
        jawaban.clear();
        _generateQoute();
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Jawaban benar!',
        desc: 'Point anda ditambah 5 point',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          _klik();
          if (Skor >= 100) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Winner();
            }));
          } else {}
        },
      ).show();
    } else {
      setState(() {
        _minPoint();
        loadqoute = true;
        jawaban.clear();
        _generateQoute();
      });
      if (nyawa <= 0) {
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Jawaban salah!',
          desc: 'Jawaban Kamu Salah..',
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
            _klik();
          },
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff42B4A4),
        title: Center(
          child: Text("Quiz " + widget.judul),
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xffF3F7FE),
      body: ListView(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: Skor,
                child: Container(
                  height: 10,
                  color: Color(0xff49D292),
                ),
              ),
              Expanded(
                flex: 100 - Skor,
                child: Container(
                  height: 10,
                  color: Color(0xffCFCFCF),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color:
                            nyawa >= 3 ? Color(0xffF7374D) : Color(0xff838CA2),
                        size: 35,
                      ),
                      Icon(
                        Icons.favorite,
                        color:
                            nyawa >= 2 ? Color(0xffF7374D) : Color(0xff838CA2),
                        size: 35,
                      ),
                      Icon(
                        Icons.favorite,
                        color:
                            nyawa >= 1 ? Color(0xffF7374D) : Color(0xff838CA2),
                        size: 35,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    "SKOR " + Skor.toString() + " POINT",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff42B4A4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFFC23C),
                  ),
                  height: 200,
                  padding: EdgeInsets.all(20),
                  child: loadqoute == true
                      ? Center(
                          child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Color(0xff383838),
                              )),
                        )
                      : Center(
                          child: Text(
                            qoute + "....",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff383838),
                            ),
                          ),
                        ),
                ),
                Positioned(
                  left: 45,
                  top: 0,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xff42B4A4),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        soal.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffF3F7FE),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: mylist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _jawaban(mylist[index].toString());
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                        color: Color(0xff42B4A4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        mylist[index].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
