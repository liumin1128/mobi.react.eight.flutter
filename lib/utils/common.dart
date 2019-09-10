class RelativeDateFormat {
  static final num ONE_MINUTE = 60000;
  static final num ONE_HOUR = 3600000;
  static final num ONE_DAY = 86400000;
  static final num ONE_WEEK = 604800000;

  static final String ONE_SECOND_AGO = "秒前";
  static final String ONE_MINUTE_AGO = "分钟前";
  static final String ONE_HOUR_AGO = "小时前";
  static final String ONE_DAY_AGO = "天前";
  static final String ONE_MONTH_AGO = "月前";
  static final String ONE_YEAR_AGO = "年前";

  //时间转换
  static String format(DateTime date) {
    num delta = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (delta < 1 * ONE_MINUTE) {
      num seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + ONE_SECOND_AGO;
    }
    if (delta < 45 * ONE_MINUTE) {
      num minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + ONE_MINUTE_AGO;
    }
    if (delta < 24 * ONE_HOUR) {
      num hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toInt().toString() + ONE_HOUR_AGO;
    }
    if (delta < 48 * ONE_HOUR) {
      return "昨天";
    }
    if (delta < 30 * ONE_DAY) {
      num days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + ONE_DAY_AGO;
    }
    if (delta < 12 * 4 * ONE_WEEK) {
      num months = toMonths(delta);
      return (months <= 0 ? 1 : months).toInt().toString() + ONE_MONTH_AGO;
    } else {
      num years = toYears(delta);
      return (years <= 0 ? 1 : years).toInt().toString() + ONE_YEAR_AGO;
    }
  }

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }
}

getSmallImg(url, propsX, propsY) {
  var x = propsX == null ? 200 : propsX;
  var y = propsY == null ? 200 : propsY;
  return "${url}?imageMogr2/thumbnail/!${x}x${y}r/gravity/Center/crop/${x}x${y}";
}

isPhoneNumber(text) {
  RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  return exp.hasMatch(text);
}

// sleep(ss) {
//   return Future<void>.delayed(const Duration(seconds: ss));
// }

// await Future<void>.delayed(Duration(milliseconds: 1000));

//  CupertinoRefreshControl(onRefresh: () {
//           return Future<void>.delayed(const Duration(seconds: 1))
//             ..then((_) => setState(() {
//               if (flag) {
//                 flag = false;
//               } else {
//                 flag = true;
//               }
//             }));
//         })
