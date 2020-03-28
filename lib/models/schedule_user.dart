
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_secret_chat/models/serializers.dart';

part 'schedule_user.g.dart';

abstract class ScheduleUser implements Built<ScheduleUser, ScheduleUserBuilder> {

  @nullable
  String get id;
  @nullable
  DateTime get date;
  @nullable
  String get description;
  @nullable
  bool get complete;
//  @nullable
//  const ScheduleUser(this.task, this.isFinish);

  ScheduleUser._();
  factory ScheduleUser([void Function(ScheduleUserBuilder) updates]) = _$ScheduleUser;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ScheduleUser.serializer, this);
  }

  static ScheduleUser fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ScheduleUser.serializer, json);
  }

  static Serializer<ScheduleUser> get serializer => _$scheduleUserSerializer;
}
//class ScheduleUser {
//  final String id, date, description;
//  final DateTime createdAt, updatedAt;
//
//  ScheduleUser({this.id, this.date, this.description, this.createdAt, this.updatedAt});
//
//  factory ScheduleUser.fromJson(Map<String, dynamic> json) {
//    final createdAt = DateTime.parse(json['createdAt']);
//    final updatedAt = DateTime.parse(json['updatedAt']);
//
//    return ScheduleUser(
//        id: json['_id'],
//        description: json['description'],
//        date: json['date'],
//        createdAt: createdAt,
//        updatedAt: updatedAt
//    );
//  }
//
//  Map<String, dynamic> toJson() {
//    return {
//      "_id": this.id,
//      "description": this.description,
//      "date": this.date,
//      "createdAt": createdAt.toString(),
//      "updatedAt": updatedAt.toString(),
//    };
//  }
//}