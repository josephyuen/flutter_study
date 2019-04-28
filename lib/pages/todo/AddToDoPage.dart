import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/ApiConstants.dart';
import 'package:flutter_study/utils/CommonUtils.dart';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Creator: joseph
 * Date: 2019-04-25 17:05
 * FuncDesc:  新增代办事项
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */

class AddToDoPage extends StatefulWidget {
  static final String sName = "/add_todo_page";

  @override
  State<StatefulWidget> createState() => AddTodoState();
}

class AddTodoState extends State<AddToDoPage> {
  TextEditingController _titleControll = new TextEditingController(); // 待办标题
  TextEditingController _contentControll = new TextEditingController(); // 待办内容

  var _dateTimeStr = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新增代办事项"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 8.0,
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  child: TextField(
                    controller: _titleControll,
                    keyboardType: TextInputType.text,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.title),
                      labelText: '待办事项标题',
                    ),
                    autofocus: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  child: TextField(
                    controller: _contentControll,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.content_copy),
                      labelText: '待办内容描述',
                    ),
                    autofocus: false,
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _dateTimeStr ?? "请选择代办的日期时间",
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: _showDateTimePicker,
                      child: Text("选择日期"),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: _commitTodo,
                  child: Text("新增此代办"),
                ),
                SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /**
   * 新增代办事项
   */
  Future _commitTodo() async {
    String title = _titleControll.text;
    String content = _contentControll.text;
    if (title == null || title.isEmpty) {
      CommonUtils.showToast(infoMsg: "标题不能为空");
      return;
    }

    if (content == null || content.isEmpty) {
      CommonUtils.showToast(infoMsg: "待办内容不能为空");
      return;
    }

    CommonUtils.showLoadingDialog(context);
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookies = prefs.getString(ApiConstants.LOGIN_COOKIE);
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = cookies;
    Options options = new Options(headers: headers);
    Response response;
    try {
      response = await dio.post(ApiConstants.ADD_TODO,
          data: {
            "title": title,
            "content": content,
            "date": _dateTimeStr,
          },
          options: options);
    } on DioError catch (e) {
      Navigator.of(context, rootNavigator: true).pop(null);
      CommonUtils.showToast(infoMsg: "请求服务器失败");
      return;
    }
    if (response.statusCode == 200) {
      var result = response.data;
      if (result["errorCode"] == 0) {
        CommonUtils.showToast(infoMsg: "已成功为您添加了一条代办事项");
      } else {
        CommonUtils.showToast(infoMsg: result["errorMsg"]);
      }
    } else {
      CommonUtils.showToast(infoMsg: "服务器响应异常");
    }
    Navigator.of(context, rootNavigator: true).pop(null);
    Navigator.pop(context);
  }

  /**
   * 日期、时间选择
   */
  void _showDateTimePicker() async {
    CommonUtils.showToast(infoMsg: "选择日期时间。。。");

    Locale locale = Localizations.localeOf(context);
    var datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
      locale: locale,
    );

    var dateTimeStr = "${formatDate(datePicker, [yyyy, '-', mm, '-', dd])}";
    setState(() {
      _dateTimeStr = dateTimeStr;
    });
  }
}
