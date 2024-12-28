
import 'package:flutter/material.dart';

// 全局的 RouteObserver 实例
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

mixin GXPageVisibilityMixin<T extends StatefulWidget> on State<T>
implements RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // 默认实现，页面被推入堆栈时调用，触发页面可见逻辑
  @override
  void didPush() {
    onPageVisible();
  }

  // 默认实现，页面被弹出时调用，触发页面不可见逻辑
  @override
  void didPop() {
    onPageInvisible();
  }

  // 默认实现，下一个页面被弹出时调用，当前页面重新变为可见
  @override
  void didPopNext() {
    onPageVisible();
  }

  // 默认实现，下一个页面被推入时调用，当前页面变为不可见
  @override
  void didPushNext() {
    onPageInvisible();
  }

  // 页面可见时触发的钩子方法，子类可重写
  void onPageVisible() {
    // 默认不做任何操作，子类可实现
  }

  // 页面不可见时触发的钩子方法，子类可重写
  void onPageInvisible() {
    // 默认不做任何操作，子类可实现
  }
}
