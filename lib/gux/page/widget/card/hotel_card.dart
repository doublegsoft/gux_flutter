import 'package:flutter/material.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffefefef),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    'asset/image/widget/card/hotel.png',
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hyatt Regency Lisle\nnear Naperville',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orangeAccent,size: 16),
                          Icon(Icons.star, color: Colors.orangeAccent,size: 16),
                          Icon(Icons.star, color: Colors.orangeAccent,size: 16),
                          Icon(Icons.star, color: Colors.orangeAccent,size: 16),
                          Icon(Icons.star_border, color: Colors.orangeAccent,size: 16),
                          const SizedBox(width: 4),
                          Text('933',style:TextStyle(fontSize: 12, color: Colors.grey))
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Category 1',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '23.6 mi • 37.9 km',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                            height: 64,
                            child: Image.asset("asset/image/widget/card/logo.png",)
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 210,
            right: 10,
            child: Container(
              width: 120,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Text("From", style: TextStyle(color: Colors.grey,fontSize: 10)),
                  Text("5.000 Points", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 12)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 10,
            child:Container(
              width: 120,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("USD Avg/Night",style:TextStyle(color: Colors.white, fontSize: 12)),
                  Text("\$81", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                  SizedBox(height: 30,),
                  Text("View Rates",style:TextStyle(color: Colors.white,fontSize: 12,))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}