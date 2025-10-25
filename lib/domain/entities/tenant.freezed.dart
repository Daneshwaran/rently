// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Tenant _$TenantFromJson(Map<String, dynamic> json) {
  return _Tenant.fromJson(json);
}

/// @nodoc
mixin _$Tenant {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get houseId => throw _privateConstructorUsedError;
  DateTime get moveInDate => throw _privateConstructorUsedError;
  double get rentAmount => throw _privateConstructorUsedError;
  double get securityDeposit => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Tenant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantCopyWith<Tenant> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantCopyWith<$Res> {
  factory $TenantCopyWith(Tenant value, $Res Function(Tenant) then) =
      _$TenantCopyWithImpl<$Res, Tenant>;
  @useResult
  $Res call({
    String? id,
    String name,
    String houseId,
    DateTime moveInDate,
    double rentAmount,
    double securityDeposit,
    bool isActive,
    String? phoneNumber,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$TenantCopyWithImpl<$Res, $Val extends Tenant>
    implements $TenantCopyWith<$Res> {
  _$TenantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? houseId = null,
    Object? moveInDate = null,
    Object? rentAmount = null,
    Object? securityDeposit = null,
    Object? isActive = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            houseId: null == houseId
                ? _value.houseId
                : houseId // ignore: cast_nullable_to_non_nullable
                      as String,
            moveInDate: null == moveInDate
                ? _value.moveInDate
                : moveInDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            rentAmount: null == rentAmount
                ? _value.rentAmount
                : rentAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            securityDeposit: null == securityDeposit
                ? _value.securityDeposit
                : securityDeposit // ignore: cast_nullable_to_non_nullable
                      as double,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$TenantImplCopyWith<$Res> implements $TenantCopyWith<$Res> {
  factory _$$TenantImplCopyWith(
    _$TenantImpl value,
    $Res Function(_$TenantImpl) then,
  ) = __$$TenantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String name,
    String houseId,
    DateTime moveInDate,
    double rentAmount,
    double securityDeposit,
    bool isActive,
    String? phoneNumber,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$TenantImplCopyWithImpl<$Res>
    extends _$TenantCopyWithImpl<$Res, _$TenantImpl>
    implements _$$TenantImplCopyWith<$Res> {
  __$$TenantImplCopyWithImpl(
    _$TenantImpl _value,
    $Res Function(_$TenantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? houseId = null,
    Object? moveInDate = null,
    Object? rentAmount = null,
    Object? securityDeposit = null,
    Object? isActive = null,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TenantImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        houseId: null == houseId
            ? _value.houseId
            : houseId // ignore: cast_nullable_to_non_nullable
                  as String,
        moveInDate: null == moveInDate
            ? _value.moveInDate
            : moveInDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        rentAmount: null == rentAmount
            ? _value.rentAmount
            : rentAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        securityDeposit: null == securityDeposit
            ? _value.securityDeposit
            : securityDeposit // ignore: cast_nullable_to_non_nullable
                  as double,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$TenantImpl implements _Tenant {
  const _$TenantImpl({
    this.id,
    required this.name,
    required this.houseId,
    required this.moveInDate,
    required this.rentAmount,
    required this.securityDeposit,
    required this.isActive,
    this.phoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory _$TenantImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String houseId;
  @override
  final DateTime moveInDate;
  @override
  final double rentAmount;
  @override
  final double securityDeposit;
  @override
  final bool isActive;
  @override
  final String? phoneNumber;
  @override
  final String? email;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Tenant(id: $id, name: $name, houseId: $houseId, moveInDate: $moveInDate, rentAmount: $rentAmount, securityDeposit: $securityDeposit, isActive: $isActive, phoneNumber: $phoneNumber, email: $email, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.houseId, houseId) || other.houseId == houseId) &&
            (identical(other.moveInDate, moveInDate) ||
                other.moveInDate == moveInDate) &&
            (identical(other.rentAmount, rentAmount) ||
                other.rentAmount == rentAmount) &&
            (identical(other.securityDeposit, securityDeposit) ||
                other.securityDeposit == securityDeposit) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
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
    houseId,
    moveInDate,
    rentAmount,
    securityDeposit,
    isActive,
    phoneNumber,
    email,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      __$$TenantImplCopyWithImpl<_$TenantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantImplToJson(this);
  }
}

abstract class _Tenant implements Tenant {
  const factory _Tenant({
    final String? id,
    required final String name,
    required final String houseId,
    required final DateTime moveInDate,
    required final double rentAmount,
    required final double securityDeposit,
    required final bool isActive,
    final String? phoneNumber,
    final String? email,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$TenantImpl;

  factory _Tenant.fromJson(Map<String, dynamic> json) = _$TenantImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get houseId;
  @override
  DateTime get moveInDate;
  @override
  double get rentAmount;
  @override
  double get securityDeposit;
  @override
  bool get isActive;
  @override
  String? get phoneNumber;
  @override
  String? get email;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
