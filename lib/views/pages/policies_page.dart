import 'package:call_them_app/core/provider_registery.dart';
import 'package:call_them_app/utils/margin.dart';
import 'package:call_them_app/widgets/category_types_widget.dart';
import 'package:call_them_app/widgets/neg_bill_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PoliciesPage extends StatefulHookWidget {
  @override
  _PoliciesPageState createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  @override
  Widget build(BuildContext context) {
    var provider = useProvider(billsVM);
    return Container(
      height: screenHeight(context) - 100,
      child: Column(
        children: <Widget>[
          const YMargin(50),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -12,
                  offset: Offset(0, 10),
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 25,
                ),
              ],
            ),
            child: new TextField(
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: new Icon(FluentIcons.search_24_regular),
                  hintText: 'Search for a bill...'),
            ),
          ),
          const YMargin(40),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  for (var tag in provider.tags) CategoryTypes(tag: tag),
                ],
              ),
            ),
          ),
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

class BuildFeedList extends StatelessWidget {
  final List<DocumentSnapshot> snapshot;
  const BuildFeedList(this.snapshot);

  @override
  Widget build(BuildContext context) => snapshot.length > 0
      ? Column(children: [
          for (var data in snapshot.reversed.toList())
            NegBillsWidget(data: data)
        ])
      : Center(
          child: Column(
            children: <Widget>[
              const YMargin(60),
              Opacity(
                opacity: 0.5,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
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
