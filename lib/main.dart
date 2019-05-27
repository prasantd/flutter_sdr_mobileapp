import 'package:flutter/material.dart';
import 'sdrhome.dart';

void main() => runApp(
      ShuddhDesiRadioApp(),
    );

class ShuddhDesiRadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuddh Desi Radio',
      home: ShuddhDesiRadioHome(),
    );
  }
}
