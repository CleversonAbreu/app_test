class ResultAuthEntity {
  final String token;

  ResultAuthEntity({required this.token});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final ResultAuthEntity otherEntity = other as ResultAuthEntity;
    return token == otherEntity.token;
  }

  @override
  int get hashCode => token.hashCode;
}
