import 'package:call_them_app/core/provider_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'spring_button.dart';

class CategoryTypes extends HookWidget {
  final String tag;
  const CategoryTypes({
    Key key,
    @required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(billsVM);
    return SpringButton(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: <Widget>[
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.greenAccent[700],
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Text(
                    tag != null ? tag : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // print(tag);
        provider.onTagSelect(tag);
      },
    );
  }
}
