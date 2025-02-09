
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class UseCase<T, Params> {
  /// Implement the async `call` method to implement a Use Case.
  Future<Either<Failure, T>> call(Params params);
}

/// No-op Use Case Parameter class to avoid using nullable types
class NoParams extends Equatable {
  @override
  List<Object> get props => [dynamic];
}
