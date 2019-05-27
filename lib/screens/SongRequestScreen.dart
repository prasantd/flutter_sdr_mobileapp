import 'package:flutter/material.dart';
import 'package:flutter_sdr_app/services/sdrsendemail.dart';

// Define a Custom Form Widget
class SongRequestScreen extends StatefulWidget {
  @override
  _SongRequestScreenState createState() {
    return _SongRequestScreenState();
  }
}

class SongRequestModel {
  String _requestorName = "";
  String _songName = "";
  String _message = "";
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class _SongRequestScreenState extends State<SongRequestScreen> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  SongRequestModel _formData = new SongRequestModel();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'You can send your request of any song by entering the fields below. In case you want us to relay any message with your song please fill the message section below. The song will be aired in Aap Ki Farmaish on next Saturday.',
                        softWrap: true,
                      ))),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(
                        gapPadding: 3.3,
                        borderRadius: BorderRadius.circular(3.3),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      } else {
                        _formData._requestorName = value;
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Song title',
                      border: OutlineInputBorder(
                        gapPadding: 3.3,
                        borderRadius: BorderRadius.circular(3.3),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter song you want to listen';
                      } else {
                        _formData._songName = value;
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Any message?',
                      border: OutlineInputBorder(
                        gapPadding: 3.3,
                        borderRadius: BorderRadius.circular(3.3),
                      ),
                    ),
                    onSaved: (value) {
                      if (value.isNotEmpty) {
                        _formData._message = value;
                      }
                    },
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, we want to show a Snackbar
                          setState(() {
                            _formData._requestorName = _formData._requestorName;
                            _formData._songName = _formData._songName;
                            _formData._message = _formData._message;
                          });

                          SDRSendMail sdrEmail = new SDRSendMail(
                              _formData._requestorName,
                              _formData._songName,
                              _formData._message);
                          bool isSent = false;
                          sdrEmail.sendEmail().then((isSent) {
                            if (isSent)
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Your song request is sent')));
                            else
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'I am unable to send the request through this device. Please enable sending email on your device or send an email directly to info@shuddhdesiradio.com')));
                          });
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                        child: Text('Clear'),
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.reset();
                          }
                        }),
                  )
                ],
              ),
            ]));
  }
}
