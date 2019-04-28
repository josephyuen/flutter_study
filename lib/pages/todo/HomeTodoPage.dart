import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/ApiConstants.dart';
import 'package:flutter_study/pages/todo/AddToDoPage.dart';
import 'package:flutter_study/pages/todo/todo_bean_entity.dart';
import 'package:flutter_study/utils/CommonUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Creator: joseph
 * Date: 2019-04-24 14:05
 * FuncDesc:  代办事项模块首页
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */

class HomeTodoPage extends StatefulWidget {
  static final String sName = "/home_todo_page";

  @override
  State<StatefulWidget> createState() => HomeTodoState();
}

class HomeTodoState extends State<HomeTodoPage> {
  TodoBeanEntity todoBean;

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 0), () {
      _getAllTodos(1);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
          AppBar(title: Text("柳田的代办事项"), centerTitle: true, actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AddToDoPage.sName);
          },
        ),
      ]),
      body: Text("商洛柳田的代办事项"),
    );
  }

  /**
   * 获取所有的代办事项 `=。=`
   */
  Future _getAllTodos(dynamic page) async {
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
    var requestUrl = "${ApiConstants.GET_TODO_LIST}${page}/json";
    try {
      response = await dio.post(requestUrl, data: {}, options: options);
    } on DioError catch (e) {
      Navigator.of(context, rootNavigator: true).pop(null);
      CommonUtils.showToast(infoMsg: "请求服务器失败");
      return;
    }
    if (response.statusCode == 200) {
      var result = response.data;
      if (result["errorCode"] == 0) {
        CommonUtils.showToast(infoMsg: "获取代办事项成功");
        todoBean = TodoBeanEntity.fromJson(response.data);
        todoBean.data.datas.forEach((e) {
          print("-----" + e.toString());
        });
      } else {
        CommonUtils.showToast(infoMsg: result["errorMsg"]);
      }
    } else {
      CommonUtils.showToast(infoMsg: "服务器响应异常");
    }
    Navigator.of(context, rootNavigator: true).pop(null);
  }
}
