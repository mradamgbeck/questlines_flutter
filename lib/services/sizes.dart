import 'package:flutter/material.dart';

getPercentageOfScreen(context, percentage) {
  return MediaQuery.of(context).size.width * percentage;
}
