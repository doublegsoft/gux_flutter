import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF212530).withOpacity(0.7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Final Score',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // Handle info
            },
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/image/page/stadium_background.png'), // Replace with actual asset path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFF212530).withOpacity(0.7), // Adjust opacity here
              BlendMode.srcOver,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            SizedBox(height: 16),
            _buildStatisticSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Full Time',
          style: TextStyle(color: Colors.green, fontSize: 12),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/image/page/barcelona.png', width: 60, height: 60), // Replace with actual asset path
            SizedBox(width: 16),
            Text('2', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(' - ', style: TextStyle(fontSize: 40, color: Colors.white)),
            Text('2', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(width: 16),
            Image.asset('asset/image/page/mancity.png', width: 60, height: 60), // Replace with actual asset path
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('De Jong 66\'', style: TextStyle(color: Colors.white70)),
                Text('Depay 79\'', style: TextStyle(color: Colors.white70)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Alvarez 21\'', style: TextStyle(color: Colors.white70)),
                Text('Palmer 70\'', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticSection() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Statistic Match',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8),
            _buildStatisticRow('Shoot', '11', '16'),
            _buildStatisticRow('Shoot on Target', '7', '8'),
            _buildStatisticRow('Ball Possession', '48%', '52%'),
            _buildStatisticRow('Pass', '500', '532'),
            _buildStatisticRow('Pass Accuracy', '89%', '90%'),
            _buildStatisticRow('Foul', '7', '13'),
            _buildStatisticRow('Yellow Card', '0', '1'),
            _buildStatisticRow('Red Card', '0', '0'),
            _buildStatisticRow('Offiside', '1', '5'),
            _buildStatisticRow('Corner Kick', '3', '2'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticRow(String label, String value1, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value1, style: TextStyle(color: Colors.white, fontSize: 16)),
          Text(label,
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          Text(value2, style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}