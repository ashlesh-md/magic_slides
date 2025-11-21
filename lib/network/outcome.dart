sealed class Outcome<T> {
  const Outcome();
}

class Success<T> extends Outcome<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Outcome<T> {
  final String reason;
  const Failure(this.reason);
}
