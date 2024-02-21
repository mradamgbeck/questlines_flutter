// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:questlines/constants/values.dart';

const Icon PLAYER_ICON = Icon(
  Icons.emoji_people,
  color: Colors.white,
  shadows: [
    Shadow(color: Colors.black, blurRadius: 75),
    Shadow(color: Colors.black, blurRadius: 25),
  ],
  size: ICON_SIZE,
);
const Icon ACTIVE_STAGE_ICON = Icon(
  Icons.api,
  color: Colors.white, 
  shadows: [
    Shadow(color: Colors.pink, blurRadius: 25),
    Shadow(color: Colors.red, blurRadius: 75),
  ],
  size: ICON_SIZE,
);
const Icon RESET_LOCATION_ICON = Icon(
  Icons.adjust_outlined,
  color: Colors.white, 
  shadows: [
    Shadow(color: Colors.lightBlue, blurRadius: 25),
    Shadow(color: Colors.blue, blurRadius: 75),
  ],
  size: ICON_SIZE,
);
const Icon SELECTED_ICON = Icon(Icons.explore, color: Colors.blue);
const Icon UNSELECTED_ICON = Icon(Icons.nightlight, color: Colors.yellow);
const Icon COMPLETED_ICON = Icon(
  Icons.done,
  color: Colors.green,
);
const Icon SELECT_DATE_ICON = Icon(
  Icons.date_range,
  color: Colors.white,
  shadows: [Shadow(color: Colors.white, blurRadius: 50)],
);
const Icon SELECT_TIME_ICON = Icon(
  Icons.timer,
  color: Colors.white,
  shadows: [Shadow(color: Colors.white, blurRadius: 50)],
);
const Icon SELECT_LOCATION_ICON = Icon(
  Icons.map,
  color: Colors.white,
  shadows: [Shadow(color: Colors.white, blurRadius: 50)],
);
