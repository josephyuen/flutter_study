import 'package:json_annotation/json_annotation.dart';

/**
 * Creator: joseph
 * Date: 2019-04-25 09:22
 * FuncDesc:  Todo基础Bean
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */


class TodoBeanEntity {
	TodoBeanData data;
	int errorCode;
	String errorMsg;

	TodoBeanEntity({this.data, this.errorCode, this.errorMsg});

	TodoBeanEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new TodoBeanData.fromJson(json['data']) : null;
		errorCode = json['errorCode'];
		errorMsg = json['errorMsg'];
	}


	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}

	@override
	String toString() {
		return 'TodoBeanEntity{data: $data, errorCode: $errorCode, errorMsg: $errorMsg}';
	}


}

class TodoBeanData {
	bool over;
	int pageCount;
	int total;
	int curPage;
	int offset;
	int size;
	List<TodoBeanDataData> datas;

	TodoBeanData({this.over, this.pageCount, this.total, this.curPage, this.offset, this.size, this.datas});

	TodoBeanData.fromJson(Map<String, dynamic> json) {
		over = json['over'];
		pageCount = json['pageCount'];
		total = json['total'];
		curPage = json['curPage'];
		offset = json['offset'];
		size = json['size'];
		if (json['datas'] != null) {
			datas = new List<TodoBeanDataData>();
			(json['datas'] as List).forEach((v) { datas.add(new TodoBeanDataData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['over'] = this.over;
		data['pageCount'] = this.pageCount;
		data['total'] = this.total;
		data['curPage'] = this.curPage;
		data['offset'] = this.offset;
		data['size'] = this.size;
		if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
		return data;
	}

	@override
	String toString() {
		return 'TodoBeanData{over: $over, pageCount: $pageCount, total: $total, curPage: $curPage, offset: $offset, size: $size, datas: $datas}';
	}


}

class TodoBeanDataData {
	int date;
	String dateStr;
	int id;
	int priority;
	String title;
	int type;
	int userId;
	String completeDateStr;
	String content;
	String completeDate;
	int status;

	TodoBeanDataData({this.date, this.dateStr, this.id, this.priority, this.title, this.type, this.userId, this.completeDateStr, this.content, this.completeDate, this.status});

	TodoBeanDataData.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		dateStr = json['dateStr'];
		id = json['id'];
		priority = json['priority'];
		title = json['title'];
		type = json['type'];
		userId = json['userId'];
		completeDateStr = json['completeDateStr'];
		content = json['content'];
		completeDate = json['completeDate'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		data['dateStr'] = this.dateStr;
		data['id'] = this.id;
		data['priority'] = this.priority;
		data['title'] = this.title;
		data['type'] = this.type;
		data['userId'] = this.userId;
		data['completeDateStr'] = this.completeDateStr;
		data['content'] = this.content;
		data['completeDate'] = this.completeDate;
		data['status'] = this.status;
		return data;
	}

	@override
	String toString() {
		return 'TodoBeanDataData{date: $date, dateStr: $dateStr, id: $id, priority: $priority, title: $title, type: $type, userId: $userId, completeDateStr: $completeDateStr, content: $content, completeDate: $completeDate, status: $status}';
	}


}
