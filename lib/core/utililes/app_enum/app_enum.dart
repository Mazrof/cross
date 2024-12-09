enum LoginStatusEnum {
  init,
  loading,
  success,
  error,
  suspended,
  suspendedComplete,
  idle,
}

enum CubitState {
  initial,
  loading,
  success,
  failure,
}

enum MessageStatus { loading, sent, delivered, read }

enum ChatType{
  PersonalChat,
  Group,
  Channel
}