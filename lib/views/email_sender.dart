import 'package:call_them_app/core/models/neg_bills_model.dart';
import 'package:call_them_app/core/models/senate_list_model.dart';
import 'package:call_them_app/core/provider_registry.dart';

import 'package:call_them_app/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class EmailSender extends HookWidget {
  final SenatorData senatorData;
  final NegativeBills negativeBills;
  EmailSender({
    Key key,
    @required this.senatorData,
    @required this.negativeBills,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mailTitle = useProvider(senateVM.select((v) => v.mailTitle));
    var mailBody = useProvider(senateVM.select((v) => v.mailBody));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${senatorData?.name ?? ''}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const YMargin(10),
                  Text(
                    senatorData?.state ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
                      height: 1.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.06),
                  borderRadius: BorderRadius.circular(4)),
              child: new TextFormField(
                initialValue: negativeBills?.title ?? null,
                validator: (value) {
                  if (value.isNotEmpty) {
                    mailTitle.text = value;

                    return null;
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Title is Invalid";
                  }
                },
                onEditingComplete: () {},
                decoration: new InputDecoration(
                    border: InputBorder.none, hintText: 'Subject of Mail'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.06),
                  borderRadius: BorderRadius.circular(4)),
              child: new TextFormField(
                initialValue: '''${negativeBills?.emailMessage?.replaceAll('\n', '\p') ?? ''}''',
                validator: (value) {
                  if (value.isNotEmpty) {
                    mailBody.text = value;

                    return null;
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Body is Invalid";
                  }
                },
                //controller: mailTitle,
                maxLines: null,
                decoration: new InputDecoration(
                    border: InputBorder.none, hintText: 'Subject of Mail'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      color: Colors.greenAccent[700],
                      textColor: Colors.white,
                      child: Text('Send ${senatorData.name} this mail'),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          if (senatorData.email != null)
                            context
                                .read(senateVM)
                                .launchMail(senatorData.email);
                        }
                      },
                    ),
                  ),
                  const YMargin(20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: OutlineButton(
                      color: Colors.greenAccent[700],
                      textColor: Colors.greenAccent[700],
                      child: Text('Send ${senatorData.name} this SMS'),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          if (senatorData.phoneNo != null)
                            context
                                .read(senateVM)
                                .launchSMS(senatorData.phoneNo);
                        }
                      },
                    ),
                  ),
                  const YMargin(50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
