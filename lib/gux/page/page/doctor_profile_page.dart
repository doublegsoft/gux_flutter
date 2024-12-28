import 'package:flutter/material.dart';
import 'package:gux/design/buttons.dart';
import 'package:gux/design/ratings.dart';

import 'package:gux/design/styles.dart' as styles;

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 375.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('张慧娴医生',
                  style: TextStyle(
                    color: styles.colorTextPrimary,
                    fontSize: 20.0,
                  ),
                ),
                background: Image.asset(
                  "asset/image/page/doctor.png",
                  height: 375,
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: Colors.black),
                  onPressed: () {
                    // Handle bookmark action
                  },
                ),
              ],
            ),
          ];
        },
        body: SingleChildScrollView( // Add SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Heart • Persahabatan Hospital',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'dr. Gilang is one of the best doctors in the Persahabatan Hospital. He has saved more than 1000 patients in the past 3 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
                      style: TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoColumn('Experience', '3', '年'),
                        _buildInfoColumn('Patient', '1221', '人'),
                        _buildInfoColumn('Rating', '5.0', ''),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        CircleButton(icon: Icon(Icons.phone_forwarded, size: 36, color: Colors.white,)),
                        const SizedBox(width: 8),
                        CircleButton(icon: Icon(Icons.video_call_outlined, size: 36, color: Colors.white,)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle appointment action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: styles.colorSuccess,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16), // Adjust padding
                            ),
                            child: const Text('快去挂号吧', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value, String unit) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        if (title != 'Rating') Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value, style: const TextStyle(fontSize: 18, color: Colors.blue)),
            SizedBox(width: 2,),
            if (unit.isNotEmpty) Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]
        ),
        if (title == 'Rating') StarRating(
          rating: 5,
          starSize: 20,
        ),
      ],
    );
  }
}