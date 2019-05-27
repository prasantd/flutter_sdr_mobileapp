import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShuddhDesiRoutes {
  static final home = "/";
  static final songRequest = "/songRequest";
}

class ShuddhDesiTheme {
  static get theme {
    final originalTextTheme = ThemeData.dark().textTheme;
    final originalBody1 = originalTextTheme.body1;

    return ThemeData.dark().copyWith(
        primaryColor: Colors.grey[800],
        accentColor: Colors.cyan[300],
        buttonColor: Colors.grey[800],
        textSelectionColor: Colors.cyan[100],
        backgroundColor: Colors.grey[800],
        toggleableActiveColor: Colors.cyan[300],
        textTheme: originalTextTheme.copyWith(
            body1:
                originalBody1.copyWith(decorationColor: Colors.transparent)));
  }
}

class ShuddhDesiKeys {
  // Home Screens
  static final listenLiveScreen = const Key('__listenLiveScreen__');
  static final snackbar = const Key('__snackbar__');

  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Tabs
  static final tabs = const Key('__tabs__');
  static final listenLiveTab = const Key('__listenLiveTab__');
  static final songRequestTab = const Key('__songRequestTab__');

  // song Request Screen
  static final songName = const Key('__songName__');
  static final personName = const Key('__personName__');
  static final messageDetails = const Key('__messageDetails__');

  static Key sendRequestAction(String id) =>
      Key('__sendRequest_action_${id}__');
}

class AppState {
  bool isLoading;

  AppState({
    this.isLoading = false,
  });

  factory AppState.loading() => AppState(isLoading: true);

  @override
  String toString() {
    return 'AppState{ isLoading: $isLoading}';
  }
}

enum AppTab { listenlive, songrequest }

// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.
