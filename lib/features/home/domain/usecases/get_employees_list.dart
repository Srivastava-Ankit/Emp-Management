

import 'package:dartz/dartz.dart';

import '../../../../core/data/entities/employee_data.dart';
import '../../../../core/domain/repositories/employee_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetEmployeeList implements UseCase<List<EmployeeData>, NoParams> {
  final EmployeeRepository employeeRepository;
  GetEmployeeList(this.employeeRepository);

  @override
  Future<Either<Failure, List<EmployeeData>>> call(NoParams params) {
    return employeeRepository.getAllRecords();
  }
}
