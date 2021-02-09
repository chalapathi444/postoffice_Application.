import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Postoffice {
  final String country;
  final String name;
  final String state;
  final String circle;
  Postoffice(
      {@required this.country,
      @required this.name,
      @required this.circle,
      @required this.state});
}
