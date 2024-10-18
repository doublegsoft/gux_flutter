
import 'dart:ui';

import 'package:flutter/material.dart';

class Drill {

  List<dynamic> equipments = [];

  dynamic? selected;

  void clearSelected() {
    for (dynamic el in equipments) {
      if (el.type == Equipment.player) {
        Player player = el as Player;
        player.selected = false;
      }
    }
  }

  dynamic? locateEquipment(Offset point) {
    for (dynamic el in equipments) {
      if (el.type == Equipment.player) {
        Player player = el as Player;
        if (player.contain(point)) {
          return player;
        }
      }
    }
    return null;
  }

  Drill clone() {
    Drill ret = Drill();
    ret.equipments.addAll(equipments);
    return ret;
  }
}

enum Equipment {

  player,

  football,

  coach,

  wall,

  cone,

  none,
}

enum DrillAction {

  positioning,

  running,

  passing,

  dribbling,

  shooting,

  substituting,

  dismissed,

  none,
}

class Football {

  final Equipment type = Equipment.football;

  Offset? start;

}

class Player {

  final Equipment type = Equipment.player;

  ///
  /// start position
  ///
  Offset? start;

  ///
  /// present position
  ///
  Offset position;

  double speed;

  double size = 0;

  bool selected = false;

  Color background = Colors.orange;

  Color foreground = Colors.white;

  int number = 10;

  ///
  /// moving path
  ///
  final List<Running> runnings = [];

  Player({
    required this.position,
    this.speed = 1.0,
  });

  bool contain(Offset point) {
    if (point.dx > position.dx - size! &&
        point.dx < position.dx + size! &&
        point.dy > position.dy - size! &&
        point.dy < position.dy + size!) {
      return true;
    }
    return false;
  }

  void moveTo(Offset pos) {
    position = pos;
  }

  void run(Offset dest) {
    Running run = Running(start: position, end: dest);
    runnings.add(run);
  }

  void dribble(Offset dest) {

  }

  void pass(Offset dest) {

  }

  Offset finish() {
    if (runnings.length == 0) {
      return position;
    }
    return runnings[runnings.length - 1].end;
  }

  Player clone() {
    Player ret = Player(position: position);
    ret.number = number;
    ret.speed = speed;
    ret.foreground = foreground;
    ret.background = background;
    ret.size = size;
    return ret;
  }

}

class Running {

  final double speed;

  final Offset start;

  final Offset end;

  final bool dribble;

  Offset? control;

  Running({
    required this.start,
    required this.end,
    this.dribble = false,
    this.speed = 1.0,
    this.control,
  });
}

class Passing {

  final Offset start;

  final Offset end;

  Offset? control;

  Passing({
    required this.start,
    required this.end,
    this.control,
  });
}