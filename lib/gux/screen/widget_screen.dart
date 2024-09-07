import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '/gux/page/common_page.dart';
import '/gux/page/grid_view_page.dart';
import '/gux/page/calendar_page.dart';
import '/gux/page/two_column_form_page.dart';

import '../sdk.dart' as sdk;

class WidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: sdk.fetchApplicationAdvertisements({}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 240.0,
                    viewportFraction: 1.0,
                    autoPlay: true,
                  ),
                  items: snapshot.data!.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 240,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(item['imagePath']),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
              return Container(
                height: 240,
              );
            },
          ),
          SizedBox(height: 8),
          FutureBuilder(
            future: sdk.fetchApplicationNotifications({}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        '\ue612',
                        style: TextStyle(
                          fontFamily: 'gx-iconfont',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Expanded(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          height: 20.0,
                          viewportFraction: 1.0,
                          autoPlay: true,
                        ),
                        items: snapshot.data!.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                height: 20,
                                padding: EdgeInsets.only(left: 8, right: 16),
                                child: Text(item["content"]),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }
              return Container(
                height: 20,
              );
            },
          ),
          buildCard4Widget(
            context: context,
            title: '编辑表单',
            description: '编辑表单提供用户输入信息的部件，存在单列式和两列式两种编辑表单展现形式。',
            imagePath: 'asset/image/widget/editable_form.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TwoColumnFormPage()),
              );
            },
          ),
          buildCard4Widget(
            context: context,
            title: '只读表单',
            description: '只读表单提供展现用户输入信息的部件，不可编辑，和编辑表单一样也存在单列式和两列式两种展现形式。',
            imagePath: 'asset/image/widget/readonly_form.png',
            onPressed: () {
            },
          ),
          buildCard4Widget(
            context: context,
            title: '传统列表',
            description: '传统列表以瓦片的形式单列竖式展示集合内容，是应用程序最为常用的集合内容展现部件。',
            imagePath: 'asset/image/widget/list_view.png',
            onPressed: () {

            },
          ),
          buildCard4Widget(
            context: context,
            title: '栅格列表',
            description: '栅格列表以卡片的形式双列竖式展示集合内容，是应用程序最为常用的集合内容展现部件。',
            imagePath: 'asset/image/widget/grid_view.png',
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GridViewPage()),
              );
            },
          ),
          buildCard4Widget(
            context: context,
            title: '日历导航',
            description: '日历导航是以日期为分类类别的选择部件，通过日期的选择来触发下方集合内容的改变。',
            imagePath: 'asset/image/widget/calendar.png',
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
          ),
          buildCard4Widget(
            context: context,
            title: '页签导航',
            description: '页签导航类似于滑动导航，区别在于单项的个数较少，不超过屏幕宽度，同时是需要支持内容页面的滑动切换功能。',
            imagePath: 'asset/image/widget/tabs.png',
            onPressed: () {

            },
          ),
          buildCard4Widget(
            context: context,
            title: '通用页面',
            description: '通用页面适用于各种应用程序，在能够满足不同应用程序的个性化需求情况下很少变动的页面。',
            imagePath: 'asset/image/widget/common_page.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommonPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildCard4Widget({
    required BuildContext context,
    required String title,
    required String description,
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '       ' + description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 42.0, // Set the width
                        height: 42.0, // Set the height
                        child: FittedBox(
                          fit: BoxFit.cover, // Adjust the fit as needed
                          child: Image.asset(imagePath),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onPressed,
                        child: Text('了解更多'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
