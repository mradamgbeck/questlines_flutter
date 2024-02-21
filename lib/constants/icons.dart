// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:questlines/constants/values.dart';

const Icon PLAYER_ICON = Icon(
  Icons.emoji_people,
  color: Colors.black,
  size: ICON_SIZE,
);
const Icon ACTIVE_STAGE_ICON = Icon(
  Icons.api,
  color: Color.fromARGB(255, 255, 0, 170),
  size: ICON_SIZE,
);
const Icon RESET_LOCATION_ICON = Icon(
  Icons.adjust_outlined,
  shadows: [Shadow(color: Colors.white, blurRadius: 50)],
  color: Colors.blue,
  size: ICON_SIZE,
);
const Icon SELECTED_ICON = Icon(Icons.explore, color: Colors.blue);
const Icon UNSELECTED_ICON = Icon(Icons.nightlight, color: Colors.yellow);
const Icon COMPLETED_ICON = Icon(
  Icons.done,
  color: Colors.green,
);