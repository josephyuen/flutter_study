import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_study/common/GSYState.dart';
import 'package:flutter_study/common/model/User.dart';
import 'package:flutter_study/pages/ImagePickerPage.dart';
import 'package:flutter_study/pages/LoginPage.dart';
import 'package:flutter_study/widget/FancyFab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final store = new Store<GSYState>(
    appReducer,

    ///初始化数据
    initialState: new GSYState(userInfo: User.empty()),
  );

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<GSYState>(builder: (context, store) {
        return MaterialApp(
            title: '商洛柳田',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: MyHomePage(title: '商洛柳田的秘密花园'),
            routes: {
              ImagePickerPage.sName: (context) => new ImagePickerPage(),
              LoginPage.sName: (context) => new LoginPage(),
            });
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _wordPair = new WordPair.random();


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _displaySnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
        content: Text(text),
        duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _incrementCounter() {
    setState(() {
      _wordPair = new WordPair.random();
    });
  }

  /**
   *  去登录页面
   */
  void _goToLoginPage() {
    _displaySnackBar(context, "商洛柳田降临！！！");
    new Future.delayed(Duration(seconds: 1), () => {
//      Navigator.pushNamed(context,LoginPage.sName)
      Navigator.push(context,new MaterialPageRoute(builder: (context) => new LoginPage()),
    )

    });
  }

  /**
   *  去图片选择
   */
  void _goToImagePicker() {
    Fluttertoast.showToast(
        msg: "进入图片选择页面",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white);

    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ImagePickerPage()),
    );
//    Navigator.pushNamed(context, ImagePickerPage.sName);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                '随机字符串，嘿嘿😝:',
              ),
            ),
            Text(
//              '$_counter',

              _wordPair.asPascalCase,
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
            new Expanded(
              child: new Padding(
                padding: EdgeInsets.only(right: 30, bottom: 30),
                child: new Align(
                  alignment: Alignment.bottomRight,
                  child: new FancyFab(
                    onFirstPressed: _incrementCounter, // 随机切换
                    onSecondPressed: _goToLoginPage,
                    onThirdPressed: _goToImagePicker, //  跳转新页面
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}