import 'dart:io';
import 'package:call_them_app/core/models/senate_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SenateViewModel extends ChangeNotifier {
  final fbInstance = FirebaseFirestore.instance;
  DocumentSnapshot querySnapshot;
  Stream<QuerySnapshot> get homeFeeds =>
      fbInstance.collection('senatorsDB').snapshots();
  final TextEditingController filter = new TextEditingController();
  final TextEditingController mailTitle = new TextEditingController();
  final TextEditingController mailBody = new TextEditingController();

  String _searchText = "";
  String get searchText => _searchText;

  List<SenatorData> _names = [];
  List<SenatorData> get names => _names;

  Icon _searchIcon = new Icon(FluentIcons.search_24_regular);
  Icon get searchIcon => _searchIcon;

  Widget _appBarTitle;
  Widget get appBarTitle => _appBarTitle;

  set names(List<SenatorData> val) {
    _names = val;
    notifyListeners();
  }

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

  void searchPressed() {
    if (this.searchIcon.icon == FluentIcons.search_24_regular) {
      this.searchIcon = new Icon(Icons.close);
    } else {
      this.searchIcon = new Icon(FluentIcons.search_24_regular);
      this.appBarTitle = null;
      filter.clear();
    }
  }

  loadData(context) async {
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

      try {
        QuerySnapshot t = await fbInstance.collection('senatorsDB').get();
        if (t != null && t.docs != null) {
          t.docs.forEach((f) {
            SenatorData data = SenatorData.fromMap(f.data());
            names.add(data);
           searchPressed();
          });
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  launchMail(String data) async {
    var url = Uri.encodeFull(
        'mailto:$data?subject=${mailTitle.text}&body=${mailBody.text}');

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchCall(String number) async {
    try {
      var url;

      if (Platform.isAndroid) {
        //FOR Android
        if (await canLaunch('tel:' '$number')) {
          await launch('tel: ' '$number');
        } else {
          throw 'Could not launch tel:$number';
        }
      } else if (Platform.isIOS) {
        //FOR IOS
        url = Uri.encodeFull('tel:$number');

        await launch(url);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  launchSMS(String phone) async {
    var url;
    if (Platform.isAndroid) {
      //FOR Android
      url = 'sms:$phone?body=${mailBody.text}';
      await launch(url);
    } else if (Platform.isIOS) {
      //FOR IOS
      url = Uri.encodeFull('sms:$phone&body=${mailBody.text}');

      await launch(url);
    }
  }
}
