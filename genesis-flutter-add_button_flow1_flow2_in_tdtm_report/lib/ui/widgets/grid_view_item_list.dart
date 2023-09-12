import 'package:flutter/material.dart';
import 'package:management_app/constants/constant.dart';
import 'package:management_app/models/screen_list_item.dart';

import 'image_witht_text_card_view.dart';

class GridItemListView extends StatefulWidget {
  const GridItemListView({Key? key}) : super(key: key);
  @override
  _GridItemListViewState createState() => _GridItemListViewState();
}

class _GridItemListViewState extends State<GridItemListView> {
  final List<ScreenListItem> listItem = getListItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: Constant.gridRowCount,
        children: List.generate(listItem.length, (index) {
          return Center(
            child: ImageWithTextCardView(listItem: listItem[index]),
          );
        }),
      ),
    );
  }
}
