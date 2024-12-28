import 'package:flutter/material.dart';
import 'package:gux/common/format.dart';
import 'package:gux/design/avatar.dart';
import 'package:gux/design/buttons.dart';
import 'package:gux/design/loading.dart';
import 'package:gux/model/dto.dart';
import 'package:gux/provider/schedule_provider.dart';
import 'package:gux/sdk/sdk.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:gux/design/styles.dart' as styles;

class SchedulePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SchedulePageState();

}

class SchedulePageState extends State<SchedulePage> {

  CalendarFormat _calendarFormat = CalendarFormat.week;

  DateTime _selectedDay = DateTime.now();

  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScheduleProvider>().fetchSchedules(ScheduleQuery());
    });
  }

  @override
  void didUpdateWidget(covariant SchedulePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(yearAndMonth4Chinese(_focusedDay),),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_calendarFormat == CalendarFormat.week) {
                  _calendarFormat = CalendarFormat.month;
                } else {
                  _calendarFormat = CalendarFormat.week;
                }
              });
            },
            icon: Icon(_calendarFormat == CalendarFormat.week ? Icons.calendar_view_month : Icons.view_week),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 4,),
          _buildWeekCalendar(),
          SizedBox(height: 8,),
          Expanded(child: _buildSchedule()),
        ],
      ),
    );
  }

  Widget _buildWeekCalendar() {
    return TableCalendar(
      locale: 'zh_CN',
      headerVisible: false,
      firstDay: DateTime(1900, 1, 1),
      lastDay: DateTime(2099, 12, 31),
      calendarFormat: _calendarFormat,
      focusedDay: _focusedDay,
      calendarStyle: CalendarStyle(
        cellPadding: EdgeInsets.all(0),
        cellMargin: EdgeInsets.all(0),
      ),
      daysOfWeekHeight: 24,
      rowHeight: 32,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onFormatChanged: null,
      onPageChanged: (DateTime date) {
        setState(() {
          _focusedDay = date;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = selectedDay;
        });
      },
    );
  }

  Widget _buildSchedule() {
    return Consumer<ScheduleProvider>(
      builder: (BuildContext context, ScheduleProvider provider, Widget? child) {
        if (provider.state == DataState.loading) {
          return Center(child: Loading(size: 96,),);
        } else if (provider.state == DataState.error) {
          return Center(
            child: Text('出错啦！'),
          );
        }
        return ListView(
          padding: EdgeInsets.all(20),
          children: provider.schedules.map((schedule) {
            return ScheduleItem(
              schedule: schedule,
            );
          }).toList(),
        );
      },
    );
  }
}

class ScheduleItem extends StatelessWidget {

  ScheduleQuery schedule;

  ScheduleItem({
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 18,),
              Text(DateFormat('HH:mm').format(schedule.startTime!), style: TextStyle(color: Colors.black, fontSize: 16)),
              Text('${schedule.endTime!.difference(schedule.startTime!).inMinutes}min', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        SizedBox(width: 10),
        // Vertical line with circle
        Column(
          children: [
            Container(
              width: 4,
              height: 28,
              color: Colors.grey,
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey,)
              ),
            ),
            Container(
              width: 4,
              height: 72,
              color: Colors.grey,
            ),
          ],
        ),
        SizedBox(width: 10),
        // Event details card
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 12,),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(schedule.activity!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      color: Colors.white,
                      position: PopupMenuPosition.under,
                      iconSize: 16,
                      icon: Icon(Icons.more_horiz_outlined, color: styles.colorTextInverse,),
                      itemBuilder: (context) => [
                        PopupMenuItem(child: Text('Option 1'), value: '1'),
                        PopupMenuItem(child: Text('Option 2'), value: '2'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.grey, size: 16,),
                    SizedBox(width: 4),
                    Text(schedule.location!,
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}