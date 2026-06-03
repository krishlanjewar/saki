// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalStats {

 int get currentStreak; int get totalEntries; int get totalWords; Map<String, int> get tagCounts;
/// Create a copy of JournalStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalStatsCopyWith<JournalStats> get copyWith => _$JournalStatsCopyWithImpl<JournalStats>(this as JournalStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalStats&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.totalEntries, totalEntries) || other.totalEntries == totalEntries)&&(identical(other.totalWords, totalWords) || other.totalWords == totalWords)&&const DeepCollectionEquality().equals(other.tagCounts, tagCounts));
}


@override
int get hashCode => Object.hash(runtimeType,currentStreak,totalEntries,totalWords,const DeepCollectionEquality().hash(tagCounts));

@override
String toString() {
  return 'JournalStats(currentStreak: $currentStreak, totalEntries: $totalEntries, totalWords: $totalWords, tagCounts: $tagCounts)';
}


}

/// @nodoc
abstract mixin class $JournalStatsCopyWith<$Res>  {
  factory $JournalStatsCopyWith(JournalStats value, $Res Function(JournalStats) _then) = _$JournalStatsCopyWithImpl;
@useResult
$Res call({
 int currentStreak, int totalEntries, int totalWords, Map<String, int> tagCounts
});




}
/// @nodoc
class _$JournalStatsCopyWithImpl<$Res>
    implements $JournalStatsCopyWith<$Res> {
  _$JournalStatsCopyWithImpl(this._self, this._then);

  final JournalStats _self;
  final $Res Function(JournalStats) _then;

/// Create a copy of JournalStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStreak = null,Object? totalEntries = null,Object? totalWords = null,Object? tagCounts = null,}) {
  return _then(_self.copyWith(
currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,totalEntries: null == totalEntries ? _self.totalEntries : totalEntries // ignore: cast_nullable_to_non_nullable
as int,totalWords: null == totalWords ? _self.totalWords : totalWords // ignore: cast_nullable_to_non_nullable
as int,tagCounts: null == tagCounts ? _self.tagCounts : tagCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalStats].
extension JournalStatsPatterns on JournalStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalStats value)  $default,){
final _that = this;
switch (_that) {
case _JournalStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalStats value)?  $default,){
final _that = this;
switch (_that) {
case _JournalStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStreak,  int totalEntries,  int totalWords,  Map<String, int> tagCounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalStats() when $default != null:
return $default(_that.currentStreak,_that.totalEntries,_that.totalWords,_that.tagCounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStreak,  int totalEntries,  int totalWords,  Map<String, int> tagCounts)  $default,) {final _that = this;
switch (_that) {
case _JournalStats():
return $default(_that.currentStreak,_that.totalEntries,_that.totalWords,_that.tagCounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStreak,  int totalEntries,  int totalWords,  Map<String, int> tagCounts)?  $default,) {final _that = this;
switch (_that) {
case _JournalStats() when $default != null:
return $default(_that.currentStreak,_that.totalEntries,_that.totalWords,_that.tagCounts);case _:
  return null;

}
}

}

/// @nodoc


class _JournalStats implements JournalStats {
  const _JournalStats({this.currentStreak = 0, this.totalEntries = 0, this.totalWords = 0, final  Map<String, int> tagCounts = const {}}): _tagCounts = tagCounts;
  

@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  int totalEntries;
@override@JsonKey() final  int totalWords;
 final  Map<String, int> _tagCounts;
@override@JsonKey() Map<String, int> get tagCounts {
  if (_tagCounts is EqualUnmodifiableMapView) return _tagCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_tagCounts);
}


/// Create a copy of JournalStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalStatsCopyWith<_JournalStats> get copyWith => __$JournalStatsCopyWithImpl<_JournalStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalStats&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.totalEntries, totalEntries) || other.totalEntries == totalEntries)&&(identical(other.totalWords, totalWords) || other.totalWords == totalWords)&&const DeepCollectionEquality().equals(other._tagCounts, _tagCounts));
}


@override
int get hashCode => Object.hash(runtimeType,currentStreak,totalEntries,totalWords,const DeepCollectionEquality().hash(_tagCounts));

@override
String toString() {
  return 'JournalStats(currentStreak: $currentStreak, totalEntries: $totalEntries, totalWords: $totalWords, tagCounts: $tagCounts)';
}


}

/// @nodoc
abstract mixin class _$JournalStatsCopyWith<$Res> implements $JournalStatsCopyWith<$Res> {
  factory _$JournalStatsCopyWith(_JournalStats value, $Res Function(_JournalStats) _then) = __$JournalStatsCopyWithImpl;
@override @useResult
$Res call({
 int currentStreak, int totalEntries, int totalWords, Map<String, int> tagCounts
});




}
/// @nodoc
class __$JournalStatsCopyWithImpl<$Res>
    implements _$JournalStatsCopyWith<$Res> {
  __$JournalStatsCopyWithImpl(this._self, this._then);

  final _JournalStats _self;
  final $Res Function(_JournalStats) _then;

/// Create a copy of JournalStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStreak = null,Object? totalEntries = null,Object? totalWords = null,Object? tagCounts = null,}) {
  return _then(_JournalStats(
currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,totalEntries: null == totalEntries ? _self.totalEntries : totalEntries // ignore: cast_nullable_to_non_nullable
as int,totalWords: null == totalWords ? _self.totalWords : totalWords // ignore: cast_nullable_to_non_nullable
as int,tagCounts: null == tagCounts ? _self._tagCounts : tagCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
