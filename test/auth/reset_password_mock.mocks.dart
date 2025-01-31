// Mocks generated by Mockito 5.4.4 from annotations
// in telegram/test/auth/reset_password_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:connectivity_plus/connectivity_plus.dart' as _i8;
import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter/material.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:telegram/core/error/faliure.dart' as _i6;
import 'package:telegram/core/network/network_manager.dart' as _i7;
import 'package:telegram/core/validator/app_validator.dart' as _i9;
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart'
    as _i2;
import 'package:telegram/feature/auth/forget_password/domain/usecase/log_out_use_case.dart'
    as _i11;
import 'package:telegram/feature/auth/forget_password/domain/usecase/reset_password_use_case.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeForgetPasswordRepository_0 extends _i1.SmartFake
    implements _i2.ForgetPasswordRepository {
  _FakeForgetPasswordRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamSubscription_2<T> extends _i1.SmartFake
    implements _i4.StreamSubscription<T> {
  _FakeStreamSubscription_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ResetPasswordUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockResetPasswordUseCase extends _i1.Mock
    implements _i5.ResetPasswordUseCase {
  MockResetPasswordUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ForgetPasswordRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeForgetPasswordRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ForgetPasswordRepository);

  @override
  _i4.Future<_i3.Either<_i6.Failure, void>> call(
    String? parameter1,
    String? parameter2,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [
            parameter1,
            parameter2,
          ],
        ),
        returnValue: _i4.Future<_i3.Either<_i6.Failure, void>>.value(
            _FakeEither_1<_i6.Failure, void>(
          this,
          Invocation.method(
            #call,
            [
              parameter1,
              parameter2,
            ],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i6.Failure, void>>);
}

/// A class which mocks [NetworkManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkManager extends _i1.Mock implements _i7.NetworkManager {
  MockNetworkManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.ConnectivityResult get connectionStatus => (super.noSuchMethod(
        Invocation.getter(#connectionStatus),
        returnValue: _i8.ConnectivityResult.bluetooth,
      ) as _i8.ConnectivityResult);

  @override
  set connectionStatus(_i8.ConnectivityResult? _connectionStatus) =>
      super.noSuchMethod(
        Invocation.setter(
          #connectionStatus,
          _connectionStatus,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.StreamSubscription<List<_i8.ConnectivityResult>>
      get connectivitySubscription => (super.noSuchMethod(
            Invocation.getter(#connectivitySubscription),
            returnValue:
                _FakeStreamSubscription_2<List<_i8.ConnectivityResult>>(
              this,
              Invocation.getter(#connectivitySubscription),
            ),
          ) as _i4.StreamSubscription<List<_i8.ConnectivityResult>>);

  @override
  set connectivitySubscription(
          _i4.StreamSubscription<List<_i8.ConnectivityResult>>?
              _connectivitySubscription) =>
      super.noSuchMethod(
        Invocation.setter(
          #connectivitySubscription,
          _connectivitySubscription,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Stream<_i8.ConnectivityResult> get connectionStatusStream =>
      (super.noSuchMethod(
        Invocation.getter(#connectionStatusStream),
        returnValue: _i4.Stream<_i8.ConnectivityResult>.empty(),
      ) as _i4.Stream<_i8.ConnectivityResult>);

  @override
  _i4.Future<bool> isConnected() => (super.noSuchMethod(
        Invocation.method(
          #isConnected,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AppValidator].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppValidator extends _i1.Mock implements _i9.AppValidator {
  MockAppValidator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool isFormValid(_i10.GlobalKey<_i10.FormState>? formKey) =>
      (super.noSuchMethod(
        Invocation.method(
          #isFormValid,
          [formKey],
        ),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [LogOutUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogOutUseCase extends _i1.Mock implements _i11.LogOutUseCase {
  MockLogOutUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ForgetPasswordRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeForgetPasswordRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.ForgetPasswordRepository);

  @override
  _i4.Future<_i3.Either<_i6.Failure, void>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i4.Future<_i3.Either<_i6.Failure, void>>.value(
            _FakeEither_1<_i6.Failure, void>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i6.Failure, void>>);
}
