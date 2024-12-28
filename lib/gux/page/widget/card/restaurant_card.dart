import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Adjust as needed
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              'asset/image/widget/card/restaurant.png', // Replace with your image path
              height: 150, // Adjust image height as needed
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Katsuel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.verified,
                          color: Colors.red, // Or your desired checkmark color
                          size: 16,
                        ),
                      ],
                    ),
                    const Text(
                      'Japanese • Sushi',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('10-15 min • \$2.99 • ', style: TextStyle(fontSize: 12,),),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 16,
                        ),
                        const Text('4.8', style: TextStyle(fontSize: 12,)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0), // Add some padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                  children: [
                    _buildUserAvatar(1, 'asset/image/widget/card/doctor.png'),
                    _buildUserAvatar(2, 'asset/image/widget/card/doctor.png'),
                    _buildUserAvatar(3, 'asset/image/widget/card/doctor.png'),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }


  Widget _buildUserAvatar(int rank, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(left: 0), // Overlap avatars slightly
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2), // White border
      ),
      child: CircleAvatar(
        radius: 18,
        backgroundImage: AssetImage(imagePath),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange, // Background color for the rank
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              '${rank}st', // Use correct suffix based on rank
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }
}