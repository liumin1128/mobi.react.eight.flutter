import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/user.dart';
import 'dart:convert';
import 'package:eight/utils/common.dart';
import 'dart:async';

class GetPhoneCodeButton extends StatefulWidget {
  GetPhoneCodeButton({Key key, this.enabled, this.onPress}) : super(key: key);
  final bool enabled;
  final Function onPress;
  @override
  _GetPhoneCodeButtonState createState() => _GetPhoneCodeButtonState();
}

class _GetPhoneCodeButtonState extends State<GetPhoneCodeButton> {
  Timer _timer;
  String _str = '获取验证码';
  int _countdownNum = 0;

  void reGetCountdown() {
    setState(() {
      if (_timer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。

      _countdownNum = 59;
      _str = '${_countdownNum--} 重新获取';

      _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _str = '${_countdownNum--} 重新获取';
          } else {
            _str = '获取验证码';
            _countdownNum = 59;
            _timer.cancel();
            _timer = null;
          }
        });
      });
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 20,
      padding: const EdgeInsets.all(6),
      child: Text(_str),
      onPressed: widget.enabled && _timer == null
          ? () {
              widget.onPress();
              reGetCountdown();
            }
          : null,
    );
  }
}
