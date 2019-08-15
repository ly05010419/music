import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttery_seekbar/fluttery_seekbar.dart';

void main() => runApp(MyApp());

List<Song> songList = [
  Song("assets/cover_01.jpg", "Never say", "Believe 2012"),
  Song("assets/cover_02.jpg", "Baby", "The Weeknd"),
  Song("assets/cover_03.png", "Boyfriend", "Believe 2012"),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  AudioPlayerState audioPlayerState = AudioPlayerState.STOPPED;

  var thumbPercent = 0.0;

  Color mainColor = Colors.redAccent;

  Color mainColor_5 = Colors.redAccent.withOpacity(0.5);

  Color mainColor_8 = Colors.redAccent.withOpacity(0.8);

  Song mainSong = songList[1];

  double audioDuration = 0;

  String localFilePath = "audio1.mp3";

  play() async {
    audioCache.play(localFilePath);
  }

  pause() async {
    audioPlayer.stop();
  }

  Widget buildSeekBar() {
    return RadialSeekBar(
      trackColor: mainColor,
      trackWidth: 2.0,
      progressColor: Colors.red,
      progressWidth: 5.0,
      thumbPercent: thumbPercent,
      thumb: CircleThumb(
        diameter: 20,
        color: Colors.red,
      ),
      progress: thumbPercent,
      onDragUpdate: (double procent) {
        setState(() {
          thumbPercent = procent;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onAudioPositionChanged.listen((position) => setState(() {
          setState(() {
            thumbPercent = position.inMilliseconds.toDouble() / audioDuration;
          });
        }));
    audioPlayer.onDurationChanged.listen((duration) => setState(() {
          audioDuration = duration.inMilliseconds.toDouble();
        }));

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        audioPlayerState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Music World",
          style: TextStyle(fontSize: 30, fontFamily: "Nexa", color: mainColor),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColor,
          ),
          onPressed: () {
            print('hallo');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            color: mainColor,
            onPressed: () {
              print('hallo');
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              height: 250,
              width: 250,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor_5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildSeekBar(),
                    ),
                  ),
                  Center(
                      child: Container(
                    width: 200,
                    height: 200,
                    child: ClipOval(
                        child: Image.asset(
                      mainSong.image,
                      fit: BoxFit.cover,
                    )),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            children: <Widget>[
              Text(
                mainSong.title,
                style: TextStyle(
                    fontSize: 28, color: mainColor, fontFamily: "NexaLight"),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                mainSong.subTitle,
                style: TextStyle(
                    fontSize: 18, color: mainColor_8, fontFamily: "NexaLight"),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 290,
                    height: 65,
                    decoration: BoxDecoration(
                        border: Border.all(color: mainColor_8, width: 3),
                        borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            iconSize: 40,
                            icon: Icon(
                              Icons.fast_rewind,
                              color: mainColor,
                            ),
                            onPressed: () {
                              print('hallo');
                            },
                          ),
                          IconButton(
                            iconSize: 40,
                            icon: Icon(
                              Icons.fast_forward,
                              color: mainColor,
                            ),
                            onPressed: () {
                              print('hallo');
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor,
                      ),
                      child: IconButton(
                        iconSize: 80,
                        icon: audioPlayerState == AudioPlayerState.PLAYING
                            ? Icon(
                                Icons.pause,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          if (audioPlayerState == AudioPlayerState.PLAYING) {
                            pause();
                            print('-----------------------------pause');
                          } else {
                            play();
                            print('-----------------------------play');
                          }
                        },
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: 200,
                    width: 30,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: 200,
                    width: 30,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30))),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildSongWidget(songList[0]),
                    buildSongWidget(songList[1]),
                    buildSongWidget(songList[2]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSongWidget(Song song) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                song.image,
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 120,
                      child: Text(song.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: mainColor))),
                  Text(
                    song.subTitle,
                    style: TextStyle(color: mainColor),
                  )
                ],
              ),
            ],
          ),
          MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            height: 50,
            minWidth: double.infinity,
            onPressed: () {
              setState(() {
                mainSong = song;
                print('mainSong:${mainSong.title}');
              });
            },
          ),
        ],
      ),
    );
  }
}

class Song {
  String image;
  String title;
  String subTitle;

  Song(this.image, this.title, this.subTitle);
}
