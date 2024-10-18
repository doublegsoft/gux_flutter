import 'package:flutter/material.dart';
import 'package:gux/gux/page/app/open_street_map_app.dart';
import 'package:gux/gux/page/app/zuji_football_app.dart';

import '/gux/page/app/trainimation_app.dart';
import '/styles.dart' as styles;



class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('应用'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildApp(context, '足迹 Football', 'asset/image/logo/zuji.png', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ZujiFootballApp()),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: _buildApp(context, 'Open Street Map', 'asset/image/logo/openstreetmap.png', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => OpenStreetMapApp()),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: _buildApp(context, 'MacroFactor', 'asset/image/logo/macrofactor.png', () {
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => OpenStreetMapApp()),
              // );
            }),
          ),
          SliverToBoxAdapter(
            child: _buildApp(context, 'Trainimation', 'asset/image/logo/trainimation.png', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => TrainimationApp()),
              );
            }),
          ),
        ],
      ),
    );
  }
  
  Widget _buildApp(BuildContext context, String title, String icon, Function() onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: styles.padding / 2, horizontal: styles.padding),
          leading: Image.asset(icon, width: 36, height: 36, fit: BoxFit.cover,),
          title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          onTap: onTap,
        ),
        Container(
          color: styles.colorDivider,
          child: SizedBox(
            height: 1,
            width: styles.screenWidth * 0.88,
          ),
        ),
      ],
    );

  }
}
