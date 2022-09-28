import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listapi/multiplayer/multiplayer.dart';
import 'package:listapi/online/play.dart';

class Categori extends StatefulWidget {
  final bool multiplayer;
  const Categori({Key? key, required this.multiplayer}) : super(key: key);

  @override
  State<Categori> createState() => _CategoriState();
}

class _CategoriState extends State<Categori> {
  getDataList() async {
    Uri url = Uri.parse("https://iqbalroni.github.io/soal_kuis/categori.json");
    var object = await http.get(url);
    var response = json.decode(object.body);
    return response;
  }

  _klik() {
    final player = AudioCache();
    player.play("click.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff42B4A4),
      appBar: AppBar(
        backgroundColor: Color(0xff42B4A4),
        title: Center(
          child: widget.multiplayer
              ? Text("MULTIPLAYER QUIZ")
              : Text("MATERI QUIZ"),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getDataList(),
        builder: (context, AsyncSnapshot row) {
          if (row.hasData) {
            return ListView.builder(
              itemCount: row.data.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    _klik();
                    row.data[index]['lock']
                        ? Navigator()
                        : widget.multiplayer
                            ? Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                return Multiplayer(
                                  kunci: row.data[index]['key'].toString(),
                                  judul: row.data[index]['categori'].toString(),
                                );
                              }))
                            : Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                return Play(
                                  kunci: row.data[index]['key'].toString(),
                                  judul: row.data[index]['categori'].toString(),
                                );
                              }));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          row.data[index]['categori'].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff252525),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          child: row.data[index]['lock']
                              ? Icon(
                                  Icons.lock,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.lock_open,
                                  size: 16,
                                  color: Colors.white,
                                ),
                          decoration: BoxDecoration(
                            color: row.data[index]['lock']
                                ? Color(0xffF7374D)
                                : Color(0xff7895B2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Memuat Materi..",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


// https://iqbalroni.github.io/soal_kuis/categori.json
