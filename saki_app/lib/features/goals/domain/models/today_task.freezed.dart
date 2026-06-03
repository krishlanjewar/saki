// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodayTask {

 String get id; String get name; String get description;/// ISO-8601 date string for the day this task belongs to.
 String get date; bool get isCompleted;/// Optional deadline as ISO-8601 datetime string.
 String? get deadline;
/// Create a copy of TodayTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayTaskCopyWith<TodayTask> get copyWith => _$TodayTaskCopyWithImpl<TodayTask>(this as TodayTask, _$identity);

  /// Serializes this TodayTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.deadline, deadline) || other.deadline == deadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,date,isCompleted,deadline);

@override
String toString() {
  return 'TodayTask(id: $id, name: $name, description: $description, date: $date, isCompleted: $isCompleted, deadline: $deadline)';
}


}

/// @nodoc
abstract mixin class $TodayTaskCopyWith<$Res>  {
  factory $TodayTaskCopyWith(TodayTask value, $Res Function(TodayTask) _then) = _$TodayTaskCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String date, bool isCompleted, String? deadline
});




}
/// @nodoc
class _$TodayTaskCopyWithImpl<$Res>
    implements $TodayTaskCopyWith<$Res> {
  _$TodayTaskCopyWithImpl(this._self, this._then);

  final TodayTask _self;
  final $Res Function(TodayTask) _then;

/// Create a copy of TodayTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? date = null,Object? isCompleted = null,Object? deadline = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayTask].
extension TodayTaskPatterns on TodayTask {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayTask() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayTask value)  $default,){
final _that = this;
switch (_that) {
case _TodayTask():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayTask value)?  $default,){
final _that = this;
switch (_that) {
case _TodayTask() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String date,  bool isCompleted,  String? deadline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayTask() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.date,_that.isCompleted,_that.deadline);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String date,  bool isCompleted,  String? deadline)  $default,) {final _that = this;
switch (_that) {
case _TodayTask():
return $default(_that.id,_that.name,_that.description,_that.date,_that.isCompleted,_that.deadline);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String date,  bool isCompleted,  String? deadline)?  $default,) {final _that = this;
switch (_that) {
case _TodayTask() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.date,_that.isCompleted,_that.deadline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodayTask extends TodayTask {
  const _TodayTask({required this.id, required this.name, this.description = '', required this.date, this.isCompleted = false, this.deadline}): super._();
  factory _TodayTask.fromJson(Map<String, dynamic> json) => _$TodayTaskFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String description;
/// ISO-8601 date string for the day this task belongs to.
@override final  String date;
@override@JsonKey() final  bool isCompleted;
/// Optional deadline as ISO-8601 datetime string.
@override final  String? deadline;

/// Create a copy of TodayTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayTaskCopyWith<_TodayTask> get copyWith => __$TodayTaskCopyWithImpl<_TodayTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodayTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayTask&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.deadline, deadline) || other.deadline == deadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,date,isCompleted,deadline);

@override
String toString() {
  return 'TodayTask(id: $id, name: $name, description: $description, date: $date, isCompleted: $isCompleted, deadline: $deadline)';
}


}

/// @nodoc
abstract mixin class _$TodayTaskCopyWith<$Res> implements $TodayTaskCopyWith<$Res> {
  factory _$TodayTaskCopyWith(_TodayTask value, $Res Function(_TodayTask) _then) = __$TodayTaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String date, bool isCompleted, String? deadline
});




}
/// @nodoc
class __$TodayTaskCopyWithImpl<$Res>
    implements _$TodayTaskCopyWith<$Res> {
  __$TodayTaskCopyWithImpl(this._self, this._then);

  final _TodayTask _self;
  final $Res Function(_TodayTask) _then;

/// Create a copy of TodayTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? date = null,Object? isCompleted = null,Object? deadline = freezed,}) {
  return _then(_TodayTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
