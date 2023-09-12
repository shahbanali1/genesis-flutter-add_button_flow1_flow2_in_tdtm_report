import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/constant.dart';
import 'package:management_app/constants/string.dart';
import 'package:management_app/ui/widgets/grid_view_item_list.dart';
import 'package:management_app/ui/widgets/navigation_drawer_listview.dart';
import 'package:management_app/utils/back_press_util.dart';
import 'package:management_app/utils/context_util.dart';
import 'package:management_app/utils/router_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ApplicationContext.setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: BackPressUtil.onBackPressed,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: GoogleFonts.kulimPark().fontFamily,
          textTheme: GoogleFonts.kulimParkTextTheme(),
        ),
        onGenerateRoute: RouterUtil.generateRoute,
        initialRoute: Constant.mainRoute,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: const Text(
              Strings.appName,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          body: const Center(
            child: GridItemListView(),
          ),
          drawer: Drawer(
              child: ListView(
            children: [createHeader(), const NavigationDrawerListView()],
          )),
        ),
      ),
    );
  }

  Widget createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: Image.asset("assets/logo_small.png"),
            ),
          ],
        ));
  }
}
