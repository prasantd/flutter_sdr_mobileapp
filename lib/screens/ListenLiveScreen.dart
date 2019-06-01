import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_sdr_app/services/sdrsponsorservice.dart';
import 'package:flutter_sdr_app/model/sponsorsjson.dart';

import 'package:flutter_sdr_app/services/sdrradioplayerservice.dart';
import 'package:flutter_sdr_app/model/sdrradioplayerdetails.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

Future<SponsorList> _future;

class ListenLiveScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListenLiveScreenState();
  }
}

class _ListenLiveScreenState extends State<ListenLiveScreen> {
  Timer _timer;
  final topSection = new Container(
    child: Image.asset('images/sdrfaceimage.jpeg'),
  );

  @override
  void initState() {
    super.initState();
    _future = getSponsor();
    _timer = new Timer.periodic(
        Duration(seconds: 30),
        (Timer t) => setState(() {
              CreateTrackTitle();
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.bottomCenter,
        child: Column(children: <Widget>[
          new Expanded(
            child: topSection,
            flex: 5,
          ),
          new Expanded(
            child: CreateSponsorWidget(),
            flex: 2,
          ),
          new Expanded(
            child: CreatePlayerWidget(),
            flex: 3,
          ),
        ]));
  }

// ignore: non_constant_identifier_names

}

class CreatePlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Row(children: <Widget>[
      //IMAGE
      Image.asset('images/sdrlogo.png'),
      //PLAY BUTTON
      PlayPausebutton(),
      //title
      CreateTrackTitle()
    ]));
  }
}

class CreateTrackTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentTrack>(
        future: getCurrentDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
                child: MarqueeWidget(
              text: snapshot.data.nowPlayingInfo.titleTrack,
              scrollAxis: Axis.horizontal,
            ));
          } else if (snapshot.hasError) {
            return new Text('Shuddh Desi Radio Broadcast');
          } else
            return CircularProgressIndicator();
        });
  }
}

class CreateSponsorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SponsorList>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  snapshot.data.sponsors[index].sponsorLogo,
                  fit: BoxFit.fill,
                );
              },
              itemCount: snapshot.data.sponsors.length,
              autoplay: true,
            );
          } else if (snapshot.hasError) {
            return new Text(
              'Coming Soon',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Verdana',
                fontWeight: FontWeight.bold,
              ),
            );
          } else
            return CircularProgressIndicator();
        });
  }
}

class PlayPausebutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AudioComponent(
        updateMe: [
          WatchableAudioProperties.audioPlayerState,
        ],
        playerBuilder:
            (BuildContext context, AudioPlayer player, Widget child) {
          IconData icon = Icons.music_note;
          Function onPressed;

          if (player.state == AudioPlayerState.playing) {
            icon = Icons.pause;
            onPressed = player.pause;
          } else if (player.state == AudioPlayerState.paused) {
            icon = Icons.play_arrow;
            onPressed = player.play;
          }
          return new RawMaterialButton(
              shape: new CircleBorder(),
              fillColor: Colors.grey,
              onPressed: onPressed,
              child: new Icon(
                icon,
                size: 35.0,
              ));
        });
  }
}
