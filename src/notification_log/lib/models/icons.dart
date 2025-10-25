import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconsFetcher {
  static final Map<String, IconData> _packageIcons = {
    'com.facebook.katana': FontAwesomeIcons.facebook,
    'com.instagram.android': FontAwesomeIcons.instagram,
    'com.tencent.ig': FontAwesomeIcons.gamepad, // PUBG mobile
    'com.whatsapp': FontAwesomeIcons.whatsapp,
    'com.twitter.android': FontAwesomeIcons.twitter,
    'com.snapchat.android': FontAwesomeIcons.snapchat,
    'com.android.chrome': FontAwesomeIcons.chrome,
    'com.microsoft.teams': FontAwesomeIcons.microsoft,
    'com.google.android.youtube': FontAwesomeIcons.youtube,
    // Add more as needed
  };

  static IconData? getIcon(String package) {
    if (_packageIcons.containsKey(package)) {
      return _packageIcons[package];
    } else {
      return Icons.notifications;
    }
  }
}
