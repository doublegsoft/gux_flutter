
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gux/gux/page/app/trainimation/model/poco.dart';

import 'package:gux/widget/gx_bottom_picker.dart';

import '/gux/page/app/trainimation/futsal_pitch_painter.dart';
import '/gux/page/app/trainimation/soccer_pitch_painter.dart';

import '/styles.dart' as styles;

class TrainimationApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => TrainimationAppState();

}

class TrainimationAppState extends State<TrainimationApp> with SingleTickerProviderStateMixin {

  String _numberOfPlayersPerSide = '五人制';

  bool _toolbarShown = false;

  bool _playing = false;

  Equipment _selectedEquipment = Equipment.none;

  DrillAction _selectedDrillAction = DrillAction.none;

  dynamic? _selectedEquipmentInPitch = null;

  final Drill _drill = Drill();

  late AnimationController _animationController;

  Animation? _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1000,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          width: styles.screenWidth,
          child: Row(
            children: [
              SizedBox(width: (styles.screenWidth - 72 - styles.padding * 8) / 2 - 72),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _playing = !_playing;
                    _playOrStop();
                  });
                },
                child: Container(
                  width: 36,
                  height: 36,
                  child: _playing ? Image.asset('asset/image/app/trainimation/pause.png')
                      : Image.asset('asset/image/app/trainimation/play.png')
                ),
              ),
              SizedBox(width: 36),
              GestureDetector(
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      child: Text('$_numberOfPlayersPerSide', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 22,),
                  ],
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => GXBottomPicker(
                      options: ['五人制','八人制','十一人制'].map<GXBottomPickerOption>((single) => GXBottomPickerOption(
                        value: single,
                        label: single,
                      )).toList(),
                      value: _numberOfPlayersPerSide,
                      clearable: false,
                      onSelected: (option) {
                        setState(() {
                          _numberOfPlayersPerSide = option.label;
                        });
                      },
                    ),
                  );
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _toolbarShown = !_toolbarShown;
                    ///
                    /// 重置
                    ///
                    if (!_toolbarShown) {
                      _clearAll();
                    }
                  });
                },
                child: Container(
                  width: 36,
                  height: 36,
                  child: Image.asset('asset/image/app/trainimation/equipment.png'),
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Container(),
      body: Stack(
        children: [
          GestureDetector(
            onTapDown: (detail) {
              ///
              /// 播放中不接受一切操作
              ///
              if (_playing) {
                return;
              }
              if (_selectedEquipment == Equipment.none) {
                if (_selectedDrillAction == DrillAction.positioning) {
                  _moveEquipmentInPitch(detail.localPosition);
                } else if (_selectedDrillAction == DrillAction.running) {
                  _addRunningToPlayer(detail.localPosition);
                } else {
                  _selectEquipmentInPitch(detail.localPosition);
                }
              } else {
                _addEquipmentIntoPitch(detail.localPosition);
              }
            },
            child: (_numberOfPlayersPerSide == '五人制') ? _buildFutsalPitch() : _buildSoccerPitch(),
          ),
          _buildToolbar(),
        ],
      ),
    );
  }

  void _addEquipmentIntoPitch(Offset position) {
    if (_selectedEquipment == Equipment.none) {
      return;
    }
    if (_selectedEquipment == Equipment.player) {
      _drill.equipments.add(Player(position: position));
    } else if (_selectedEquipment == Equipment.football) {

    }
    setState(() {
      _selectedEquipment = Equipment.none;
    });
  }

  CustomPaint _buildSoccerPitch() {
    double pitchWidth = MediaQuery.of(context).size.width;
    double pitchHeight = pitchWidth * 105 / 68;
    return CustomPaint(
      size: Size(pitchWidth, pitchHeight),
      painter: SoccerPitchPainter(_drill.clone(), _animation == null ? 0 : _animation!.value),
    );
  }

  CustomPaint _buildFutsalPitch() {
    double pitchWidth = MediaQuery.of(context).size.width;
    double pitchHeight = pitchWidth * 40 / 22;
    return CustomPaint(
      size: Size(pitchWidth, pitchHeight),
      painter: FutsalPitchPainter(_drill.clone(), _animation == null ? 0 : _animation!.value),
    );
  }

  Widget _buildToolbar() {
    if (_selectedEquipmentInPitch == null) {
      return AnimatedPositioned(
        top: _toolbarShown ? 2 : -64 * 5,
        right: 0,
        child: Container(
          color: styles.colorSurface,
          child: Column(
            children: [
              _buildToolbarItemForAdding('asset/image/app/trainimation/player.png', Equipment.player),
              _buildToolbarItemForAdding('asset/image/app/trainimation/coach.png', Equipment.coach),
              _buildToolbarItemForAdding('asset/image/app/trainimation/wall.png', Equipment.wall),
              _buildToolbarItemForAdding('asset/image/app/trainimation/cone.png', Equipment.cone),
              _buildToolbarItemForAdding('asset/image/app/trainimation/football.png', Equipment.football),
            ],
          ),
        ),
        duration: Duration(milliseconds: 300),
      );
    }
    if (_selectedEquipmentInPitch.type == Equipment.player) {
      return AnimatedPositioned(
        top: _toolbarShown ? 2 : -64 * 7,
        right: 0,
        child: Container(
          color: styles.colorSurface,
          child: Column(
            children: [
              _buildToolbarItemForMoving('asset/image/app/trainimation/positioning.png', DrillAction.positioning),
              _buildToolbarItemForMoving('asset/image/app/trainimation/passing.png', DrillAction.passing),
              _buildToolbarItemForMoving('asset/image/app/trainimation/running.png', DrillAction.running),
              _buildToolbarItemForMoving('asset/image/app/trainimation/dribbling.png', DrillAction.dribbling),
              _buildToolbarItemForMoving('asset/image/app/trainimation/shooting.png', DrillAction.shooting),
              _buildToolbarItemForMoving('asset/image/app/trainimation/substituting.png', DrillAction.substituting),
              _buildToolbarItemForMoving('asset/image/app/trainimation/dismissed.png', DrillAction.dismissed),
            ],
          ),
        ),
        duration: Duration(milliseconds: 300),
      );
    }
    return Container();
  }
  
  Widget _buildToolbarItemForAdding(String icon, Equipment equipment) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEquipment = equipment;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: styles.padding / 2, horizontal: styles.padding / 2),
        width: 64,
        height: 64,
        color: _selectedEquipment == equipment ? Colors.white : Colors.blue,
        child: Image.asset(icon),
      ),
    );
  }

  Widget _buildToolbarItemForMoving(String icon, DrillAction action) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDrillAction = action;
        });
        if (_selectedDrillAction == DrillAction.substituting) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 400,
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    if (_selectedEquipmentInPitch == null) {
                      return;
                    }
                    _selectedEquipmentInPitch.number = index + 1;
                    setState(() {});
                  },
                  children: List.generate(40, (index) => 1 + index).map((num) {
                    return Center(
                      child: Text(num.toString()),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: styles.padding / 2, horizontal: styles.padding / 2),
        width: 64,
        height: 64,
        color: _selectedDrillAction == action ? Colors.white : Colors.blue,
        child: Image.asset(icon),
      ),
    );
  }

  void _selectEquipmentInPitch(Offset point) {
    _drill.clearSelected();
    dynamic equipment = _drill.locateEquipment(point);
    if (equipment != null) {
      if (equipment.type == Equipment.player) {
        Player player = equipment as Player;
        player.selected = true;
        setState(() {
          _selectedEquipmentInPitch = player;
          _toolbarShown = true;
        });
      }
    } else {
      setState(() {
        if (_toolbarShown) {
          _toolbarShown = false;
        }
      });
      Future.delayed(Duration(seconds: 1), () {
        _selectedEquipmentInPitch = null;
      });
    }
  }

  void _moveEquipmentInPitch(Offset pos) {
    if (_selectedEquipmentInPitch == null) {
      return;
    }
    _selectedEquipmentInPitch.moveTo(pos);
    setState(() {});
  }

  void _addRunningToPlayer(Offset pos) {
    if (_selectedEquipmentInPitch == null) {
      return;
    }
    if (!(_selectedEquipmentInPitch is Player)) {
      return;
    }
    Player player = _selectedEquipmentInPitch as Player;
    player.run(pos);
    setState(() {});
  }

  ///
  /// clear all and reset to fresh.
  ///
  void _clearAll() {
    _drill.clearSelected();
    setState(() {
      _selectedEquipmentInPitch = null;
      _selectedDrillAction = DrillAction.none;
      _selectedEquipment = Equipment.none;
    });
  }

  ///
  /// play animation
  ///
  void _playOrStop() {
    _clearAll();
    setState(() {
      _toolbarShown = false;
    });
    _animationController.addListener(() {
      setState(() {});
    });
    if (_playing) {
      _animation = StepTween(begin: 0, end: 1000).animate(_animationController);
      _animationController.forward();
    } else {
      _animationController.stop();
    }

    // _drill.equipments.forEach((equip) {
    //   if (equip is Player) {
    //     Player player = equip as Player;
    //     player.start = player.position;
    //     while (player.position != player.finish()) {
    //       Future.delayed(Duration(milliseconds: 100), () {
    //         player.position = player.position + Offset(1,1);
    //         setState(() {});
    //       });
    //     }
    //   }
    // });
  }
}

