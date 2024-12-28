import 'package:flutter/material.dart';
import 'package:gux/design/styles.dart' as styles;

class CouponTile extends StatelessWidget {
  final double amount;
  final double minSpend;
  final String validTime;
  final VoidCallback onUse;

  const CouponTile({
    Key? key,
    required this.amount,
    required this.minSpend,
    required this.validTime,
    required this.onUse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.screenWidth - styles.padding * 2,
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF1DE9B6), // Mint green border
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left section with amount
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '¥',
                  style: TextStyle(
                    color: Color(0xFF1DE9B6),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  amount.toStringAsFixed(0),
                  style: const TextStyle(
                    color: Color(0xFF1DE9B6),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Middle section with details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '全平台通用券',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '满 ${minSpend.toStringAsFixed(0)} 元可用',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '距到期仅剩$validTime',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right section with button
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: onUse,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1DE9B6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text(
                '去使用',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}