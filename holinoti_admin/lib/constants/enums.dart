enum AuthMode { signIn, signUp }

enum UserType { admin, manager, employee, customer }

T fromString<T>(Iterable<T> values, String value) =>
    values.firstWhere((type) => type.toString().split(".").last == value,
        orElse: () => null);
