import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  YoutubePlayerController _afad = YoutubePlayerController(
    initialVideoId: 'oZeI0X40EEY',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
  YoutubePlayerController _akut = YoutubePlayerController(
    initialVideoId: 'G1sHBXX88GI',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
  YoutubePlayerController _eskisehir = YoutubePlayerController(
    initialVideoId: '0dB2AycWeHg',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Informational Videos',style: GoogleFonts.openSans(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'AFAD Video',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: _afad),
                  builder: (context, player) {
                    return Container(
                      child: player,
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'AKUT Video',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: _akut),
                  builder: (context, player) {
                    return Container(
                      child: player,
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Eskisehir Video',
                  style:
                  TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                YoutubePlayerBuilder(
                  player:
                  YoutubePlayer(controller: _eskisehir),
                  builder:
                      (context, player) {
                    return Container(
                      child:
                      player,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
