

import 'package:equatable/equatable.dart';

import '../../../../core/data/entities/employee_data.dart';

class AddEditEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEditPageOpened extends AddEditEvent {
  final EmployeeData? employeeData;
  AddEditPageOpened(this.employeeData);
  @override
  String toString() {
    return "AddEditPageOpened";
  }
}

class DelEmployeeButtonTapped extends AddEditEvent {
  @override
  String toString() {
    return "DelButtonTapped";
  }
}

class UndoDelButtonTapped extends AddEditEvent {
  @override
  String toString() {
    return "UndoDelButtonTapped";
  }
}

class AddEmployeeButtonTapped extends AddEditEvent {
  @override
  String toString() {
    return "AddEmployeeButtonTapped";
  }
}
