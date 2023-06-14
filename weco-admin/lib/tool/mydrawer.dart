import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DrawerDirEnum { left, right }

/// Drawer 核心组件
class RDrawer extends StatefulWidget {
  /// drawer宽度
  final double width;

  /// 展开方向
  final DrawerDirEnum dir;

  /// 点击遮罩层是否允许关闭
  final bool? maskClose;

  /// drawer 内容，此处可在封装一个 DrawerBody 来定制自己的样式，更方便使用
  final Widget child;
  const RDrawer({
    super.key,
    required this.child,
    this.width = 536,
    this.dir = DrawerDirEnum.right,
    this.maskClose = false,
  });
  // 定义用于访问 state 对象的 key
  static final GlobalKey<DrawerState> drawerStateKey = GlobalKey<DrawerState>();

  /// 打开 drawer
  static open(
    Widget child, {
    DrawerDirEnum? dir = DrawerDirEnum.right,
    double? width = 536,
    bool? maskClose = false,
  }) {
    Navigator.of(Get.context!).push(
      // 具体参数含义上文已介绍过
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
        fullscreenDialog: true,
        pageBuilder: (_, __, ___) => RDrawer(
          // 很重要：绑定 globalKey 以是 DrawerState 能被外界访问到
          key: drawerStateKey,
          width: width!,
          dir: dir!,
          maskClose: maskClose!,
          child: child,
        ),
      ),
    );
  }

  /// 关闭 drawer
  static close() => drawerStateKey.currentState?.close();

  @override
  State<RDrawer> createState() => DrawerState();
}

/// Drawer 核心逻辑
class DrawerState extends State<RDrawer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: -widget.width, end: 0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    controller.forward();
  }

  /// 关闭 drawer
  void close() {
    // 待抽屉动画完成后在关闭页面
    controller.reverse().then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 为了实现 drawer 关闭动画不能直接借助 barrierDismissible  来控制点击遮罩层
        GestureDetector(onTap: () => widget.maskClose! ? close() : null),
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Positioned(
              top: 0,
              bottom: 0,
              right: widget.dir == DrawerDirEnum.right ? animation.value : null,
              left: widget.dir == DrawerDirEnum.left ? animation.value : null,
              child: SizedBox(width: widget.width, child: widget.child),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
