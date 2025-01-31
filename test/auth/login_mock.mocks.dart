// Mocks generated by Mockito 5.4.4 from annotations
// in telegram/test/auth/login_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:connectivity_plus/connectivity_plus.dart' as _i11;
import 'package:dartz/dartz.dart' as _i3;
import 'package:flutter/foundation.dart' as _i6;
import 'package:flutter/material.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:telegram/core/error/faliure.dart' as _i8;
import 'package:telegram/core/network/network_manager.dart' as _i10;
import 'package:telegram/core/validator/app_validator.dart' as _i12;
import 'package:telegram/feature/auth/login/data/model/login_request_model.dart'
    as _i9;
import 'package:telegram/feature/auth/login/domain/repositories/base_repo.dart'
    as _i2;
import 'package:telegram/feature/auth/login/domain/use_cases/login_use_case.dart'
    as _i7;
import 'package:telegram/feature/auth/login/domain/use_cases/login_with_github_use_case.dart'
    as _i14;
import 'package:telegram/feature/auth/login/domain/use_cases/login_with_google_use_case.dart'
    as _i13;

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

class _FakeLoginRepository_0 extends _i1.SmartFake
    implements _i2.LoginRepository {
  _FakeLoginRepository_0(
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

class _FakeWidget_3 extends _i1.SmartFake implements _i5.Widget {
  _FakeWidget_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_4 extends _i1.SmartFake
    implements _i5.InheritedWidget {
  _FakeInheritedWidget_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_5 extends _i1.SmartFake
    implements _i5.DiagnosticsNode {
  _FakeDiagnosticsNode_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i6.TextTreeConfiguration? parentConfiguration,
    _i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info,
  }) =>
      super.toString();
}

/// A class which mocks [LoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUseCase extends _i1.Mock implements _i7.LoginUseCase {
  MockLoginUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginRepository get loginRepository => (super.noSuchMethod(
        Invocation.getter(#loginRepository),
        returnValue: _FakeLoginRepository_0(
          this,
          Invocation.getter(#loginRepository),
        ),
      ) as _i2.LoginRepository);

  @override
  _i4.Future<_i3.Either<_i8.Failure, bool>> call(
          _i9.LoginRequestBody? loginModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [loginModel],
        ),
        returnValue: _i4.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #call,
            [loginModel],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i8.Failure, bool>>);
}

/// A class which mocks [NetworkManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkManager extends _i1.Mock implements _i10.NetworkManager {
  MockNetworkManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.ConnectivityResult get connectionStatus => (super.noSuchMethod(
        Invocation.getter(#connectionStatus),
        returnValue: _i11.ConnectivityResult.bluetooth,
      ) as _i11.ConnectivityResult);

  @override
  set connectionStatus(_i11.ConnectivityResult? _connectionStatus) =>
      super.noSuchMethod(
        Invocation.setter(
          #connectionStatus,
          _connectionStatus,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.StreamSubscription<List<_i11.ConnectivityResult>>
      get connectivitySubscription => (super.noSuchMethod(
            Invocation.getter(#connectivitySubscription),
            returnValue:
                _FakeStreamSubscription_2<List<_i11.ConnectivityResult>>(
              this,
              Invocation.getter(#connectivitySubscription),
            ),
          ) as _i4.StreamSubscription<List<_i11.ConnectivityResult>>);

  @override
  set connectivitySubscription(
          _i4.StreamSubscription<List<_i11.ConnectivityResult>>?
              _connectivitySubscription) =>
      super.noSuchMethod(
        Invocation.setter(
          #connectivitySubscription,
          _connectivitySubscription,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Stream<_i11.ConnectivityResult> get connectionStatusStream =>
      (super.noSuchMethod(
        Invocation.getter(#connectionStatusStream),
        returnValue: _i4.Stream<_i11.ConnectivityResult>.empty(),
      ) as _i4.Stream<_i11.ConnectivityResult>);

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
class MockAppValidator extends _i1.Mock implements _i12.AppValidator {
  MockAppValidator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool isFormValid(_i5.GlobalKey<_i5.FormState>? formKey) =>
      (super.noSuchMethod(
        Invocation.method(
          #isFormValid,
          [formKey],
        ),
        returnValue: false,
      ) as bool);
}

/// A class which mocks [LoginWithGoogleUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginWithGoogleUseCase extends _i1.Mock
    implements _i13.LoginWithGoogleUseCase {
  MockLoginWithGoogleUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginRepository get loginRepository => (super.noSuchMethod(
        Invocation.getter(#loginRepository),
        returnValue: _FakeLoginRepository_0(
          this,
          Invocation.getter(#loginRepository),
        ),
      ) as _i2.LoginRepository);

  @override
  _i4.Future<_i3.Either<_i8.Failure, String>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i4.Future<_i3.Either<_i8.Failure, String>>.value(
            _FakeEither_1<_i8.Failure, String>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i8.Failure, String>>);
}

/// A class which mocks [LoginWithGithubUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginWithGithubUseCase extends _i1.Mock
    implements _i14.LoginWithGithubUseCase {
  MockLoginWithGithubUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginRepository get loginRepository => (super.noSuchMethod(
        Invocation.getter(#loginRepository),
        returnValue: _FakeLoginRepository_0(
          this,
          Invocation.getter(#loginRepository),
        ),
      ) as _i2.LoginRepository);

  @override
  _i4.Future<_i3.Either<_i8.Failure, String>> call(_i5.BuildContext? context) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [context],
        ),
        returnValue: _i4.Future<_i3.Either<_i8.Failure, String>>.value(
            _FakeEither_1<_i8.Failure, String>(
          this,
          Invocation.method(
            #call,
            [context],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i8.Failure, String>>);
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i5.BuildContext {
  MockBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Widget get widget => (super.noSuchMethod(
        Invocation.getter(#widget),
        returnValue: _FakeWidget_3(
          this,
          Invocation.getter(#widget),
        ),
      ) as _i5.Widget);

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);

  @override
  bool get debugDoingBuild => (super.noSuchMethod(
        Invocation.getter(#debugDoingBuild),
        returnValue: false,
      ) as bool);

  @override
  _i5.InheritedWidget dependOnInheritedElement(
    _i5.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #dependOnInheritedElement,
          [ancestor],
          {#aspect: aspect},
        ),
        returnValue: _FakeInheritedWidget_4(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
      ) as _i5.InheritedWidget);

  @override
  void visitAncestorElements(_i5.ConditionalElementVisitor? visitor) =>
      super.noSuchMethod(
        Invocation.method(
          #visitAncestorElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void visitChildElements(_i5.ElementVisitor? visitor) => super.noSuchMethod(
        Invocation.method(
          #visitChildElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispatchNotification(_i5.Notification? notification) =>
      super.noSuchMethod(
        Invocation.method(
          #dispatchNotification,
          [notification],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.DiagnosticsNode describeElement(
    String? name, {
    _i6.DiagnosticsTreeStyle? style = _i6.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeElement,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeElement,
            [name],
            {#style: style},
          ),
        ),
      ) as _i5.DiagnosticsNode);

  @override
  _i5.DiagnosticsNode describeWidget(
    String? name, {
    _i6.DiagnosticsTreeStyle? style = _i6.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeWidget,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeWidget,
            [name],
            {#style: style},
          ),
        ),
      ) as _i5.DiagnosticsNode);

  @override
  List<_i5.DiagnosticsNode> describeMissingAncestor(
          {required Type? expectedAncestorType}) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeMissingAncestor,
          [],
          {#expectedAncestorType: expectedAncestorType},
        ),
        returnValue: <_i5.DiagnosticsNode>[],
      ) as List<_i5.DiagnosticsNode>);

  @override
  _i5.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeOwnershipChain,
          [name],
        ),
        returnValue: _FakeDiagnosticsNode_5(
          this,
          Invocation.method(
            #describeOwnershipChain,
            [name],
          ),
        ),
      ) as _i5.DiagnosticsNode);
}
