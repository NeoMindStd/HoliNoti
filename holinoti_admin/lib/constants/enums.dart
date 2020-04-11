enum AuthMode { login, register }

enum Authority { admin, normal }

enum Role { supervisor, manager, customer }

T fromString<T>(Iterable<T> values, String value) =>
    values.firstWhere((type) => type.toString().split(".").last == value,
        orElse: () => null);
