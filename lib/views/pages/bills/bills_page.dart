import 'package:cached_network_image/cached_network_image.dart';
import 'package:call_them_app/core/provider_registry.dart';
import 'package:call_them_app/utils/margin.dart';
import 'package:call_them_app/widgets/neg_bill_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BillsPage extends StatefulHookWidget {
  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  loadData() async {
    context.read(billsVM).loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(billsVM);
    return Container(
      height: screenHeight(context) - 100,
      child: Column(
        children: <Widget>[
          const YMargin(20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -12,
                  offset: Offset(0, 10),
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 25,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: new TextField(
              controller: provider.filter,
              style: TextStyle(color: Colors.grey),
              decoration: new InputDecoration(
                border: InputBorder.none,
                prefixIcon: new Icon(FluentIcons.search_24_regular),
                hintText: 'Search for a bill...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
          const YMargin(30),
          /* Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              children: <Widget>[
                for (var tag in provider.tags) CategoryTypes(tag: tag),
              ],
            ),
          ), */
          Expanded(
            child: BuildUI(),
          ),
        ],
      ),
    );
  }
}

class BuildUI extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var provider = useProvider(billsVM);
    return StreamBuilder<QuerySnapshot>(
      stream: provider.negBillsFeeds,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Container(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            ),
          );
        return BuildFeedList(snapshot.data.docs);
      },
    );
  }
}

class BuildFeedList extends HookWidget {
  final List<DocumentSnapshot> snapshot;

  const BuildFeedList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(billsVM);
    return snapshot.length > 0
        ? Column(children: [
            for (var data in snapshot.reversed.toList())
              if (provider.filter.text.isNotEmpty)
                if (data
                        .data()['title']
                        .toLowerCase()
                        .contains(provider.searchText.toLowerCase()) ||
                    data
                        .data()['desc']
                        .toLowerCase()
                        .contains(provider.searchText.toLowerCase()) ||
                    data
                        .data()['category']
                        .toLowerCase()
                        .contains(provider.searchText.toLowerCase()))
                  NegBillsWidget(data: data)
                else
                  Container()
              else
                NegBillsWidget(data: data)
          ])
        : Center(
            child: Column(
              children: <Widget>[
                const YMargin(30),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                'https://media.istockphoto.com/vectors/open-box-icon-vector-id635771440?k=6&m=635771440&s=612x612&w=0&h=IESJM8lpvGjMO_crsjqErVWzdI8sLnlf0dljbkeO7Ig=',
                                scale: 3))),
                  ),
                ),
                const YMargin(20),
                Text('No Posts'),
              ],
            ),
          );
  }
}
