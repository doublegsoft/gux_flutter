import 'package:flutter/material.dart';

class FreePage extends StatefulWidget {
  const FreePage({Key? key}) : super(key: key);

  @override
  State<FreePage> createState() => _FreePageState();
}

class _FreePageState extends State<FreePage> {
  final TextEditingController _controller = TextEditingController();

  bool _visible = false;

  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Input Above Keyboard")),
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            _visible = !_visible;
            if (_visible) {
              _focusNode.requestFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          });
        },
        child: Icon(Icons.remove_red_eye_outlined, size: 48),
      ),
      body: Column(
        children: <Widget>[
          Expanded( // Takes up all available space above the input area
            child: Container(
              color: Colors.grey[200], // Optional background color),
            ),
          ),
          if (_visible) Padding(  // Add some padding around the input box
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter text here...',
                border: OutlineInputBorder(),
              ),
            ),

          ),

        ],

      ),

    );


  }
}