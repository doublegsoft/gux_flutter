
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  @override
  TextInputState createState() =>
      TextInputState();
}

class TextInputState extends State<TextInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Stack(
          children: [
            Positioned(
              bottom: keyboardHeight,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      //send message
                      print(_controller.text);
                    },
                        icon: Icon(Icons.send)
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}