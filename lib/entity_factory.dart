import 'package:flutter_study/pages/todo/todo_bean_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "TodoBeanEntity") {
      return TodoBeanEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}