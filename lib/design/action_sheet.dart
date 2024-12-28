import 'package:flutter/material.dart';

import 'styles.dart' as styles;

class ActionData {

  final String text;

  final VoidCallback callback;

  Color? color;

  ActionData({
    required this.text,
    required this.callback,
    this.color,
  }) {
    if (this.color == null) {
      this.color = styles.colorPrimary;
    }
  }
}

class ActionSheet extends StatelessWidget {

  final List<ActionData> actions;

  VoidCallback? onCancel;

  ActionSheet({
    Key? key,
    this.actions = const <ActionData>[],
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(actions.length, (index) => Column(
                children: [
                  if (index > 0)const Divider(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => actions[index].callback(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(actions[index].text,
                          style: TextStyle(
                            color: actions[index].color!,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
              // Cancel button
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onCancel == null ? () {
                    Navigator.pop(context);
                  } : onCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text('取消',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32,),
            ],
          ),
        );
      },
    );
  }
}