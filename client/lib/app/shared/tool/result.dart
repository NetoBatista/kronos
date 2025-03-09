sealed class Result<TSuccess, TFailure> {
  TSuccess? success() {
    if (this is Success) {
      return (this as Success)._value;
    }
    return null;
  }

  TFailure? failure() {
    if (this is Failure) {
      return (this as Failure)._value;
    }
    return null;
  }
}

class Success<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  final TSuccess _value;
  Success(this._value);
}

class Failure<TSuccess, TFailure> extends Result<TSuccess, TFailure> {
  final TFailure _value;
  Failure(this._value);
}
