import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/screen_list_item.dart';
import 'package:management_app/utils/router_util.dart';

class ImageWithTextCardView extends StatelessWidget {
  const ImageWithTextCardView({Key? key, required this.listItem})
      : super(key: key);
  final ScreenListItem listItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          RouterUtil.updateUI(listItem.routeName, context);
        },
        splashColor: Colors.blue.withAlpha(30),
        child: Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0)),
            color: Colors.white,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // ImageIcon(AssetImage(listItem.imageIcon), size: 40.0, color: Colors.orange),
                    // const SizedBox(
                    //   height: 5.0,
                    // ),
                    ImageIcon(
                      listItem.imageIcon,
                      size: 40.0,
                      color: AppColors.primaryColor,
                    ),
                    //Icon(listItem.imageIcon,size: 40.0, color: Colors.orange,),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3.0, right: 3.0, top: 8),
                      child: Text(
                        listItem.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15.0),
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
