/**
 * Creator: joseph
 * Date: 2019-04-19 10:41
 * FuncDesc:  WanAndroid TODO_API
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */
class ApiConstants{

  static final LOGIN_COOKIE = "login_cookie";


  static final SERVER_HOST = "https://www.wanandroid.com";

  static final LOGIN = SERVER_HOST + "/user/login";  // 登录   username，password

  static final REGISTER = SERVER_HOST + "/user/register";  // 注册   username,password,repassword

  static final LOGOUT = SERVER_HOST + "/user/logout/json";  // 登出


  static final ADD_TODO = SERVER_HOST + "/lg/todo/add/json";  // 新增一个TODO   title: 新增标题（必须） content: 新增详情（必须） date: 2018-08-01 预定完成时间（不传默认当天，建议传） type: 大于0的整数（可选） priority 大于0的整数（可选）；

  static final UPDATE_TODO = SERVER_HOST + "/lg/todo/update/83/json";  // 新增一个TODO

  static final DELETE_TODO = SERVER_HOST + "/lg/todo/delete/%s/json";  // 删除一个TODO

  static final UPDATE_TODO_LIST = SERVER_HOST + "/lg/todo/done/80/json";  // 仅更新完成状态Todo

  static final GET_TODO_LIST = SERVER_HOST + "/lg/todo/v2/list/";  // TODOLIST 列表   /json




}