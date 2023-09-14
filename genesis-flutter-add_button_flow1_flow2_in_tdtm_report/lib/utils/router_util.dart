import 'package:flutter/material.dart';
import 'package:management_app/constants/constant.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/ui/screens/report_screen.dart';
import 'package:management_app/ui/widgets/grid_view_item_list.dart';

class RouterUtil {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constant.mainRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const GridItemListView(),
        );

      case Constant.verifierRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ReportScreen(reportToOpen: Screens.verifier));

      case Constant.inboundRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ReportScreen(reportToOpen: Screens.inbound));

      case Constant.hotspotRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ReportScreen(reportToOpen: Screens.hotspot));

      case Constant.agentPickupRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.agentPickup));

      case Constant.leadWiseRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.leadWiseCon));

      case Constant.performanceRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.performance));

      case Constant.corporateRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.corporate));

      case Constant.rmCollectionRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.rmCollection));

      case Constant.tdtmRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.tdtmChart));

      case Constant.govtLabRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ReportScreen(reportToOpen: Screens.govtLab));

      case Constant.hotspotZoneWise:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.hotspotZoneWise));

      case Constant.inboundTodayStatus:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.inboundTodayStatus));

      case Constant.routeTracking:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.routeTracking));

      case Constant.tdtmAdminRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.tdtmAdmin));

      case Constant.teamWiseRevenueRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                const ReportScreen(reportToOpen: Screens.teamWiseRevenue));

      case Constant.phleboAttendancePickupRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ReportScreen(
                reportToOpen: Screens.phleboAttendancePickup));

      case Constant.phleboAttendanceReportRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ReportScreen(
                reportToOpen: Screens.phleboAttendanceReport));

      // case Constant.logoutRoute:
      //   return MaterialPageRoute(
      //       settings: settings,
      //       builder: (ctx) {
      //         return const LoginScreen();
      //       });

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static updateUI(data, context) {
    switch (data) {
      case Constant.verifierRoute:
        return Navigator.pushNamed(context, Constant.verifierRoute);
      case Constant.inboundRoute:
        return Navigator.pushNamed(context, Constant.inboundRoute);
      case Constant.hotspotRoute:
        return Navigator.pushNamed(context, Constant.hotspotRoute);
      case Constant.agentPickupRoute:
        return Navigator.pushNamed(context, Constant.agentPickupRoute);
      case Constant.leadWiseRoute:
        return Navigator.pushNamed(context, Constant.leadWiseRoute);
      case Constant.performanceRoute:
        return Navigator.pushNamed(context, Constant.performanceRoute);
      case Constant.corporateRoute:
        return Navigator.pushNamed(context, Constant.corporateRoute);
      case Constant.rmCollectionRoute:
        return Navigator.pushNamed(context, Constant.rmCollectionRoute);
      case Constant.tdtmRoute:
        return Navigator.pushNamed(context, Constant.tdtmRoute);
      case Constant.govtLabRoute:
        return Navigator.pushNamed(context, Constant.govtLabRoute);
      case Constant.hotspotZoneWise:
        return Navigator.pushNamed(context, Constant.hotspotZoneWise);
      case Constant.inboundTodayStatus:
        return Navigator.pushNamed(context, Constant.inboundTodayStatus);
      case Constant.routeTracking:
        return Navigator.pushNamed(context, Constant.routeTracking);
      case Constant.tdtmAdminRoute:
        return Navigator.pushNamed(context, Constant.tdtmAdminRoute);
      case Constant.teamWiseRevenueRoute:
        return Navigator.pushNamed(context, Constant.teamWiseRevenueRoute);
      case Constant.phleboAttendancePickupRoute:
        return Navigator.pushNamed(
            context, Constant.phleboAttendancePickupRoute);
      case Constant.phleboAttendanceReportRoute:
        return Navigator.pushNamed(
            context, Constant.phleboAttendanceReportRoute);
      // case Constant.logoutRoute:
      //   Navigator.pop(context);
      //   return Navigator.popAndPushNamed(context, Constant.logoutRoute);
    }

    // Navigator.pushNamed(context, data);
  }
}
