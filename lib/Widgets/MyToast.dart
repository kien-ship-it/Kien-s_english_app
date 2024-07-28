import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gif_view/gif_view.dart';

Future showToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future showLoadingAnim(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: GifView.asset("assets/images/loading_anim.gif"),
        );
      });
}
