import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gux/design/Avatar.dart';
import 'package:gux/gux/page/widget/card/credit_card.dart';
import 'package:gux/gux/page/widget/card/car_insurance_card.dart';
import 'package:gux/gux/page/widget/card/donation_card.dart';
import 'package:gux/gux/page/widget/card/hotel_card.dart';
import 'package:gux/gux/page/widget/card/restaurant_card.dart';
import 'package:gux/gux/page/widget/control/thermostat_dial.dart';
import 'package:gux/gux/page/widget/tile/coupon_tile.dart';
import '../../../design/avatars.dart';
import '../../../design/comment.dart';
import '/widget/gx_tab_item.dart';

import '../../../design/styles.dart' as styles;
import 'control/address_form.dart';

class CardPage extends StatelessWidget {

  CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '卡片导航',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWomanRun(context),
            SizedBox(height: styles.padding,),
            _buildVideoInfo(context),
            SizedBox(height: styles.padding,),
            _buildWomanModel(context),
            SizedBox(height: styles.padding,),
            _buildDoctorCard(context),
            SizedBox(height: styles.padding,),
            CreditCard(cardNumber: '888888888888888', cardHolder: 'Hello', expiryDate: '12/99',),
            SizedBox(height: styles.padding,),
            CouponTile(amount: 12.05, minSpend: 10, validTime: '12:00', onUse: () {}),
            SizedBox(height: styles.padding,),
            CarInsuranceCard(plateNumber: '渝DDD88888', ownerName: '所有者', vehicleModel: '大众ABC200', insuranceStartDate: '2024-12-12', commercialStartDate: '2025-12-12', onEdit: () {}),
            SizedBox(height: styles.padding,),
            _buildWithCard(DonationCard(),),
            SizedBox(height: styles.padding,),
            _buildWithCard(HotelCard()),
            SizedBox(height: styles.padding,),
            _buildWithCard(RestaurantCard()),
            SizedBox(height: styles.padding,),
            _buildWithCard(DiscountCard()),
            SizedBox(height: styles.padding,),
            SizedBox(height: styles.padding,),
            SizedBox(height: styles.padding,),
          ],
        ),
      ),
    );
  }

  ///
  /// 0001
  ///
  Widget _buildWomanRun(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.symmetric(horizontal: styles.padding,),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - styles.padding * 2,
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage("asset/image/widget/card/runners.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: -120,
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              margin:EdgeInsets.only(top: 20,right: 150 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage("asset/image/widget/card/womanrun.png"),
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 100,
            //color: Colors.redAccent.withOpacity(0.3),
            margin:  EdgeInsets.only(left: 155, top: 65),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You are doing great",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    text: "Keep it up\n",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                          text: "stick to your plan"
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 0002
  ///
  Widget _buildVideoInfo(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - styles.padding * 2,
      margin: EdgeInsets.symmetric(horizontal: styles.padding,),
      height: 220,
      decoration:BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff0f17ad).withOpacity(0.8),
            Color(0xFF6985e8).withOpacity(0.9)],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(80),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(5,10),
            blurRadius: 20,
            color: Color(0xFF6985e8).withOpacity(0.2),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 25,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Next workout",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFf4f5fd),
              ),),
            SizedBox(height: 5,),
            Text("Legs Toning",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFFf4f5fd),
              ),),
            SizedBox(height: 5,),
            Text("and Glutes Workout",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFFf4f5fd),
              ),),
            SizedBox(height: 25,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer, size: 20,color: Color(0xFFf4f5fd),),
                    SizedBox(width: 10,),
                    Text("60min",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFf4f5fd),
                      ),),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff0f17ad),
                          blurRadius: 10,
                          offset: const Offset(4,8)
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 60,
                  ),
                )
              ],
            )
          ],
        ),),);
  }

  ///
  /// 0003
  ///
  Widget _buildWomanModel(BuildContext context) {
    return Container(
      width: styles.screenWidth,
      padding: EdgeInsets.only(
        left: styles.padding,
        right: styles.padding,
      ),
      height: 190,
      child: Stack(
        children: [
          Container(
            height: 150,
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Color(0xFFF2F3FF),
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  SizedBox(width: 64,),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20.0,
                              height: 3.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: 4),
                            Container(
                              width: 10.0,
                              height: 3.0,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(width: 4),
                            Container(
                              width: 10.0,
                              height: 3.0,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                        // Space from dot
                        SizedBox(height: 8.0),

                        // Discount Text
                        Text(
                          'Get 30% Off',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: Container(
              height: 190,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'asset/image/widget/card/womanmodel.png',
                  fit: BoxFit.cover,
                  height: 180,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(35.0), topLeft: Radius.circular(35.0)),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: Text(
                    'Know More',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// 0004
  /// 
  Widget _buildDoctorCard(BuildContext context) {
    return Card(
      color: const Color(0xFF448AFF),
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  backgroundImage:  AssetImage('asset/image/widget/card/womanmodel.png'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '名称',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '主任医师',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '2024-01-09',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 24),
                const Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '12:00',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildWithCard(Widget widget) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: styles.padding),
      child: widget,
    );
  }
}

class DiscountCard extends StatelessWidget {
  final double discountPercentage;
  final String imagePath;

  const DiscountCard({
    super.key,
    this.discountPercentage = 30,
    this.imagePath = 'asset/image/widget/card/bicycle.png',
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: Clip.antiAlias, // Important for smooth edges
      clipper: DiagonalClipper(),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueGrey[900]!,
              Colors.blueGrey[500]!,
            ],
          ),
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Image.asset(
                    imagePath,
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                ]
              ),
            ),
            Positioned(
              left: 15,
              bottom: 20,
              child: Text(
                '${discountPercentage.toInt()}% Off',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    double radius = 20;
    Path path = Path();
    path.moveTo(radius, 0);
    /// top right
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius), clockwise: true);
    /// bottom right
    path.lineTo(size.width, size.height - 40 - radius);
    path.arcToPoint(Offset(size.width - radius, size.height - 40), radius: Radius.circular(radius), clockwise: true);
    /// bottom left
    path.lineTo(radius, size.height);
    path.arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius), clockwise: true);
    /// top left
    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius), clockwise: true);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CirclePatternPage extends StatelessWidget {
  const CirclePatternPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomPaint(
          size: const Size(200, 200),
          painter: CirclePatternPainter(),
        ),
      ),
    );
  }
}

class CirclePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const maxRadius = 100.0;

    // Paint for the circles
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw multiple concentric circles
    for (int i = 0; i < 6; i++) {
      final radius = maxRadius - (i * 15);
      canvas.drawCircle(center, radius, paint);
    }

    // Draw diagonal lines
    final linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 1.0;

    // Draw diagonal lines crossing the circles
    for (double angle = 0; angle < 360; angle += 45) {
      final radians = angle * (3.14159 / 180);
      final startX = center.dx + maxRadius * 1.2 * cos(radians);
      final startY = center.dy + maxRadius * 1.2 * sin(radians);
      final endX = center.dx - maxRadius * 1.2 * cos(radians);
      final endY = center.dy - maxRadius * 1.2 * sin(radians);

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}