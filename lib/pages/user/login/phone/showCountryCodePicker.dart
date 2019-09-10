import 'package:flutter/cupertino.dart';
import 'dart:convert';

void showCountryCodePicker(BuildContext context, onChange) {
  var val = 0;
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('assets/config/countries.json'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: Container(width: 16, height: 16, child: CupertinoActivityIndicator()));
            if (snapshot.hasError) return Text('error');

            var countries = json.decode(snapshot.data.toString());

            List<Widget> list = [];

            for (var i in countries) {
              list.add(Text(
                i['name'] + ' ' + i['code'],
                style: TextStyle(fontSize: 20, height: 1.5),
              ));
            }

            return Container(
              child: Column(
                children: <Widget>[
                  // Padding(padding: EdgeInsets.only(top: 8)),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, 1);
                          },
                          child: Container(
                            color: CupertinoColors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            child: Text(
                              '取消',
                              style: TextStyle(fontSize: 20, color: CupertinoColors.inactiveGray),
                            ),
                          ),
                        ),
                        Text(''),
                        GestureDetector(
                          onTap: () {
                            final value = countries[val]['code'];
                            onChange(value);
                            Navigator.pop(context, 1);
                          },
                          child: Container(
                            color: CupertinoColors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            child: Text(
                              '确认',
                              style: TextStyle(fontSize: 20, color: CupertinoTheme.of(context).primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 245,
                    child: CupertinoPicker(
                      itemExtent: 40,
                      // backgroundColor:CupertinoColors.white,
                      onSelectedItemChanged: (position) {
                        print('The position is $position');
                        val = position;
                      },
                      children: list,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
