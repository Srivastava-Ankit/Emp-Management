import 'package:hive_flutter/adapters.dart';
import 'package:kiwi/kiwi.dart';

import 'core/data/datasources/local_datasource.dart';
import 'core/data/entities/employee_data.dart';
import 'core/data/repositories/employee_repository_impl.dart';
import 'core/domain/repositories/employee_repository.dart';
import 'features/delete_employee/del_by_id.dart';
import 'features/add_employee/insert_employee_record.dart';
import 'features/home/widget/bloc/home_bloc.dart';
import 'features/update_employee/update_employees_list.dart';
import 'features/add_edit_employee/widget/bloc/add_edit_bloc.dart';
import 'features/delete_employee/del_employee_record.dart';
import 'features/get_employees_list.dart';

Future<void> registerDependencyInjection() async {
  var container = KiwiContainer();
  container.clear();

  await _registerDataSources(container);
  _registerRepositories(container);
  _registerUseCases(container);
  _registerBloc(container);
}

/// Register all Data Sources with the production DI container
Future<void> _registerDataSources(KiwiContainer container) async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeDataAdapter());

  Box box = await Hive.openBox("employees");
  container.registerFactory<LocalDbDataSource>(
      (container) => LocalDbDataSourceImpl(box));
}

/// Register all Repositories with the production DI container
///
/// NOTE: Each repository should be registered against its Superclass to
/// facilitate Dependency Inversion, which is a core concept of the Clean
/// Architecture design pattern that we use throughout the app. Only one
/// repository must be registered for each Superclass/Contract.
void _registerRepositories(KiwiContainer container) {
  container.registerFactory<EmployeeRepository>(
      (c) => EmployeeRepositoryImpl(c.resolve()));
}

/// Register all Use Cases with the production DI container
///
/// Use Cases must be registered as their implementation, not as their
/// Superclass, as their contracts are used for abstraction, not dependency
/// inversion.
void _registerUseCases(KiwiContainer container) {
  container.registerFactory((c) => GetEmployeeList(c.resolve()));
  container.registerFactory((c) => InsertEmployeeRecord(c.resolve()));
  container.registerFactory((c) => UpdateEmployeeRecord(c.resolve()));
  container.registerFactory((c) => DelEmployeeRecord(c.resolve()));
  container.registerFactory((c) => DelEmployeeById(c.resolve()));
}

/// Register BLoCs with the production DI container
///
/// BLoCs must be registered as their concrete class, as their Superclasses are
/// used for abstraction, not dependency inversion.
void _registerBloc(KiwiContainer container) {
  container
      .registerFactory((c) => HomeBloc(c.resolve(), c.resolve(), c.resolve()));
  container.registerFactory(
      (c) => AddEditBloc(c.resolve(), c.resolve(), c.resolve()));
}
