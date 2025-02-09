

import 'package:dartz/dartz.dart';

import '../../core/data/entities/employee_data.dart';
import '../../core/data/repo/employee_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';


class InsertEmployeeRecord implements UseCase<bool, EmployeeData> {
  final EmployeeRepository employeeRepository;
  InsertEmployeeRecord(this.employeeRepository);

  @override
  Future<Either<Failure, bool>> call(EmployeeData params) {
    return employeeRepository.insertEmployeeRecord(params);
  }
}
