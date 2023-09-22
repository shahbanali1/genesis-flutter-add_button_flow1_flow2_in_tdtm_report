import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/constant.dart';
import 'package:management_app/constants/string.dart';
import 'package:management_app/models/screen_list_item.dart';
import 'package:management_app/ui/widgets/grid_view_item_list.dart';

import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/context_util.dart';
import 'package:management_app/utils/router_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ScreenListItem> listItem = getListItem;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String mobileNo = "";
  @override
  void initState() {
    super.initState();
    ApplicationContext.setContext(context);
    getMobileNo();
  }

  void getMobileNo() async {
    final SharedPreferences prefs = await _prefs;
    mobileNo = prefs.getString("mobileNumber")!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  CommonUtils().confirmationDialogYesNo(
                      context, "Are you sure you want to logout?", () {
                    CommonUtils().clearUserDateAndLogout(context);
                  }, null);
                }),
          ],
        ),
        body: const Center(
          child: GridItemListView(),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              createHeader(mobileNo),
              Expanded(
                child: ListView.builder(
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          ImageIcon(
                            listItem[index].imageIcon,
                            size: 24.0,
                            color: AppColors.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              listItem[index].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        RouterUtil.updateUI(
                          listItem[index].routeName,
                          context,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createHeader(String mobileNo) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Center(child: Image.asset("assets/logo_small.png")),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    mobileNo,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
