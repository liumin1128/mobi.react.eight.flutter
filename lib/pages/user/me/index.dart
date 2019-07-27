import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserMe extends StatefulWidget {
  UserMe({ Key key, this.title }) : super(key: key);
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
            largeTitle: Text('xxxxxx'),
            border: Border(
              top: BorderSide(
                style: BorderStyle.none,
              ),
            )
          ),

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
                    )
                  )
                )
              )
            ),
          )
              
        ],
      )

        
 
    );
  }
}


