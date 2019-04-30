/**
 * Creator: joseph
 * Date: 2019-04-30 14:53
 * FuncDesc:
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */


import 'package:flutter/material.dart';
import 'package:flutter_study/utils/TtsHelper.dart';
import 'package:flutter_study/widget/GSYInputWidget.dart';

class VoiceSetPage extends StatefulWidget {
  VoiceSetPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VoiceSetPageState createState() => _VoiceSetPageState();
}

class _VoiceSetPageState extends State<VoiceSetPage> {

  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
        elevation: 5.0, // shadow the bottom of AppBar
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            GSYInputWidget(
              hintText: "输入您想语音播出的文本",
              controller: textController,
              maxlength: 200,
              iconData: Icons.adb,
            ),


            ListTile(
              title: Text(
                '测试文本转语音',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              onTap: () {
                showAlertDialog(context);
                TtsHelper.instance.setLanguageAndSpeak(textController.text, "zh");
              },
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  NavigatorState navigator =
  context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
  debugPrint("navigator is null?" + (navigator == null).toString());
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
          title: new Text("语音播放"),
          content: new Text("语音正在播放中"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("关闭"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("好"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]));
}
