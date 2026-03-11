// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'style_preference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StylePreferenceModel {

 String get id; String get name;@JsonKey(name: 'is_selected') bool get isSelected;
/// Create a copy of StylePreferenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StylePreferenceModelCopyWith<StylePreferenceModel> get copyWith => _$StylePreferenceModelCopyWithImpl<StylePreferenceModel>(this as StylePreferenceModel, _$identity);

  /// Serializes this StylePreferenceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StylePreferenceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isSelected);

@override
String toString() {
  return 'StylePreferenceModel(id: $id, name: $name, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class $StylePreferenceModelCopyWith<$Res>  {
  factory $StylePreferenceModelCopyWith(StylePreferenceModel value, $Res Function(StylePreferenceModel) _then) = _$StylePreferenceModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'is_selected') bool isSelected
});




}
/// @nodoc
class _$StylePreferenceModelCopyWithImpl<$Res>
    implements $StylePreferenceModelCopyWith<$Res> {
  _$StylePreferenceModelCopyWithImpl(this._self, this._then);

  final StylePreferenceModel _self;
  final $Res Function(StylePreferenceModel) _then;

/// Create a copy of StylePreferenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isSelected = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StylePreferenceModel].
extension StylePreferenceModelPatterns on StylePreferenceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StylePreferenceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StylePreferenceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StylePreferenceModel value)  $default,){
final _that = this;
switch (_that) {
case _StylePreferenceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StylePreferenceModel value)?  $default,){
final _that = this;
switch (_that) {
case _StylePreferenceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'is_selected')  bool isSelected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StylePreferenceModel() when $default != null:
return $default(_that.id,_that.name,_that.isSelected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'is_selected')  bool isSelected)  $default,) {final _that = this;
switch (_that) {
case _StylePreferenceModel():
return $default(_that.id,_that.name,_that.isSelected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'is_selected')  bool isSelected)?  $default,) {final _that = this;
switch (_that) {
case _StylePreferenceModel() when $default != null:
return $default(_that.id,_that.name,_that.isSelected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StylePreferenceModel implements StylePreferenceModel {
  const _StylePreferenceModel({required this.id, required this.name, @JsonKey(name: 'is_selected') this.isSelected = false});
  factory _StylePreferenceModel.fromJson(Map<String, dynamic> json) => _$StylePreferenceModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'is_selected') final  bool isSelected;

/// Create a copy of StylePreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StylePreferenceModelCopyWith<_StylePreferenceModel> get copyWith => __$StylePreferenceModelCopyWithImpl<_StylePreferenceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StylePreferenceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StylePreferenceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isSelected);

@override
String toString() {
  return 'StylePreferenceModel(id: $id, name: $name, isSelected: $isSelected)';
}


}

/// @nodoc
abstract mixin class _$StylePreferenceModelCopyWith<$Res> implements $StylePreferenceModelCopyWith<$Res> {
  factory _$StylePreferenceModelCopyWith(_StylePreferenceModel value, $Res Function(_StylePreferenceModel) _then) = __$StylePreferenceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'is_selected') bool isSelected
});




}
/// @nodoc
class __$StylePreferenceModelCopyWithImpl<$Res>
    implements _$StylePreferenceModelCopyWith<$Res> {
  __$StylePreferenceModelCopyWithImpl(this._self, this._then);

  final _StylePreferenceModel _self;
  final $Res Function(_StylePreferenceModel) _then;

/// Create a copy of StylePreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isSelected = null,}) {
  return _then(_StylePreferenceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
