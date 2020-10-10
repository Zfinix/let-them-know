import 'package:call_them_app/core/models/neg_bills_model.dart';
import 'package:call_them_app/core/provider_registry.dart';
import 'package:call_them_app/core/viewmodels/senate_vm.dart';
import 'package:call_them_app/utils/margin.dart';
import 'package:call_them_app/views/email_sender.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:flutter/cupertino.dart';

class SenateDirectory extends StatefulHookWidget {
  final NegativeBills negativeBills;
  final scrollController;
  SenateDirectory([this.negativeBills, this.scrollController]);

  @override
  _SenateDirectoryState createState() => _SenateDirectoryState();
}

class _SenateDirectoryState extends State<SenateDirectory> {
  SenateViewModel get vm => context.read(senateVM);
  @override
  void initState() {
    loadData();

    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 1));
    vm.loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    var filter = useProvider(senateVM.select((v) => v.filter));
    var searchPressed = useProvider(senateVM.select((v) => v.searchPressed));
    var searchIcon = useProvider(senateVM.select((v) => v.searchIcon));
    var names = useProvider(senateVM.select((v) => v.names));
    var searchText = useProvider(senateVM.select((v) => v.searchText));
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        controller: widget?.scrollController,
        children: <Widget>[
          const YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Search by Senator name / District\nSend text message via the app ASAP',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.7,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const YMargin(20),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -9,
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 25,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: new TextField(
              controller: filter,
              autofocus: false,
              onTap: searchPressed,
              decoration: new InputDecoration(
                border: InputBorder.none,
                prefixIcon: searchIcon == Icon(FluentIcons.search_24_regular)
                    ? searchIcon
                    : null,
                suffixIcon: searchIcon == Icon(FluentIcons.search_24_regular)
                    ? null
                    : searchIcon,
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
          const YMargin(20),
          if (names.length > 0 || filter.text.isNotEmpty)
            for (var i = 0; i < names?.length ?? 0; i++)
              if (filter.text.isNotEmpty)
                if (names[i]
                        .name
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ||
                    names[i]
                        .state
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 18),
                    child: Container(
                      padding: const EdgeInsets.all(18.0),
                      decoration: BoxDecoration(
                       color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: -10,
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 25,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(9)),
                      child: ListTile(
                        title: Text(names[i].name ?? ''),
                        subtitle: Text(names[i].state.toUpperCase() ?? ''),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: <Widget>[
                              names[i].phoneNo != null
                                  ? IconButton(
                                      icon: Icon(FluentIcons.phone_24_regular),
                                      color: Colors.red,
                                      onPressed: () async {
                                        await vm.launchCall(names[i].phoneNo);
                                      },
                                    )
                                  : Container(),
                              new IconButton(
                                icon: Icon(FluentIcons.mail_24_regular),
                                color: Colors.green,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CustomPageRoute(
                                      EmailSender(
                                          senatorData: names[i],
                                          negativeBills: widget?.negativeBills),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Container()
              else
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 18),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: -10,
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 25,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(9)),
                    child: ListTile(
                      title: Text(
                        names[i].name ?? '',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        names[i].state.toUpperCase() ?? '',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: <Widget>[
                            names[i].phoneNo != null
                                ? IconButton(
                                    icon: Icon(FluentIcons.phone_24_regular),
                                    color: Colors.black.withOpacity(0.6),
                                    onPressed: () async {
                                      await vm.launchCall(names[i].phoneNo);
                                    },
                                  )
                                : Container(),
                            IconButton(
                              icon: Icon(FluentIcons.mail_24_regular),
                              color: Colors.black.withOpacity(0.6),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    EmailSender(
                                        senatorData: names[i],
                                        negativeBills: widget?.negativeBills),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
          else
            Center(
              child: Container(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                ),
              ),
            )
        ],
      ),
    );
  }
}
