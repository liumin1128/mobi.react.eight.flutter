import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reactmobi/pages/user/login.dart';

class UserMe extends StatefulWidget {
  UserMe({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UserMeState createState() => _UserMeState();
}

class _UserMeState extends State<UserMe> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      physics: ScrollPhysics(),
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
            largeTitle: Text('我的'),
            border: Border(
              top: BorderSide(
                style: BorderStyle.none,
              ),
            )),
        SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColorLight),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    child: Container(
                        child: CupertinoButton(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            // color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => CupertinoPageScaffold(
                                    navigationBar: CupertinoNavigationBar(
                                      border: Border(
                                        top: BorderSide(
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      // backgroundColor: Colors.white,
                                      middle: Text(
                                        '登录',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    child: UserLogin(),
                                  ),
                                ),
                              );
                            },
                            child: Text('立即登录')))))),
        SliverSafeArea(
          // top: true,
          bottom: true,
          sliver: SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  // child: Text('loading more...', textAlign: TextAlign.center)
                  child: Center(
                      child: Container(
                          width: 16,
                          height: 16,
                          child: CupertinoActivityIndicator(
                              // strokeWidth: 2,
                              ))))),
        )
      ],
    ));
  }
}
