import 'package:cached_network_image/cached_network_image.dart';
import 'package:call_them_app/core/models/neg_bills_model.dart';
import 'package:call_them_app/utils/margin.dart';
import 'package:call_them_app/views/directory/senate_directory.dart';
import 'package:call_them_app/widgets/spring_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class BillsDetailPage extends StatefulHookWidget {
  final NegativeBills negativeBills;
  BillsDetailPage({Key key, this.negativeBills}) : super(key: key);

  @override
  _BillsDetailPageState createState() => _BillsDetailPageState();
}

class _BillsDetailPageState extends State<BillsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth(context),
            height: screenHeight(context, percent: 0.4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      widget?.negativeBills?.imageUrl ?? '')),
            ),
          ),
          Container(
            width: screenWidth(context),
            height: screenHeight(context, percent: 0.4),
            decoration: BoxDecoration(color: Colors.black26),
          ),
          ListView(
            children: <Widget>[
              YMargin(screenHeight(context, percent: 0.17)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: screenWidth(context),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: -7,
                          offset: Offset(0, 10),
                          color: Colors.grey.withOpacity(0.25),
                          blurRadius: 35,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(18),
                          title: Text(
                            widget?.negativeBills?.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget?.negativeBills?.category ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.greenAccent[700],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                                const YMargin(20),
                                Text(
                                  widget?.negativeBills?.desc ?? '',
                                  style: TextStyle(
                                      height: 1.4,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    const YMargin(30),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        color: Colors.greenAccent[700],
                        textColor: Colors.white,
                        child: Text('Contact Your Senators'),
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            isDismissible: true,
                            builder: (context, scrollController) =>
                                SenateDirectory(widget.negativeBills, scrollController),
                          );
                        },
                      ),
                    ),
                    const YMargin(30),
                    Text(
                      "Sign the Petition!",
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    const YMargin(20),
                    Container(
                        width: double.infinity,
                        height: 50,
                        child: OutlineButton(
                          color: Colors.greenAccent[700],
                          textColor: Colors.greenAccent[700],
                          child: SpringButton(
                            child: Image.asset(
                              'assets/change.png',
                              scale: 3,
                            ),
                            onTap: () async {
                              var url = Uri.encodeFull(
                                  widget.negativeBills.changeUrl);

                              await launch(url);
                            },
                          ),
                          onPressed: null,
                        )),
                    const YMargin(50)
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Row(
              children: <Widget>[
                XMargin(10),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                IconButton(
                  icon: Icon(FluentIcons.share_android_20_regular),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
