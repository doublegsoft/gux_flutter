
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:g2d/common/move.dart';

class Drill {

  final double pitchWidth;

  final double pitchHeight;

  final double pixelWidth;

  final double pixelHeight;

  List<dynamic> equipments = [];

  dynamic? selected;

  Drill({
    required this.pitchWidth,
    required this.pitchHeight,
    required this.pixelWidth,
    required this.pixelHeight,
  });

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
    Drill ret = Drill(
      pixelWidth: pixelWidth,
      pixelHeight: pixelHeight,
      pitchWidth: pixelWidth,
      pitchHeight: pitchHeight,
    );
    ret.equipments.addAll(equipments);
    return ret;
  }

  ///
  /// the duration to complete this drill
  ///
  Duration duration() {
    double ret = 0;
    equipments.forEach((equip) {
      if (equip is Player) {
        Player player = equip as Player;
        player.runnings.forEach((run) {
          double dur = calcuateDuration(
            pixelWidth: pixelWidth,
            pitchWidth: pitchWidth,
            speed: player.speed,
            start: run.start,
            end: run.end,
          );
          if (ret < dur) {
            ret = dur;
          }
        });
      }
    });
    return Duration(milliseconds: (ret * 1000).toInt());
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
  /// initial position
  ///
  late final Offset initial;

  ///
  /// present position
  ///
  Offset present;

  double speed;

  double size = 0;

  bool selected = false;

  Color background = Colors.orange;

  Color foreground = Colors.white;

  int number = 10;

  int presentRunningPath = 0;

  ///
  /// moving path
  ///
  final List<Running> runnings = [];

  Player({
    required this.present,
    this.speed = 5.0,
  }) {
    this.initial = this.present;
  }

  bool contain(Offset point) {
    if (point.dx > present.dx - size! &&
        point.dx < present.dx + size! &&
        point.dy > present.dy - size! &&
        point.dy < present.dy + size!) {
      return true;
    }
    return false;
  }

  void moveTo(Offset pos) {
    present = pos;
  }

  void run(Offset dest) {
    if (runnings.isEmpty) {
      Running run = Running(start: present, end: dest);
      runnings.add(run);
    } else {
      Running run = Running(start: runnings[runnings.length - 1].end, end: dest);
      runnings.add(run);
    }
  }

  void dribble(Offset dest) {

  }

  void pass(Offset dest) {

  }

  Offset finish() {
    if (runnings.length == 0) {
      return present;
    }
    return runnings[runnings.length - 1].end;
  }

  Offset play() {
    return initial;
  }

  Player clone() {
    Player ret = Player(present: present);
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