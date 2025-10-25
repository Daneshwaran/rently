// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'house.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

House _$HouseFromJson(Map<String, dynamic> json) {
  return _House.fromJson(json);
}

/// @nodoc
mixin _$House {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get monthlyRent => throw _privateConstructorUsedError;
  double get securityDeposit => throw _privateConstructorUsedError;
  DateTime get rentDueDate => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this House to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of House
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HouseCopyWith<House> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseCopyWith<$Res> {
  factory $HouseCopyWith(House value, $Res Function(House) then) =
      _$HouseCopyWithImpl<$Res, House>;
  @useResult
  $Res call({
    String id,
    String name,
    double monthlyRent,
    double securityDeposit,
    DateTime rentDueDate,
    bool isAvailable,
    String description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$HouseCopyWithImpl<$Res, $Val extends House>
    implements $HouseCopyWith<$Res> {
  _$HouseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of House
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? monthlyRent = null,
    Object? securityDeposit = null,
    Object? rentDueDate = null,
    Object? isAvailable = null,
    Object? description = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            monthlyRent: null == monthlyRent
                ? _value.monthlyRent
                : monthlyRent // ignore: cast_nullable_to_non_nullable
                      as double,
            securityDeposit: null == securityDeposit
                ? _value.securityDeposit
                : securityDeposit // ignore: cast_nullable_to_non_nullable
                      as double,
            rentDueDate: null == rentDueDate
                ? _value.rentDueDate
                : rentDueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HouseImplCopyWith<$Res> implements $HouseCopyWith<$Res> {
  factory _$$HouseImplCopyWith(
    _$HouseImpl value,
    $Res Function(_$HouseImpl) then,
  ) = __$$HouseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double monthlyRent,
    double securityDeposit,
    DateTime rentDueDate,
    bool isAvailable,
    String description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$HouseImplCopyWithImpl<$Res>
    extends _$HouseCopyWithImpl<$Res, _$HouseImpl>
    implements _$$HouseImplCopyWith<$Res> {
  __$$HouseImplCopyWithImpl(
    _$HouseImpl _value,
    $Res Function(_$HouseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of House
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? monthlyRent = null,
    Object? securityDeposit = null,
    Object? rentDueDate = null,
    Object? isAvailable = null,
    Object? description = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$HouseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        monthlyRent: null == monthlyRent
            ? _value.monthlyRent
            : monthlyRent // ignore: cast_nullable_to_non_nullable
                  as double,
        securityDeposit: null == securityDeposit
            ? _value.securityDeposit
            : securityDeposit // ignore: cast_nullable_to_non_nullable
                  as double,
        rentDueDate: null == rentDueDate
            ? _value.rentDueDate
            : rentDueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HouseImpl implements _House {
  const _$HouseImpl({
    required this.id,
    required this.name,
    required this.monthlyRent,
    required this.securityDeposit,
    required this.rentDueDate,
    required this.isAvailable,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory _$HouseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HouseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double monthlyRent;
  @override
  final double securityDeposit;
  @override
  final DateTime rentDueDate;
  @override
  final bool isAvailable;
  @override
  final String description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'House(id: $id, name: $name, monthlyRent: $monthlyRent, securityDeposit: $securityDeposit, rentDueDate: $rentDueDate, isAvailable: $isAvailable, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HouseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.monthlyRent, monthlyRent) ||
                other.monthlyRent == monthlyRent) &&
            (identical(other.securityDeposit, securityDeposit) ||
                other.securityDeposit == securityDeposit) &&
            (identical(other.rentDueDate, rentDueDate) ||
                other.rentDueDate == rentDueDate) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    monthlyRent,
    securityDeposit,
    rentDueDate,
    isAvailable,
    description,
    createdAt,
    updatedAt,
  );

  /// Create a copy of House
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HouseImplCopyWith<_$HouseImpl> get copyWith =>
      __$$HouseImplCopyWithImpl<_$HouseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HouseImplToJson(this);
  }
}

abstract class _House implements House {
  const factory _House({
    required final String id,
    required final String name,
    required final double monthlyRent,
    required final double securityDeposit,
    required final DateTime rentDueDate,
    required final bool isAvailable,
    required final String description,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$HouseImpl;

  factory _House.fromJson(Map<String, dynamic> json) = _$HouseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get monthlyRent;
  @override
  double get securityDeposit;
  @override
  DateTime get rentDueDate;
  @override
  bool get isAvailable;
  @override
  String get description;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of House
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HouseImplCopyWith<_$HouseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
