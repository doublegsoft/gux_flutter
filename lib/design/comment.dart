
import 'package:flutter/material.dart';

import '/common/format.dart';
import 'avatar.dart';

const double AVATAR_WIDTH = 36;

class CommentData {

  final String id;
  final String username;
  final DateTime date;
  final String content;
  String? avatar;
  int? likes;
  int? star;
  List<CommentData> children;

  CommentData({
    required this.id,
    required this.username,
    required this.date,
    required this.content,
    this.avatar,
    this.likes = 0,
    this.star = 0,
    this.children = const <CommentData>[],
  });
}

class Comment extends StatelessWidget {

  final CommentData data;
  final double width;
  final VoidCallback? onLike;
  final VoidCallback? onStar;
  final VoidCallback? onReply;


  Comment({
    Key? key,
    required this.data,
    required this.width,
    this.onLike,
    this.onStar,
    this.onReply
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(size: AVATAR_WIDTH, url: data.avatar,),
        Container(
          width: width - AVATAR_WIDTH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.username, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(timeAgo(data.date), style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 8,),
                child: Text(data.content),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInteractionButton(Icons.favorite_border, data.likes, onLike),
                  _buildInteractionButton(Icons.star_border, data.star, onStar),
                  _buildInteractionButton(Icons.reply, null, onReply),
                ],
              ),
              SizedBox(height: 8),
              ...List.generate(data.children.length, (index) {
                return Comment(
                  data: data.children[index],
                  width: width - AVATAR_WIDTH,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionButton(IconData icon, int? count, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          if (count != null)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                count.toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}