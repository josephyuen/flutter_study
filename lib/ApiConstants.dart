/**
 * Creator: joseph
 * Date: 2019-04-19 10:41
 * FuncDesc:  WanAndroid TODO_API
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */
class ApiConstants{

  static final SERVER_HOST = "https://www.wanandroid.com";

  static final LOGIN = SERVER_HOST + "/user/login";  // 登录

  static final REGISTER = SERVER_HOST + "/user/register";  // 注册

  static final LOGOUT = SERVER_HOST + "/user/logout/json";  // 登出


  static final ADD_TODO = SERVER_HOST + "/lg/todo/add/json";  // 新增一个TODO

  static final UPDATE_TODO = SERVER_HOST + "/lg/todo/update/83/json";  // 新增一个TODO

  static final DELETE_TODO = SERVER_HOST + "/lg/todo/delete/83/json";  // 删除一个TODO

  static final UPDATE_TODO_LIST = SERVER_HOST + "/lg/todo/done/80/json";  // 仅更新完成状态Todo

  static final GET_TODO_LIST = SERVER_HOST + "/lg/todo/v2/list/页码/json";  // TODOLIST 列表




}