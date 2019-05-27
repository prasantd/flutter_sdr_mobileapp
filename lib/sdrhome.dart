import 'package:flutter/material.dart';
import 'package:flutter_sdr_app/screens/ListenLiveScreen.dart';
import 'package:flutter_sdr_app/screens/SongRequestScreen.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

class ShuddhDesiRadioHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SDRHomeState();
  }
}

class _SDRHomeState extends State<ShuddhDesiRadioHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ListenLiveScreen(),
    SongRequestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Audio(
        audioUrl: "https://streamer.radio.co/se30891e37/low",
        playbackState: PlaybackState.playing,
        child: new Scaffold(
          appBar: AppBar(
            title: Text('Shuddh Desi Radio'),
          ),
          body: _children[_currentIndex], // new
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.headset),
                title: new Text('Listen Live'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.queue_music),
                title: new Text('Song Request'),
              ),
            ],
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
