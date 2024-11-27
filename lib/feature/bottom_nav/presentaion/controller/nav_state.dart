class NavState {
  final int index;

  NavState({required this.index});

  NavState copyWith({int? index}) {
    return NavState(
      index: index ?? this.index,
    );
  }
}
