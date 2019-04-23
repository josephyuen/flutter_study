import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/ApiConstants.dart';
import 'package:flutter_study/common/style/GSYStyle.dart';
import 'package:flutter_study/utils/CommonUtils.dart';
import 'package:flutter_study/widget/GSYFlexButton.dart';
import 'package:flutter_study/widget/GSYInputWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * Creator: joseph
 * Date: 2019-04-19 11:21
 * FuncDesc: 登录页面
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */

class LoginPage extends StatefulWidget {
  static final String sName = "/login_page";

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录/注册"),
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
                      image: new AssetImage(GSYICons.QUICKWIS_MEMBERS),
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
                    margin: EdgeInsets.only(top: 10.0),
                    child: new GSYInputWidget(
                      hintText: "请输入密码",
                      iconData: GSYICons.LOGIN_PW,
                      controller: pwdController,
                      obscureText: true,
                      maxlength: 15,
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(30.0)),
                  new GSYFlexButton(
                    text: "登录",
                    textColor: Color(GSYColors.textWhite),
                    color: Theme.of(context).primaryColor,
                    onPress: _onLoginClick,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  /**
   * 登录按钮点击
   */
  Future _onLoginClick() async {
    String userName = userController.text; //  用户名
    String password = pwdController.text; //  密码
    if (userName.isEmpty) {
      CommonUtils.showToast(infoMsg: "用户名不能为空");
      return;
    }

    if (password.isEmpty || password.length < 6) {
      CommonUtils.showToast(infoMsg: "密码不能为空且至少为6位");
      return;
    }

    CommonUtils.showLoadingDialog(context);


    Dio dio = new Dio();
    Response response = await dio.post(ApiConstants.LOGIN,
        data: {"username": userName, "password": password});

    if (response.statusCode == 200) {
      var result = response.data;
      if (result["errorCode"] == 0) {
      } else {
        CommonUtils.showToast(infoMsg: result["errorMsg"]);
      }
    } else {
      CommonUtils.showToast(infoMsg: "服务器响应异常");
    }
    Navigator.of(context, rootNavigator: true).pop(null);


  }
}
