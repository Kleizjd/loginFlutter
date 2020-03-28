// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScheduleUser> _$scheduleUserSerializer =
    new _$ScheduleUserSerializer();

class _$ScheduleUserSerializer implements StructuredSerializer<ScheduleUser> {
  @override
  final Iterable<Type> types = const [ScheduleUser, _$ScheduleUser];
  @override
  final String wireName = 'ScheduleUser';

  @override
  Iterable<Object> serialize(Serializers serializers, ScheduleUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.date != null) {
      result
        ..add('date')
        ..add(serializers.serialize(object.date,
            specifiedType: const FullType(DateTime)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.complete != null) {
      result
        ..add('complete')
        ..add(serializers.serialize(object.complete,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ScheduleUser deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'complete':
          result.complete = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleUser extends ScheduleUser {
  @override
  final String id;
  @override
  final DateTime date;
  @override
  final String description;
  @override
  final bool complete;

  factory _$ScheduleUser([void Function(ScheduleUserBuilder) updates]) =>
      (new ScheduleUserBuilder()..update(updates)).build();

  _$ScheduleUser._({this.id, this.date, this.description, this.complete})
      : super._();

  @override
  ScheduleUser rebuild(void Function(ScheduleUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleUserBuilder toBuilder() => new ScheduleUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleUser &&
        id == other.id &&
        date == other.date &&
        description == other.description &&
        complete == other.complete;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), date.hashCode), description.hashCode),
        complete.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScheduleUser')
          ..add('id', id)
          ..add('date', date)
          ..add('description', description)
          ..add('complete', complete))
        .toString();
  }
}

class ScheduleUserBuilder
    implements Builder<ScheduleUser, ScheduleUserBuilder> {
  _$ScheduleUser _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  bool _complete;
  bool get complete => _$this._complete;
  set complete(bool complete) => _$this._complete = complete;

  ScheduleUserBuilder();

  ScheduleUserBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _date = _$v.date;
      _description = _$v.description;
      _complete = _$v.complete;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ScheduleUser;
  }

  @override
  void update(void Function(ScheduleUserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ScheduleUser build() {
    final _$result = _$v ??
        new _$ScheduleUser._(
            id: id, date: date, description: description, complete: complete);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
