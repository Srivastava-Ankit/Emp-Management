

import 'package:dartz/dartz.dart';

import '../../core/domain/repositories/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';

/// This Usecase will be used to Get Profile image saved into Gallery

class DelEmployeeById implements UseCase<bool, String> {
  final EmployeeRepository employeeRepository;
  DelEmployeeById(this.employeeRepository);

  @override
  Future<Either<Failure, bool>> call(String params) {
    return employeeRepository.deleteEmployeeById(params);
  }
}
