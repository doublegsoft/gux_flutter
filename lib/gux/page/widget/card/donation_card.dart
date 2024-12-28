import 'package:flutter/material.dart';

import 'package:gux/design/styles.dart' as styles;

class DonationCard extends StatelessWidget {
  const DonationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!,),
        borderRadius: BorderRadius.circular(16),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.grey,
        //     blurRadius: 1,
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage('asset/image/widget/card/donation.png',),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('2 Days Left',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Donate for Cancer Patients',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Text('80%',
                        style: TextStyle(
                            color: Colors.green
                        ),
                      ),
                    )
                  ],
                ),
                const Text(
                  'Arrange by Care Club',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: 0.8,
                  minHeight: 8,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                  backgroundColor: Colors.grey[300]!,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '\$10245.00 USD',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600]!,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Donate'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}