import 'package:flutter/material.dart';

getPercentageOfScreenWidth(context, percentage) {
  return MediaQuery.of(context).size.width * percentage;
}

getPercentageOfScreenHeight(context, percentage) {
  return MediaQuery.of(context).size.height * percentage;
}
