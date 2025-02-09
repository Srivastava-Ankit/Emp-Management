

import 'package:dartz/dartz.dart';

import '../../../../core/data/entities/employee_data.dart';
import '../../../../core/domain/repositories/employee_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// This Usecase will be used to Get Profile image saved into Gallery

class InsertEmployeeRecord implements UseCase<bool, EmployeeData> {
  final EmployeeRepository employeeRepository;
  InsertEmployeeRecord(this.employeeRepository);

  @override
  Future<Either<Failure, bool>> call(EmployeeData params) {
    return employeeRepository.insertEmployeeRecord(params);
  }
}
