import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:weco_admin/direct/router.dart';
import 'package:weco_admin/punchin/router.dart';
import 'app.dart';
import 'home/router.dart';
import 'leave/leavesave/router.dart';
import 'leave/router.dart';
import 'punchout/router.dart';
import 'option/router.dart';
import 'repose/router.dart';
import 'resume/router.dart';

class XRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetPageRoute(
          settings: settings,
          transition: Transition.fade,
          page: () => AppView(settings.arguments),
        );
      case '/home':
        return HomeRouter().pageRoute(settings);
      case '/option':
        return OptionRouter().pageRoute(settings);
      case '/work':
        return WorkRouter().pageRoute(settings);
      case '/offwork':
        return OffWorkRouter().pageRoute(settings);
      case '/out':
        return OutRouter().pageRoute(settings);
      case '/overtime':
        return OvertimeRouter().pageRoute(settings);
      case '/result':
        return ResultRouter().pageRoute(settings);
      case '/leaveconfirmation':
        return LeaveConfirmationRouter().pageRoute(settings);
        case '/leavesave':
        return LeaveSaveRouter().pageRoute(settings);
        
      default:
        return XDKRouter.onGenerateRoute(settings);
    }
  }
}
