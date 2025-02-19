
import 'package:equatable/equatable.dart';

import '../../../../core/data/entities/employee_data.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomePageOpened extends HomeEvent {
  @override
  String toString() {
    return "HomePageOpened";
  }
}

class DelEmployeeTapped extends HomeEvent {
  final EmployeeData employeeData;
  DelEmployeeTapped(this.employeeData);
  @override
  String toString() {
    return "DelEmployeeTapped";
  }
}

class UndoDelEmployeeTapped extends HomeEvent {
  @override
  String toString() {
    return "UndoDelEmployeeTapped";
  }
}
