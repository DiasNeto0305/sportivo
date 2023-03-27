class AuthException implements Exception {
  static const Map<String, String> errors = {
    'email-already-in-use': 'E-mail já cadastrado',
    'weak-password': 'Senha Fraca',
    'operation-not-allowed': 'Operação não permitida',
    'user-not-found': 'Usuáirio não encontrado',
    'wrong-password': 'Senha incorreta',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autentificação';
  }
}
