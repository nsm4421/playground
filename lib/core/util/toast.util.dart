import 'package:fluttertoast/fluttertoast.dart';
import '../theme/custom_palette.theme.dart';

class ToastUtil{
  static void toast(String msg, { int duration =2 }){
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: duration ,
        backgroundColor:CustomPalette.toastBackground, textColor: CustomPalette.white,
        fontSize: 15);
  }
}