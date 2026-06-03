// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'investment_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvestmentCategory {

 String get label; double get amount;
/// Create a copy of InvestmentCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvestmentCategoryCopyWith<InvestmentCategory> get copyWith => _$InvestmentCategoryCopyWithImpl<InvestmentCategory>(this as InvestmentCategory, _$identity);

  /// Serializes this InvestmentCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvestmentCategory&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,amount);

@override
String toString() {
  return 'InvestmentCategory(label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $InvestmentCategoryCopyWith<$Res>  {
  factory $InvestmentCategoryCopyWith(InvestmentCategory value, $Res Function(InvestmentCategory) _then) = _$InvestmentCategoryCopyWithImpl;
@useResult
$Res call({
 String label, double amount
});




}
/// @nodoc
class _$InvestmentCategoryCopyWithImpl<$Res>
    implements $InvestmentCategoryCopyWith<$Res> {
  _$InvestmentCategoryCopyWithImpl(this._self, this._then);

  final InvestmentCategory _self;
  final $Res Function(InvestmentCategory) _then;

/// Create a copy of InvestmentCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? amount = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [InvestmentCategory].
extension InvestmentCategoryPatterns on InvestmentCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvestmentCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvestmentCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvestmentCategory value)  $default,){
final _that = this;
switch (_that) {
case _InvestmentCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvestmentCategory value)?  $default,){
final _that = this;
switch (_that) {
case _InvestmentCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvestmentCategory() when $default != null:
return $default(_that.label,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double amount)  $default,) {final _that = this;
switch (_that) {
case _InvestmentCategory():
return $default(_that.label,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _InvestmentCategory() when $default != null:
return $default(_that.label,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvestmentCategory implements InvestmentCategory {
  const _InvestmentCategory({required this.label, required this.amount});
  factory _InvestmentCategory.fromJson(Map<String, dynamic> json) => _$InvestmentCategoryFromJson(json);

@override final  String label;
@override final  double amount;

/// Create a copy of InvestmentCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvestmentCategoryCopyWith<_InvestmentCategory> get copyWith => __$InvestmentCategoryCopyWithImpl<_InvestmentCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvestmentCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvestmentCategory&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,amount);

@override
String toString() {
  return 'InvestmentCategory(label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$InvestmentCategoryCopyWith<$Res> implements $InvestmentCategoryCopyWith<$Res> {
  factory _$InvestmentCategoryCopyWith(_InvestmentCategory value, $Res Function(_InvestmentCategory) _then) = __$InvestmentCategoryCopyWithImpl;
@override @useResult
$Res call({
 String label, double amount
});




}
/// @nodoc
class __$InvestmentCategoryCopyWithImpl<$Res>
    implements _$InvestmentCategoryCopyWith<$Res> {
  __$InvestmentCategoryCopyWithImpl(this._self, this._then);

  final _InvestmentCategory _self;
  final $Res Function(_InvestmentCategory) _then;

/// Create a copy of InvestmentCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? amount = null,}) {
  return _then(_InvestmentCategory(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$InvestmentSummary {

 double get totalBalance; List<InvestmentCategory> get categories;
/// Create a copy of InvestmentSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvestmentSummaryCopyWith<InvestmentSummary> get copyWith => _$InvestmentSummaryCopyWithImpl<InvestmentSummary>(this as InvestmentSummary, _$identity);

  /// Serializes this InvestmentSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvestmentSummary&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'InvestmentSummary(totalBalance: $totalBalance, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $InvestmentSummaryCopyWith<$Res>  {
  factory $InvestmentSummaryCopyWith(InvestmentSummary value, $Res Function(InvestmentSummary) _then) = _$InvestmentSummaryCopyWithImpl;
@useResult
$Res call({
 double totalBalance, List<InvestmentCategory> categories
});




}
/// @nodoc
class _$InvestmentSummaryCopyWithImpl<$Res>
    implements $InvestmentSummaryCopyWith<$Res> {
  _$InvestmentSummaryCopyWithImpl(this._self, this._then);

  final InvestmentSummary _self;
  final $Res Function(InvestmentSummary) _then;

/// Create a copy of InvestmentSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBalance = null,Object? categories = null,}) {
  return _then(_self.copyWith(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<InvestmentCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [InvestmentSummary].
extension InvestmentSummaryPatterns on InvestmentSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvestmentSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvestmentSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvestmentSummary value)  $default,){
final _that = this;
switch (_that) {
case _InvestmentSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvestmentSummary value)?  $default,){
final _that = this;
switch (_that) {
case _InvestmentSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalBalance,  List<InvestmentCategory> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvestmentSummary() when $default != null:
return $default(_that.totalBalance,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalBalance,  List<InvestmentCategory> categories)  $default,) {final _that = this;
switch (_that) {
case _InvestmentSummary():
return $default(_that.totalBalance,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalBalance,  List<InvestmentCategory> categories)?  $default,) {final _that = this;
switch (_that) {
case _InvestmentSummary() when $default != null:
return $default(_that.totalBalance,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvestmentSummary implements InvestmentSummary {
  const _InvestmentSummary({required this.totalBalance, required final  List<InvestmentCategory> categories}): _categories = categories;
  factory _InvestmentSummary.fromJson(Map<String, dynamic> json) => _$InvestmentSummaryFromJson(json);

@override final  double totalBalance;
 final  List<InvestmentCategory> _categories;
@override List<InvestmentCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of InvestmentSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvestmentSummaryCopyWith<_InvestmentSummary> get copyWith => __$InvestmentSummaryCopyWithImpl<_InvestmentSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvestmentSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvestmentSummary&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'InvestmentSummary(totalBalance: $totalBalance, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$InvestmentSummaryCopyWith<$Res> implements $InvestmentSummaryCopyWith<$Res> {
  factory _$InvestmentSummaryCopyWith(_InvestmentSummary value, $Res Function(_InvestmentSummary) _then) = __$InvestmentSummaryCopyWithImpl;
@override @useResult
$Res call({
 double totalBalance, List<InvestmentCategory> categories
});




}
/// @nodoc
class __$InvestmentSummaryCopyWithImpl<$Res>
    implements _$InvestmentSummaryCopyWith<$Res> {
  __$InvestmentSummaryCopyWithImpl(this._self, this._then);

  final _InvestmentSummary _self;
  final $Res Function(_InvestmentSummary) _then;

/// Create a copy of InvestmentSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBalance = null,Object? categories = null,}) {
  return _then(_InvestmentSummary(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<InvestmentCategory>,
  ));
}


}


/// @nodoc
mixin _$ExpenseSummary {

 double get totalBalance; List<InvestmentCategory> get categories;
/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSummaryCopyWith<ExpenseSummary> get copyWith => _$ExpenseSummaryCopyWithImpl<ExpenseSummary>(this as ExpenseSummary, _$identity);

  /// Serializes this ExpenseSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummary&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'ExpenseSummary(totalBalance: $totalBalance, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $ExpenseSummaryCopyWith<$Res>  {
  factory $ExpenseSummaryCopyWith(ExpenseSummary value, $Res Function(ExpenseSummary) _then) = _$ExpenseSummaryCopyWithImpl;
@useResult
$Res call({
 double totalBalance, List<InvestmentCategory> categories
});




}
/// @nodoc
class _$ExpenseSummaryCopyWithImpl<$Res>
    implements $ExpenseSummaryCopyWith<$Res> {
  _$ExpenseSummaryCopyWithImpl(this._self, this._then);

  final ExpenseSummary _self;
  final $Res Function(ExpenseSummary) _then;

/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBalance = null,Object? categories = null,}) {
  return _then(_self.copyWith(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<InvestmentCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseSummary].
extension ExpenseSummaryPatterns on ExpenseSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseSummary value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalBalance,  List<InvestmentCategory> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
return $default(_that.totalBalance,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalBalance,  List<InvestmentCategory> categories)  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummary():
return $default(_that.totalBalance,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalBalance,  List<InvestmentCategory> categories)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
return $default(_that.totalBalance,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseSummary implements ExpenseSummary {
  const _ExpenseSummary({required this.totalBalance, required final  List<InvestmentCategory> categories}): _categories = categories;
  factory _ExpenseSummary.fromJson(Map<String, dynamic> json) => _$ExpenseSummaryFromJson(json);

@override final  double totalBalance;
 final  List<InvestmentCategory> _categories;
@override List<InvestmentCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseSummaryCopyWith<_ExpenseSummary> get copyWith => __$ExpenseSummaryCopyWithImpl<_ExpenseSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseSummary&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'ExpenseSummary(totalBalance: $totalBalance, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$ExpenseSummaryCopyWith<$Res> implements $ExpenseSummaryCopyWith<$Res> {
  factory _$ExpenseSummaryCopyWith(_ExpenseSummary value, $Res Function(_ExpenseSummary) _then) = __$ExpenseSummaryCopyWithImpl;
@override @useResult
$Res call({
 double totalBalance, List<InvestmentCategory> categories
});




}
/// @nodoc
class __$ExpenseSummaryCopyWithImpl<$Res>
    implements _$ExpenseSummaryCopyWith<$Res> {
  __$ExpenseSummaryCopyWithImpl(this._self, this._then);

  final _ExpenseSummary _self;
  final $Res Function(_ExpenseSummary) _then;

/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBalance = null,Object? categories = null,}) {
  return _then(_ExpenseSummary(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<InvestmentCategory>,
  ));
}


}

// dart format on
