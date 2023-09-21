import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/screen_list_item.dart';
import 'package:management_app/utils/router_util.dart';

class NavigationDrawerListView extends StatefulWidget {
  const NavigationDrawerListView({Key? key}) : super(key: key);
  @override
  _NavigationDrawerListViewState createState() =>
      _NavigationDrawerListViewState();
}

class _NavigationDrawerListViewState extends State<NavigationDrawerListView> {
  final List<ScreenListItem> listItem = getListItem;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
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
                  child: Text(listItem[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              RouterUtil.updateUI(listItem[index].routeName, context);
            },
          );
        });
  }
}
