enum AuthMode { login, register }

enum Authority { admin, normal }

enum Role { supervisor, manager, customer }

enum SecondPassMode { verify, init, initCheck }

String toString<T>(T value) => value.toString().split(".").last;

T fromString<T>(Iterable<T> values, String value) =>
    values.firstWhere((type) => toString(type) == value, orElse: () => null);
