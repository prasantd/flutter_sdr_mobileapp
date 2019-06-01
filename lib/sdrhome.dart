import 'package:flutter/material.dart';
import 'package:flutter_sdr_app/screens/ListenLiveScreen.dart';
import 'package:flutter_sdr_app/screens/SongRequestScreen.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:flutter_sdr_app/services/getversion.dart';
import 'package:flutter_sdr_app/screens/SDRTeamScreen.dart';
class ShuddhDesiRadioHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SDRHomeState();
  }
}

class _SDRHomeState extends State<ShuddhDesiRadioHome> {
  int _currentIndex = 0;
  String appcurrentbuild;

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
            currentIndex: _currentIndex, // ne
            // w
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
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                new DrawerHeader(child:
                Text('Shuddh Desi Radio',
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,),
                  decoration: new BoxDecoration(
                    color: Colors.deepPurple,
                  ),

                ),
                /*ListTile(
                  title: Text('About Us'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  title: Text('Sponsors'),
                    trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => new TeamScreen()) );
                  },
                  title: Text('Our Team'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  title: Text('Contact Us'),
                    trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),*/
                new Divider(),
                CreateVersionWidget(),

                new Divider(),

                //  Icon(Icons),
              ],

            ),
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


}

class CreateVersionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<String>(
        future: getVersionInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text('Version: ${snapshot.data}',
              textAlign: TextAlign.center,);
          } else if (snapshot.hasError) {
            return new Text('1.0');
          } else
            return CircularProgressIndicator();
        });
  }

}
