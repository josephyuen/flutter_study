import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  User(
      this.id,
      this.node_id,
      this.avatar_url,
      this.gravatar_id);


  String id;
  String node_id;
  String avatar_url;
  String gravatar_id;



  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);


  Map<String, dynamic> toJson() => _$UserToJson(this);

  // 命名构造函数
  User.empty();

}