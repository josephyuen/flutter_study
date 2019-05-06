import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/ApiConstants.dart';
import 'package:flutter_study/common/style/GSYStyle.dart';
import 'package:flutter_study/utils/CommonUtils.dart';
import 'package:flutter_study/widget/GSYFlexButton.dart';
import 'package:flutter_study/widget/GSYInputWidget.dart';

///
/// Creator: joseph
/// Date: 2019-04-23 23:44
/// FuncDesc:  注册页面
/// copyright  ©2019-2030 Technology Corporation. All rights reserved.
///

class RegisterPage extends StatefulWidget {
  static final sName = "/register_page";

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwdController = new TextEditingController();
  final TextEditingController pwdAgainController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("新用户注册"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: new Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Center(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    child: new Image(
                      image: new AssetImage(GSYICons.QUICKWIS_ACTIVITY),
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                      height: 180.0,
                      alignment: Alignment.center,
                    ),
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  ),
                  new GSYInputWidget(
                    hintText: "请输入登录用户名",
                    iconData: GSYICons.LOGIN_USER,
                    controller: userController,
                    maxlength: 20,
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 3.0),
                    child: new GSYInputWidget(
                      hintText: "请输入密码",
                      iconData: GSYICons.LOGIN_PW,
                      controller: pwdController,
                      obscureText: true,
                      maxlength: 15,
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 3.0),
                    child: new GSYInputWidget(
                      hintText: "请再次输入密码",
                      iconData: GSYICons.LOGIN_PW,
                      controller: pwdAgainController,
                      obscureText: true,
                      maxlength: 15,
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0)),
                  new GSYFlexButton(
                    text: "立即注册",
                    textColor: Color(GSYColors.textWhite),
                    color: Theme.of(context).primaryColor,
                    onPress: _onRegisterClick,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  /**
   * 用户注册
   */
  Future _onRegisterClick() async {
    String userName = userController.text; //  用户名
    String password = pwdController.text; //  密码
    String pwdAgain = pwdAgainController.text; //  确认密码

    if (userName.isEmpty) {
      CommonUtils.showToast(infoMsg: "用户名不能为空");
      return;
    }

    if (password.isEmpty || password.length < 6) {
      CommonUtils.showToast(infoMsg: "密码不能为空且至少为6位");
      return;
    }

    if (pwdAgain.isEmpty || password != pwdAgain) {
      CommonUtils.showToast(infoMsg: "两次密码输入不一致");
      return;
    }

    // loading ..
    CommonUtils.showLoadingDialog(context);
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    Response response;
    try {
      response = await dio.post(ApiConstants.REGISTER, data: {
        "username": userName,
        "password": password,
        "repassword": pwdAgain
      });
    } on DioError catch (e) {
      CommonUtils.showToast(infoMsg: e.message);
      Navigator.of(context, rootNavigator: true).pop(null);
      return;
    }

    if (response.statusCode == 200) {
      var result = response.data;
      if (result["errorCode"] == 0) {
        CommonUtils.showToast(infoMsg: "恭喜你,注册成功!");
        Navigator.pop(context, null);
      } else {
        CommonUtils.showToast(infoMsg: result["errorMsg"]);
      }
    } else {
      CommonUtils.showToast(infoMsg: "服务器响应异常");
    }

    Navigator.of(context, rootNavigator: true).pop(null);

  }
}
