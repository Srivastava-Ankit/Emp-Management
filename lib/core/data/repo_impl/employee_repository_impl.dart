

import 'package:dartz/dartz.dart';
import '../repo/employee_repository.dart';
import '../../errors/failures.dart';
import '../datasources/local_datasource.dart';
import '../entities/employee_data.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final LocalDbDataSource localDbDataSource;
  EmployeeRepositoryImpl(this.localDbDataSource);

  @override
  Future<Either<Failure, bool>> deleteEmployeeRecord(
      EmployeeData employeeData) async {
    return Right(await localDbDataSource.delEmployeeRecord(employeeData));
  }

  @override
  Future<Either<Failure, List<EmployeeData>>> getAllRecords() async {
    final allRecords = await localDbDataSource.getAllRecords();
    List<EmployeeData> employeesList = [];
    for (var element in allRecords) {
      final e = element as EmployeeData;
      employeesList.add(e);
    }

    return Right(employeesList);
  }

  @override
  Future<Either<Failure, bool>> insertEmployeeRecord(
      EmployeeData employee) async {
    return Right(await localDbDataSource.insertEmployeeRecord(employee));
  }

  @override
  Future<Either<Failure, bool>> updateEmployeeRecord(
      EmployeeData employee) async {
    return Right(await localDbDataSource.updateEmployeeRecord(employee));
  }

  @override
  Future<Either<Failure, bool>> deleteEmployeeById(
      String uuid) async {
    await localDbDataSource.deleteRecordById(uuid);
    return const Right(true);
  }
}
