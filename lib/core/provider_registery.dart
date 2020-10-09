import 'package:call_them_app/core/viewmodels/senate_vm.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'viewmodels/bills_vm.dart';
import 'viewmodels/feedback_vm.dart';
import 'viewmodels/menu_vm.dart';

var senateVM = ChangeNotifierProvider((_) => SenateViewModel());
var menuVM = ChangeNotifierProvider((_) => MenuViewModel());
var billsVM = ChangeNotifierProvider((_) => BillsViewModel());
var feedbackVM = ChangeNotifierProvider((_) => FeedbackViewModel());
