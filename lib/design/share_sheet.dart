import 'package:flutter/material.dart';
import 'buttons.dart';
import 'styles.dart' as styles;

class ShareSheet extends StatelessWidget {

  VoidCallback? onCancel;

  ShareSheet({
    Key? key,
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
          height: 200,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: styles.colorDivider,
                ),
                const SizedBox(height: 32),
                _buildShareOptions(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CloseIconButton(),
        Spacer(),
        Align(
          alignment: Alignment.center,
          child: const Text('分享至', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,)),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildShareOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildShareOption(
          image: Image.asset('asset/icon/wechat.png',
            width: 48,
            height: 48,
          ),
          text: '微信',
        ),
        _buildShareOption(
          image: Image.asset('asset/icon/moment.png',
            width: 48,
            height: 48,
          ),
          text: '朋友圈',
        ),
        _buildShareOption(
          image: Image.asset('asset/icon/photos.png',
            width: 48,
            height: 48,
          ),
          text: '相册',
        ),
      ],
    );
  }

  Widget _buildShareOption({required Image image, required String text}) {
    return Column(
      children: [
        image,
        // const SizedBox(height: 8),
        // Text(text),
      ],
    );
  }

  Widget _buildActionItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Icon(icon, color: Colors.black,),
        ],
      ),
    );
  }
}