// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DateRangeFilter {

 DateTime? get from; DateTime? get to;
/// Create a copy of DateRangeFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateRangeFilterCopyWith<DateRangeFilter> get copyWith => _$DateRangeFilterCopyWithImpl<DateRangeFilter>(this as DateRangeFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateRangeFilter&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'DateRangeFilter(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $DateRangeFilterCopyWith<$Res>  {
  factory $DateRangeFilterCopyWith(DateRangeFilter value, $Res Function(DateRangeFilter) _then) = _$DateRangeFilterCopyWithImpl;
@useResult
$Res call({
 DateTime? from, DateTime? to
});




}
/// @nodoc
class _$DateRangeFilterCopyWithImpl<$Res>
    implements $DateRangeFilterCopyWith<$Res> {
  _$DateRangeFilterCopyWithImpl(this._self, this._then);

  final DateRangeFilter _self;
  final $Res Function(DateRangeFilter) _then;

/// Create a copy of DateRangeFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = freezed,Object? to = freezed,}) {
  return _then(_self.copyWith(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DateRangeFilter].
extension DateRangeFilterPatterns on DateRangeFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DateRangeFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DateRangeFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DateRangeFilter value)  $default,){
final _that = this;
switch (_that) {
case _DateRangeFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DateRangeFilter value)?  $default,){
final _that = this;
switch (_that) {
case _DateRangeFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? from,  DateTime? to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DateRangeFilter() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? from,  DateTime? to)  $default,) {final _that = this;
switch (_that) {
case _DateRangeFilter():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? from,  DateTime? to)?  $default,) {final _that = this;
switch (_that) {
case _DateRangeFilter() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc


class _DateRangeFilter implements DateRangeFilter {
  const _DateRangeFilter({this.from, this.to});
  

@override final  DateTime? from;
@override final  DateTime? to;

/// Create a copy of DateRangeFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateRangeFilterCopyWith<_DateRangeFilter> get copyWith => __$DateRangeFilterCopyWithImpl<_DateRangeFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateRangeFilter&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'DateRangeFilter(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$DateRangeFilterCopyWith<$Res> implements $DateRangeFilterCopyWith<$Res> {
  factory _$DateRangeFilterCopyWith(_DateRangeFilter value, $Res Function(_DateRangeFilter) _then) = __$DateRangeFilterCopyWithImpl;
@override @useResult
$Res call({
 DateTime? from, DateTime? to
});




}
/// @nodoc
class __$DateRangeFilterCopyWithImpl<$Res>
    implements _$DateRangeFilterCopyWith<$Res> {
  __$DateRangeFilterCopyWithImpl(this._self, this._then);

  final _DateRangeFilter _self;
  final $Res Function(_DateRangeFilter) _then;

/// Create a copy of DateRangeFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,}) {
  return _then(_DateRangeFilter(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
