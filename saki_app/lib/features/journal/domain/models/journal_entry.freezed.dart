// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JournalEntry {

 String get id; String get title; String get content;// This will be encrypted when stored
 Mood get mood; DateTime get date; List<String> get tags; List<String> get attachedImages; String? get voiceNotePath; bool get isFavorite;
/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<JournalEntry> get copyWith => _$JournalEntryCopyWithImpl<JournalEntry>(this as JournalEntry, _$identity);

  /// Serializes this JournalEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.attachedImages, attachedImages)&&(identical(other.voiceNotePath, voiceNotePath) || other.voiceNotePath == voiceNotePath)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,mood,date,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(attachedImages),voiceNotePath,isFavorite);

@override
String toString() {
  return 'JournalEntry(id: $id, title: $title, content: $content, mood: $mood, date: $date, tags: $tags, attachedImages: $attachedImages, voiceNotePath: $voiceNotePath, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $JournalEntryCopyWith<$Res>  {
  factory $JournalEntryCopyWith(JournalEntry value, $Res Function(JournalEntry) _then) = _$JournalEntryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, Mood mood, DateTime date, List<String> tags, List<String> attachedImages, String? voiceNotePath, bool isFavorite
});




}
/// @nodoc
class _$JournalEntryCopyWithImpl<$Res>
    implements $JournalEntryCopyWith<$Res> {
  _$JournalEntryCopyWithImpl(this._self, this._then);

  final JournalEntry _self;
  final $Res Function(JournalEntry) _then;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? mood = null,Object? date = null,Object? tags = null,Object? attachedImages = null,Object? voiceNotePath = freezed,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,attachedImages: null == attachedImages ? _self.attachedImages : attachedImages // ignore: cast_nullable_to_non_nullable
as List<String>,voiceNotePath: freezed == voiceNotePath ? _self.voiceNotePath : voiceNotePath // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalEntry].
extension JournalEntryPatterns on JournalEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalEntry value)  $default,){
final _that = this;
switch (_that) {
case _JournalEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalEntry value)?  $default,){
final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String content,  Mood mood,  DateTime date,  List<String> tags,  List<String> attachedImages,  String? voiceNotePath,  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.mood,_that.date,_that.tags,_that.attachedImages,_that.voiceNotePath,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String content,  Mood mood,  DateTime date,  List<String> tags,  List<String> attachedImages,  String? voiceNotePath,  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _JournalEntry():
return $default(_that.id,_that.title,_that.content,_that.mood,_that.date,_that.tags,_that.attachedImages,_that.voiceNotePath,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String content,  Mood mood,  DateTime date,  List<String> tags,  List<String> attachedImages,  String? voiceNotePath,  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.mood,_that.date,_that.tags,_that.attachedImages,_that.voiceNotePath,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JournalEntry implements JournalEntry {
  const _JournalEntry({required this.id, required this.title, required this.content, required this.mood, required this.date, final  List<String> tags = const [], final  List<String> attachedImages = const [], this.voiceNotePath, this.isFavorite = false}): _tags = tags,_attachedImages = attachedImages;
  factory _JournalEntry.fromJson(Map<String, dynamic> json) => _$JournalEntryFromJson(json);

@override final  String id;
@override final  String title;
@override final  String content;
// This will be encrypted when stored
@override final  Mood mood;
@override final  DateTime date;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<String> _attachedImages;
@override@JsonKey() List<String> get attachedImages {
  if (_attachedImages is EqualUnmodifiableListView) return _attachedImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachedImages);
}

@override final  String? voiceNotePath;
@override@JsonKey() final  bool isFavorite;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalEntryCopyWith<_JournalEntry> get copyWith => __$JournalEntryCopyWithImpl<_JournalEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JournalEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._attachedImages, _attachedImages)&&(identical(other.voiceNotePath, voiceNotePath) || other.voiceNotePath == voiceNotePath)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,content,mood,date,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_attachedImages),voiceNotePath,isFavorite);

@override
String toString() {
  return 'JournalEntry(id: $id, title: $title, content: $content, mood: $mood, date: $date, tags: $tags, attachedImages: $attachedImages, voiceNotePath: $voiceNotePath, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$JournalEntryCopyWith<$Res> implements $JournalEntryCopyWith<$Res> {
  factory _$JournalEntryCopyWith(_JournalEntry value, $Res Function(_JournalEntry) _then) = __$JournalEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, Mood mood, DateTime date, List<String> tags, List<String> attachedImages, String? voiceNotePath, bool isFavorite
});




}
/// @nodoc
class __$JournalEntryCopyWithImpl<$Res>
    implements _$JournalEntryCopyWith<$Res> {
  __$JournalEntryCopyWithImpl(this._self, this._then);

  final _JournalEntry _self;
  final $Res Function(_JournalEntry) _then;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? mood = null,Object? date = null,Object? tags = null,Object? attachedImages = null,Object? voiceNotePath = freezed,Object? isFavorite = null,}) {
  return _then(_JournalEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,mood: null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as Mood,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,attachedImages: null == attachedImages ? _self._attachedImages : attachedImages // ignore: cast_nullable_to_non_nullable
as List<String>,voiceNotePath: freezed == voiceNotePath ? _self.voiceNotePath : voiceNotePath // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
