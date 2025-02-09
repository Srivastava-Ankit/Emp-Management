import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/entities/employee_data.dart';
import '../../../../core/errors/failures.dart';
import '../../add_employee/insert_employee_record.dart';
import '../../delete_employee/del_by_id.dart';
import '../../update_employee/update_employees_list.dart';
import 'add_edit_event.dart';
import 'add_edit_state.dart';

/// Bloc for conversions widget
///
class AddEditBloc extends Bloc<AddEditEvent, AddEditState> {
  final InsertEmployeeRecord _insertEmployeeRecord;
  final UpdateEmployeeRecord _updateEmployeeRecord;
  final DelEmployeeById _delEmployeeById;

  AddEditBloc(this._insertEmployeeRecord, this._updateEmployeeRecord, this._delEmployeeById)
      : super(AddEditPageInitial()) {
    // Handle Events
    on<AddEditPageOpened>(_onPageOpened);
    on<DelEmployeeButtonTapped>(_onDeleteEmployee);
    on<UndoDelButtonTapped>(_onUndoDelete);
    on<AddEmployeeButtonTapped>(_onAddEmployee);
  }

  bool _isInEditMode = false;
  bool _canUndo = false;
  String uuid = "";
  DateTime? fromDateTime;
  DateTime? toDateTime;

  get isInEditMode => _isInEditMode;
  get canUndo => _canUndo;

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  final roles = ["Product Designer", "Flutter Developer", "QA Tester", "Product Owner"];

  bool get isValidationSuccess {
    return nameController.text.isNotEmpty &&
        roleController.text.isNotEmpty &&
        fromDateTime != null;
  }

  /// Handler for `AddEditPageOpened` Event
  Future<void> _onPageOpened(AddEditPageOpened event, Emitter<AddEditState> emit) async {
    emit(AddEditPageLoadInProgress());

    EmployeeData? employeeData = event.employeeData;
    if (employeeData != null) {
      fromDateTime = employeeData.fromDate;
      toDateTime = employeeData.toDate;
      uuid = employeeData.uuid;
      nameController.text = employeeData.name;
      roleController.text = employeeData.role;
      fromDateController.text = employeeData.fromDateString;
      toDateController.text = employeeData.toDateString;
      _isInEditMode = true;
    } else {
      nameController.clear();
      roleController.clear();
      fromDateController.clear();
      toDateController.clear();
      _isInEditMode = false;
    }

    emit(AddEditPageLoadSuccess());
  }

  /// Handler for `DelEmployeeButtonTapped` Event
  Future<void> _onDeleteEmployee(DelEmployeeButtonTapped event, Emitter<AddEditState> emit) async {
    emit(DelEmployeeInProgress());

    final result = await _delEmployeeById(uuid);
    result.fold(
          (Failure failure) => emit(DelEmployeeFailure(failure)),
          (r) {
        _canUndo = true;
        Future.delayed(const Duration(seconds: 3), () {
          if (_canUndo) {
            _canUndo = false;
            add(AddEditPageOpened(null));
          }
        });
        emit(DelEmployeeSuccess());
      },
    );
  }

  /// Handler for `UndoDelButtonTapped` Event
  Future<void> _onUndoDelete(UndoDelButtonTapped event, Emitter<AddEditState> emit) async {
    _canUndo = false;
    emit(UndoDelEmployeeInProgress());

    EmployeeData employeeData = EmployeeData(
      nameController.text,
      roleController.text,
      fromDateTime!,
      toDateTime,
    );
    employeeData.uuid = uuid;

    final result = await _insertEmployeeRecord(employeeData);
    result.fold(
          (Failure failure) => emit(UndoDelEmployeeFailure(failure)),
          (r) => add(AddEditPageOpened(employeeData)),
    );
  }

  /// Handler for `AddEmployeeButtonTapped` Event
  Future<void> _onAddEmployee(AddEmployeeButtonTapped event, Emitter<AddEditState> emit) async {
    _canUndo = false;
    emit(AddEmployeeInProgress());

    EmployeeData employeeData = EmployeeData(
      nameController.text,
      roleController.text,
      fromDateTime!,
      toDateTime,
    );

    if (isInEditMode) {
      await _delEmployeeById(uuid);
    }

    final result = await _insertEmployeeRecord(employeeData);
    result.fold(
          (Failure failure) => emit(AddEmployeeFailure(failure)),
          (r) {
        emit(AddEmployeeSuccess());
        Future.delayed(
          const Duration(seconds: 3),
              () => add(AddEditPageOpened(employeeData)),
        );
      },
    );
  }
}
