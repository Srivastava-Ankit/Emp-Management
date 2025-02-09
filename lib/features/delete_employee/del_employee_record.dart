

import 'package:dartz/dartz.dart';

import '../../core/data/entities/employee_data.dart';
import '../../core/data/repo/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';

/// This Usecase will be used to Get Profile image saved into Gallery

class DelEmployeeRecord implements UseCase<bool, EmployeeData> {
  final EmployeeRepository employeeRepository;
  DelEmployeeRecord(this.employeeRepository);

  @override
  Future<Either<Failure, bool>> call(EmployeeData params) {
    return employeeRepository.deleteEmployeeRecord(params);
  }
}
