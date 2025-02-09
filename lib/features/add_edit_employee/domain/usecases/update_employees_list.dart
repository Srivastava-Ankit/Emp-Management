import 'package:dartz/dartz.dart';

import '../../../../core/data/entities/employee_data.dart';
import '../../../../core/domain/repositories/employee_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateEmployeeRecord implements UseCase<bool, EmployeeData> {
  final EmployeeRepository employeeRepository;
  UpdateEmployeeRecord(this.employeeRepository);

  @override
  Future<Either<Failure, bool>> call(EmployeeData params) {
    return employeeRepository.updateEmployeeRecord(params);
  }
}
