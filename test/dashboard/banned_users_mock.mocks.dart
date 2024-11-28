// Mocks generated by Mockito 5.4.4 from annotations
// in telegram/test/dashboard/banned_users_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:connectivity_plus/connectivity_plus.dart' as _i7;
import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:telegram/core/error/faliure.dart' as _i9;
import 'package:telegram/core/network/network_manager.dart' as _i6;
import 'package:telegram/feature/dashboard/data/model/user_model.dart' as _i10;
import 'package:telegram/feature/dashboard/domain/repository/dashboard_local_repo.dart'
    as _i5;
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart'
    as _i3;
import 'package:telegram/feature/dashboard/domain/use_cases/local_use_case/get_users.dart'
    as _i12;
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_users.dart'
    as _i8;
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/unban_user.dart'
    as _i11;

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

class _FakeStreamSubscription_0<T> extends _i1.SmartFake
    implements _i2.StreamSubscription<T> {
  _FakeStreamSubscription_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDashboardRepo_1 extends _i1.SmartFake implements _i3.DashboardRepo {
  _FakeDashboardRepo_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDashboardLocalRepo_3 extends _i1.SmartFake
    implements _i5.DashboardLocalRepo {
  _FakeDashboardLocalRepo_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NetworkManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkManager extends _i1.Mock implements _i6.NetworkManager {
  MockNetworkManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.ConnectivityResult get connectionStatus => (super.noSuchMethod(
        Invocation.getter(#connectionStatus),
        returnValue: _i7.ConnectivityResult.bluetooth,
      ) as _i7.ConnectivityResult);

  @override
  set connectionStatus(_i7.ConnectivityResult? _connectionStatus) =>
      super.noSuchMethod(
        Invocation.setter(
          #connectionStatus,
          _connectionStatus,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.StreamSubscription<List<_i7.ConnectivityResult>>
      get connectivitySubscription => (super.noSuchMethod(
            Invocation.getter(#connectivitySubscription),
            returnValue:
                _FakeStreamSubscription_0<List<_i7.ConnectivityResult>>(
              this,
              Invocation.getter(#connectivitySubscription),
            ),
          ) as _i2.StreamSubscription<List<_i7.ConnectivityResult>>);

  @override
  set connectivitySubscription(
          _i2.StreamSubscription<List<_i7.ConnectivityResult>>?
              _connectivitySubscription) =>
      super.noSuchMethod(
        Invocation.setter(
          #connectivitySubscription,
          _connectivitySubscription,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.Stream<_i7.ConnectivityResult> get connectionStatusStream =>
      (super.noSuchMethod(
        Invocation.getter(#connectionStatusStream),
        returnValue: _i2.Stream<_i7.ConnectivityResult>.empty(),
      ) as _i2.Stream<_i7.ConnectivityResult>);

  @override
  _i2.Future<bool> isConnected() => (super.noSuchMethod(
        Invocation.method(
          #isConnected,
          [],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [GetUsersUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsersUseCase extends _i1.Mock implements _i8.GetUsersUseCase {
  MockGetUsersUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.DashboardRepo get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDashboardRepo_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.DashboardRepo);

  @override
  _i2.Future<_i4.Either<_i9.Failure, List<_i10.UserModel>>> call() =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue:
            _i2.Future<_i4.Either<_i9.Failure, List<_i10.UserModel>>>.value(
                _FakeEither_2<_i9.Failure, List<_i10.UserModel>>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i2.Future<_i4.Either<_i9.Failure, List<_i10.UserModel>>>);
}

/// A class which mocks [UnBanUserUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUnBanUserUseCase extends _i1.Mock implements _i11.UnBanUserUseCase {
  MockUnBanUserUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.DashboardRepo get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDashboardRepo_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.DashboardRepo);

  @override
  _i2.Future<_i4.Either<_i9.Failure, bool>> call(String? userID) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [userID],
        ),
        returnValue: _i2.Future<_i4.Either<_i9.Failure, bool>>.value(
            _FakeEither_2<_i9.Failure, bool>(
          this,
          Invocation.method(
            #call,
            [userID],
          ),
        )),
      ) as _i2.Future<_i4.Either<_i9.Failure, bool>>);
}

/// A class which mocks [GetUsersLocalUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsersLocalUseCase extends _i1.Mock
    implements _i12.GetUsersLocalUseCase {
  MockGetUsersLocalUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.DashboardLocalRepo get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDashboardLocalRepo_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.DashboardLocalRepo);

  @override
  _i2.Future<List<_i10.UserModel>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i2.Future<List<_i10.UserModel>>.value(<_i10.UserModel>[]),
      ) as _i2.Future<List<_i10.UserModel>>);
}
