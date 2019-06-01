import 'package:flutter/material.dart';
import 'package:flutter_sdr_app/model/sdrteammodel.dart';
import 'package:flutter_sdr_app/services/teamservice.dart';

// Define a Custom Form Widget
class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() {
    return _TeamScreenState();
  }
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class _TeamScreenState extends State<TeamScreen> {
  List<TeamMember> _sdrRjTeamList;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Team'),
      ),
      body: _CreateRJList(),
    );
  }

  FutureBuilder<TeamList> _CreateRJList() {
    return FutureBuilder<TeamList>(
      future: getTeamList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _sdrRjTeamList = snapshot.data.sdrRJs;
          return ListView.builder(
            itemBuilder: _createTeamRepeater,
            itemCount: snapshot.data.sdrRJs.length,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _createTeamRepeater(BuildContext context, int index) {
    return Row(children: <Widget>[
      CircleAvatar(
        radius: 60.0,
        backgroundImage: NetworkImage(_sdrRjTeamList[index].memberLogoUrl),
      ),
      Expanded(
          child: Column(
        children: <Widget>[
          Text(_sdrRjTeamList[index].memberName),
          Text(_sdrRjTeamList[index].memberTitle),
          Text(_sdrRjTeamList[index].memberLanguage),
        ],
      ))
    ]);
  }
}
