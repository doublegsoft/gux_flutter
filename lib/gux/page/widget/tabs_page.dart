import 'package:flutter/material.dart';
import '../../../design/Tag.dart';
import '../../../design/avatars.dart';
import '/design/avatar.dart';
import '/widget/gx_tab_item.dart';

import '../../../design/styles.dart' as styles;

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '页签导航',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.green.shade100,
                    ),
                    child: const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black54,
                      tabs: [
                        GXTabItem(title: '自定义瓦片', count: 6),
                        GXTabItem(title: '瓦片对象', count: 3),
                        GXTabItem(title: 'Deleted', count: 1),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: TabBarView(
                  children: [
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            styles.buildTile(context,
                              imagePath: 'asset/image/widget-circle.png',
                              title: '页签导航',
                              subtitle: '页签导航是局部切换页面内容的常用组件。',
                              description: '2024-09-15 重庆',
                              accent: Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Avatar(name: '王萌萌', color: Colors.blueGrey,),
                              ),
                              numbers: [Tag(text: '123'), Tag(text: '234'), Tag(text: '345')],
                            ),
                            styles.buildTile(context,
                              imagePath: 'asset/image/widget-circle.png',
                              title: '页签导航',
                              subtitle: '页签导航是局部切换页面内容的常用组件。',
                              description: '2024-09-15 重庆',
                              numbers: [],
                              accent: Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Badge(child: Avatar(),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            styles.buildTile(context,
                              imagePath: 'asset/image/widget-circle.png',
                              imageWidth: 64,
                              imageHeight: 64,
                              title: '页签导航',
                              subtitle: '页签导航是局部切换页面内容的常用组件。',
                              description: '2024-09-15 重庆',
                            ),
                            styles.buildTile(context,
                              imagePath: 'asset/image/widget-circle.png',
                              imageWidth: 64,
                              imageHeight: 64,
                              title: '页签导航',
                              subtitle: '页签导航是局部切换页面内容的常用组件。',
                              description: '2024-09-15 重庆',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(child: Text('Deleted Page')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}