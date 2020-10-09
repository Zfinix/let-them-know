import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class BillsViewModel extends ChangeNotifier {
  DocumentSnapshot querySnapshot;
  Stream<QuerySnapshot> negBillsFeeds =
      FirebaseFirestore.instance.collection('-billsDB').snapshots();
  final TextEditingController filter = new TextEditingController();

  var tags = [
    'Human Rights',
    'Power Oil & Gas',
    'Agriculture',
    'Education',
    'Health',
    'Finance',
    'Transport',
    'Security'
  ];

  String _searchText = "";
  String get searchText => _searchText;

  Icon _searchIcon = Icon(FluentIcons.search_24_regular);
  Icon get searchIcon => _searchIcon;

  Widget _appBarTitle;
  Widget get appBarTitle => _appBarTitle;

  set searchIcon(Icon val) {
    _searchIcon = val;
    notifyListeners();
  }

  set appBarTitle(Widget val) {
    _appBarTitle = val;
    notifyListeners();
  }

  set searchText(String val) {
    _searchText = val;
    notifyListeners();
  }

  onTagSelect(tag) {
    filter.text = tag;
    notifyListeners();
  }

  loadData(context) async {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

    try {
      filter.addListener(() {
        if (filter.text.isEmpty) {
          _searchText = "";
          notifyListeners();
        } else {
          _searchText = filter.text;
          notifyListeners();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
