import 'package:call_them_app/core/provider_registery.dart';
import 'package:call_them_app/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class FeedbackPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var provider = useProvider(feedbackVM);
    return Container(
      height: screenHeight(context) - 100,
      child: Form(
        key: provider.formKey,
        child: Column(
          children: <Widget>[
            const YMargin(30),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: new TextFormField(
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Name is Invalid";
                  }
                },
                controller: provider.name,
                onEditingComplete: () {},
                decoration: new InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Name or Email'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                // height: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4)),
                child: new TextFormField(
                  validator: (value) {
                    if (value.isNotEmpty) {
                      return null;
                    } else if (value.isEmpty) {
                      return "This field can't be left empty";
                    } else {
                      return "Body is Invalid";
                    }
                  },
                  controller: provider.feedback,
                  maxLines: 200,
                  decoration: new InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                     border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 14),
                      hintText: 'Your Feedback'),
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: OutlineButton(
                        textColor: Colors.greenAccent[700],
                        child: Text('Send Us Your Feedback'),
                        onPressed: () {
                          if (provider.formKey.currentState.validate()) {
                            provider.sendFeedback(context);
                          }
                        },
                      ),
                    ),
                    const YMargin(50)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
