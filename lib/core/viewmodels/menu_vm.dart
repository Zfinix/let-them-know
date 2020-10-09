import 'package:call_them_app/views/directory/senate_directory.dart';
import 'package:call_them_app/views/pages/bills/bills_page.dart';
import 'package:call_them_app/views/pages/feedback_page.dart';
import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier {
  var _index = 0;
  get index => _index;
  set index(val) {
    _index = val;
    notifyListeners();
  }

  List<Widget> get menuList => [
        BillsPage(),
        SenateDirectory(),
        FeedbackPage(),
      ];
}
