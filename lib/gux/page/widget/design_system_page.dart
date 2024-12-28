import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gux/design/Avatar.dart';
import 'package:gux/design/action_sheet.dart';
import 'package:gux/design/buttons.dart';
import 'package:gux/design/comment.dart';
import 'package:gux/design/input_field.dart';
import 'package:gux/design/mark.dart';
import 'package:gux/design/share_sheet.dart';
import 'package:gux/design/typograph.dart';
import 'package:gux/design/avatars.dart';
import 'package:gux/sdk/options.dart';

import 'package:gux/design/styles.dart' as styles;

import '../../../design/dialogs.dart';
import '../../../design/sparkbar.dart';
import '../../../design/sparkline.dart';
import '/design/Tag.dart';
import '/widget/gx_circular_progress.dart';
import 'package:gux/design/styles.dart' as styles;

const double PADDING = 16;

class DesignSystemPage extends StatefulWidget {
  @override
  DesignSystemPageState createState() => DesignSystemPageState();
}

class DesignSystemPageState extends State<DesignSystemPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff03091F),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                color: styles.colorTextInverse,
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, size: 22,),
              ),
              backgroundColor: const Color(0xff254bec),
              expandedHeight: 211 - 32,
              floating: false,
              pinned: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('asset/icon/calendar.png', width: 18, height: 18,),
                  SizedBox(width: 4,),
                  Text('2024年12月12日', style: TextStyle(fontSize: 13, color: styles.colorTextInverse,)),
                  SizedBox(width: 6,),
                  Image.asset('asset/icon/humidity.png', width: 18, height: 18,),
                  SizedBox(width: 4,),
                  Text('26%', style: TextStyle(fontSize: 13, color: styles.colorTextInverse,),),
                  SizedBox(width: 6,),
                  Image.asset('asset/icon/sun.png', width: 18, height: 18,),
                  SizedBox(width: 4,),
                  Text('32℃', style: TextStyle(fontSize: 13, color: styles.colorTextInverse,)),
                  Spacer(),
                  GestureDetector(
                    onTap: () => showActionSheet(context),
                    child: Avatar(size: 36, url: 'https://avatar.iran.liara.run/public/38'),
                  ),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                background: Image.asset('asset/image/page/hometech.png',
                  height: 211 - 32,
                  fit: BoxFit.cover,
                ),
                titlePadding: EdgeInsets.zero,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 80,
                          color: const Color(0xff254bec),
                        ),
                        Spacer(),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: styles.screenWidth,
                        color: Colors.transparent,
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildAppBarCard(asset: 'asset/icon/sun cloud angled rain.png', chart: GXCircularProgress(
                              progress: 48,
                              size: 48,
                              strokeWidth: 10,
                              progressColor: styles.colorError,
                              showPercentage: false,
                            ),),
                            _buildAppBarCard(asset: 'asset/icon/moon cloud mid rain.png', chart: SizedBox(
                              width: 48,
                              height: 48,
                              child: Sparkline(
                                data: [
                                  10, 20, 15, 25, 18, 30, 28, 35,
                                ], // Replace with your data
                                lineColor: Colors.blue,
                                lineWidth: 2.0,
                                fillColor: Colors.blue.withOpacity(0.3),
                              ),
                            ),),
                            _buildAppBarCard(asset: 'asset/icon/cloud 3 zap.png', chart: SizedBox(
                              width: 48,
                              height: 48,
                              child: Sparkbar(
                                data: [
                                  10, 20, 15, 25, 18, 30,
                                ],
                                barColors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple,],
                                barWidth: 8.0,
                                borderRadius: 5.0,
                              ),
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: PADDING,),
              _buildCard(
                title: '各级标题',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Headline5(text: '五级标题'),
                    SizedBox(height: 4),
                    Headline4(text: '四级标题'),
                    SizedBox(height: 4),
                    Headline3(text: '三级标题'),
                    SizedBox(height: 4),
                    Headline2(text: '二级标题'),
                    SizedBox(height: 4),
                    Headline1(text: '一级标题'),
                  ],
                ),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '按钮风格',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedButton(text: '主要操作', onPressed: (){}),
                    SizedBox(height: PADDING),
                    RoundedButton(
                      text: '危险操作',
                      backgroundColor: styles.colorError,
                      onPressed: () {},
                    ),
                    SizedBox(height: PADDING),
                    RoundedButton(
                      text: '确认操作',
                      backgroundColor: styles.colorSuccess,
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '标签',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Tag(text: '标签A'),
                    Tag(
                      text: '标签B',
                      backgroundColor: styles.colorSuccessLight,
                      foregroundColor: styles.colorSuccess,
                    ),
                    Tag(text: '标签C'),
                    Tag(text: '标签E', backgroundColor: styles.colorWarningLight, foregroundColor: styles.colorWarning,),
                    Tag(text: '标签F', backgroundColor: styles.colorSuccessLight, foregroundColor: styles.colorSuccess,),
                    Tag(text: '标签G', backgroundColor: styles.colorSuccessLight, foregroundColor: styles.colorSuccess,),
                    Tag(text: '标签H'),
                    Tag(text: '标签I', backgroundColor: styles.colorErrorLight, foregroundColor: styles.colorError,),
                    Tag(text: '标签J'),
                  ],
                ),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '单个头像',
                child: Avatar(url: 'https://avatar.iran.liara.run/public/job/teacher/male', size: 64),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '头像标记',
                child: Mark(
                  badgeText: '2',
                  child: Avatar(
                    url: 'https://avatar.iran.liara.run/public/job/chef/female',
                    size: 64,
                  ),
                ),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '多个头像',
                child: Avatars(
                  avatars: [
                    AvatarData(id: '18', url: 'https://avatar.iran.liara.run/public/18'),
                    AvatarData(id: '86', url: 'https://avatar.iran.liara.run/public/86'),
                    AvatarData(id: '32', url: 'https://avatar.iran.liara.run/public/32'),
                    AvatarData(id: '94', url: 'https://avatar.iran.liara.run/public/94'),
                    AvatarData(id: '61', url: 'https://avatar.iran.liara.run/public/61'),
                    AvatarData(id: '88', url: 'https://avatar.iran.liara.run/public/88'),
                  ],
                  size: 64,
                ),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '圆圈进度',
                child: Row(
                  children: [
                    GXCircularProgress(progress: 80, animate: true,),
                  ],
                ),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '评论列表',
                child: Comment(
                  width: MediaQuery.of(context).size.width - PADDING * 4,
                  data: CommentData(
                    username: '吴道道',
                    date: DateTime.now().subtract(Duration(hours: 5,)),
                    avatar: 'https://avatar.iran.liara.run/public/43',
                    content: '12月13日 财政部原副部长朱光耀称：贫困是产生恐怖主义的土在2024新金融大会现场，财政部原副部长朱光耀表示，当前联合国可持续发展目标的实施进展不容乐观，必须警惕贫困是产生恐怖主义的土壤，“如果不能解决全球的贫困问题，一些国家的社会动荡将冲击着整个国际和平发展的秩序。”',
                    id: '123',
                    children: [
                      CommentData(
                        username: '王道道',
                        date: DateTime.now().subtract(Duration(minutes: 3,)),
                        avatar: 'https://avatar.iran.liara.run/public/99',
                        content: '支持',
                        id: '321',
                      ),
                      CommentData(
                        username: '马道道',
                        date: DateTime.now(),
                        avatar: 'https://avatar.iran.liara.run/public/77',
                        content: '顶起来',
                        id: '322',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: PADDING,),
              _buildCard(
                title: '编辑表单',
                child: Container(
                  child: Column(
                    children: [
                      InputField(label: '姓名', nullable: false, length: 10,),
                      SizedBox(height: 10,),
                      InputField(label: '身份证号', length: 18, nullable: false,),
                      SizedBox(height: 10,),
                      InputField(label: '出生日期', type: InputFieldType.date, nullable: false,),
                      SizedBox(height: 10,),
                      InputField(label: '性别', type: InputFieldType.select, options: [
                        Option(text: '男孩', value: 'M'), Option(text: '女孩', value: 'F'),
                      ],),
                      SizedBox(height: 10,),
                      InputField(label: '闹钟时间', type: InputFieldType.time,),
                      SizedBox(height: 10,),
                      InputField(label: '热量', type: InputFieldType.ruler, unit: 'kcal', min: 60, max: 200,),
                      SizedBox(height: 10,),
                      RoundedButton(text: '保存', onPressed: () {}),
                    ],
                  ),
                ),
              ),
              SizedBox(height: PADDING,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: PADDING),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PADDING),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Headline4(text: title),
          SizedBox(height: PADDING),
          child,
        ],
      ),
    );
  }

  Widget _buildAppBarCard({String? asset, required Widget chart}) {
    return Container(
      width: 88,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xffDFE0E4),
            const Color(0xfffefefe),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 4,),
          Image.asset(asset!, width: 48, height: 48,),
          SizedBox(height: 8,),
          chart,
        ],
      ),
    );
  }
}

void showActionSheet(context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(  // Rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return ActionSheet(
        actions: [
          ActionData(text: '分享', callback: () {
            Navigator.pop(context);
            showShareSheet(context);
          }),
          ActionData(text: '保存', callback: () async {
            EasyLoading.show(
              status: '数据保存中....',
              maskType: EasyLoadingMaskType.clear,
            );
            await Future.delayed(Duration(seconds: 2),);
            EasyLoading.dismiss();
            Navigator.pop(context);
            error(
              context: context,
              title: '保存某某信息出错！',
              description: '已经存在某某信息，不允许重复创建！',
            );
          }),
          ActionData(text: '删除', color: styles.colorError, callback: () {
            confirm(
              context: context,
              title: '确定删除此条数据？',
              onConfirm: () async {
                EasyLoading.show(status: '删除中...');
                await Future.delayed(Duration(milliseconds: 500,));
                EasyLoading.dismiss();
                success(context: context, title: '删除成功，您永远也找求不到了！');
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            );
          }),
        ],
      );
    },
  );
}

void showShareSheet(context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(  // Rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return ShareSheet();
    },
  );
}