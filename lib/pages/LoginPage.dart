import 'package:flutter/material.dart';

/**
 * Creator: joseph
 * Date: 2019-04-19 11:21
 * FuncDesc: 登录页面
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */

class LoginPage extends StatefulWidget{

  static final String sName = "/login_page";

  @override
  State<StatefulWidget> createState() => _LoginState();

}


class _LoginState extends State<LoginPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录/注册"),
        centerTitle: true,

      ),

      body: Column(
        children: <Widget>[
          Text("直接登录")
        ],

      ),

    );
  }


}