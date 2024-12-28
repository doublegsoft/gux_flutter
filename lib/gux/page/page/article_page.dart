import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:gux/design/avatar.dart';
import 'package:gux/design/buttons.dart';
import 'package:gux/design/comment.dart';
import 'package:gux/design/typograph.dart';
import 'package:gux/gux/page/widget/design_system_page.dart';

import 'package:gux/design/styles.dart' as styles;

class ArticlePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ArticlePageState();

}

class ArticlePageState extends State<ArticlePage> {

  String? _text;

  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTextAsset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 270,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image.asset(
                    "asset/image/page/forrest.png",
                    height: 270,
                    fit: BoxFit.cover,
                  ),
                ),
                leading: CloseIconButton(color: Colors.black,),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.ios_share, color: Colors.black),
                    onPressed: () {
                      showShareSheet(context);
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Headline1(
                                text: '如何深化足球改革的若干意见和建议以及青少年足球体系建设意见方针政策',
                                lines: 3,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Avatar(url: 'https://avatar.iran.liara.run/public/66', size: 24,),
                                  SizedBox(width: 8),
                                  Text('某某人', style: TextStyle(fontSize: 14, color: styles.colorTextSecondary),),
                                  SizedBox(width: 4),
                                  Text('2024-01-19', style: TextStyle(fontSize: 14, color: styles.colorTextSecondary),),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(_text??'', style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: styles.padding,),
                          child: Comment(
                            width: MediaQuery.of(context).size.width - styles.padding * 2,
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
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 88,),
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              color: Color(0xff000000).withOpacity(0.08),
              height: 88,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Avatar(size: 36, url: 'https://avatar.iran.liara.run/public/99'),
                  SizedBox(width: 8),
                  Expanded(child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 16, bottom: 13,
                              ),
                              hintText: '您也来说两句',
                              hintStyle: TextStyle(fontSize: 14, color: styles.colorTextPlaceholder,),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 14,),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.only(bottom: 1), // Symmetric
                          ),
                          child: Text('发送',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadTextAsset() async {
    try {
      final String text = await rootBundle.loadString('asset/data/article.html'); // File path is relative to the root
      setState(() {
        _text = text;
      });
    } catch (e) {
      setState(() {
        _text = 'Error loading file: $e';
      });
    }
  }
}