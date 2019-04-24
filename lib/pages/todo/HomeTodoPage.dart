import 'package:flutter/material.dart';

/**
 * Creator: joseph
 * Date: 2019-04-24 14:05
 * FuncDesc:  代办事项模块首页
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */

class HomeTodoPage extends StatefulWidget{
  static final sName = "/home_todo_page";


  @override
  State<StatefulWidget> createState() => HomeTodoState();
}

class HomeTodoState extends State<HomeTodoPage>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("柳田的代办事项"),
        centerTitle: true,
      ),

      body: Text("商洛柳田的代办事项"),

    );

  }


}