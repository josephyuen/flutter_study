import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/ApiConstants.dart';
import 'package:flutter_study/Constants.dart';
import 'package:flutter_study/common/style/GSYStyle.dart';
import 'package:flutter_study/main.dart';
import 'package:flutter_study/pages/todo/AddToDoPage.dart';
import 'package:flutter_study/pages/todo/todo_bean_entity.dart';
import 'package:flutter_study/utils/CommonUtils.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_study/widget/ClickEffectImage.dart';
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


deleteFromDatas(BuildContext context, TodoBeanDataData item,
      List<Entry> entryDatas, Map<String, int> gtjMap) {
    int entryIndex = gtjMap[item.dateStr];
    List<TodoBeanDataData> todoLists = entryDatas[entryIndex].todoBeans;
    bool a = todoLists.remove(item);
    if (todoLists.isEmpty) {
      entryDatas.removeAt(entryIndex);
    }
    CommonUtils.showToast(infoMsg: "结果是什么：$a");
  }


class HomeTodoState extends State<HomeTodoPage> with RouteAware {
  TodoBeanEntity _todoBean;

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 0), () {
      getAllTodos(1);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future didPopNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(Constants.ADD_TODO_EVENT)) {
      prefs.setBool(Constants.ADD_TODO_EVENT, false);
      getAllTodos(1);
    }
  }

  // Called when the current route has been pushed.
  void didPush() {}

  // Called when the current route has been popped off.
  void didPop() {}

  // Called when a new route has been pushed, and the current route is no longer visible.
  void didPushNext() {}

  @override
  void didUpdateWidget(HomeTodoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
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
      body: new ListView.builder(
        itemCount: _entryDatas.length,
        itemBuilder: (context, index) {
          return _buildItems(_entryDatas[index]);
        },
      ),
    );
  }

  // 构建条目
  Widget _buildItems(Entry root) {
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.dateStr),
      children: root.todoBeans.map<Widget>(_buildContent).toList(),
    );
  }

  Widget _buildContent(TodoBeanDataData item) {
    return todoContent(item, _entryDatas, _gtjMap);
  }



   /*
   * 删除此条代办事项
   */
  Future _deleteCurTodo(BuildContext context, TodoBeanDataData item,
      List<Entry> entryDatas, Map<String, int> gtjMap) async {
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
      String requestUrl =
          sprintf(ApiConstants.DELETE_TODO, [item.id.toString()]);
      response =
          await dio.post(requestUrl, data: {"id": item.id}, options: options);
    } on DioError catch (e) {
      Navigator.of(context, rootNavigator: true).pop(null);
      CommonUtils.showToast(infoMsg: "请求服务器失败");
      return;
    }
    if (response.statusCode == 200) {
      var result = response.data;
      if (result["errorCode"] == 0) {
        CommonUtils.showToast(infoMsg: "删除代办成功");
        deleteFromDatas(context, item, entryDatas, gtjMap);
        setState(() {});
      } else {
        CommonUtils.showToast(infoMsg: result["errorMsg"]);
      }
    } else {
      CommonUtils.showToast(infoMsg: "服务器响应异常");
    }
    Navigator.of(context, rootNavigator: true).pop(null);
  }



  Widget todoContent(final TodoBeanDataData item, final List<Entry> entryDatas,
      final Map<String, int> gtjMap) {
          return new Container(
      margin: EdgeInsets.only(top: 15.0, left: 20.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClickEffectImage(
                width: 20.0,
                height: 20.0,
                assetsImgPath: GSYICons.IC_TODO_REC,
                onClick: () {
                  CommonUtils.showToast(infoMsg: "点击了完成按钮，😃😃😃");
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(item.title, style: TextStyle(fontSize: 16.0)),
                ),
                flex: 1,
              ),
              ClickEffectImage(
                width: 20.0,
                height: 20.0,
                assetsImgPath: GSYICons.IC_DELETE,
                onClick: () {
                  _deleteCurTodo(context, item, entryDatas, gtjMap);
                },
              ),
              SizedBox(
                width: 20.0,
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                item.content,
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );




 


  }

  /**
   * 获取所有的代办事项 `=。=`
   */
  Future getAllTodos(dynamic page) async {
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
        CommonUtils.showToast(infoMsg: "获取待办事项成功");
        _todoBean = TodoBeanEntity.fromJson(response.data);
        _dealWithTodoLists();
      } else {
        CommonUtils.showToast(infoMsg: result["errorMsg"]);
      }
    } else {
      CommonUtils.showToast(infoMsg: "服务器响应异常");
    }
    Navigator.of(context, rootNavigator: true).pop(null);
  }

  // List<TodoBeanDataData> _itemDatas = new List();

  List<Entry> _entryDatas = new List();
  Map<String, int> _gtjMap = new Map();

  void _dealWithTodoLists() {
    if (_todoBean == null) return;
    // _itemDatas.clear();
    _entryDatas.clear();
    _gtjMap.clear();

    _todoBean.data.datas.forEach((bean) {
      if (_gtjMap.containsKey(bean.dateStr)) {
        int index = _gtjMap[bean.dateStr];
        _entryDatas[index].todoBeans.add(bean);
      } else {
        Entry entry = new Entry(bean.dateStr, new List<TodoBeanDataData>());
        entry.todoBeans.add(bean);
        _entryDatas.add(entry);
        _gtjMap[bean.dateStr] = _entryDatas.length - 1;
      }
    });
    setState(() {}); // 刷新页面
  }
}

TodoBeanDataData _getNewDateTitle(dateStr) {
  return new TodoBeanDataData(dateStr: dateStr);
}

class Entry {
  Entry(this.dateStr, [this.todoBeans = const <TodoBeanDataData>[]]);
  final String dateStr;
  final List<TodoBeanDataData> todoBeans;
}

// {date: 1556208000000, dateStr: 2019-04-26, id: 9686, priority: 0,
// title: 水电费第三方, type: 0, userId: 22320, completeDateStr: ,
// content: 第三方第三方, completeDate: null, status: 0}
//   ------------  待办列表  ------------
abstract class ListItem {}

class HeadItem implements ListItem {
  final String headDate;

  HeadItem(this.headDate);
}

class ContentItem implements ListItem {
  final String title;
  final String content;

  ContentItem(this.title, this.content);
}
