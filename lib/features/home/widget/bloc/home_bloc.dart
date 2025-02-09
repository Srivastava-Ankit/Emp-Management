import 'package:bloc/bloc.dart';

import '../../../../core/data/entities/employee_data.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../add_edit_employee/add_employee/insert_employee_record.dart';
import '../../../add_edit_employee/delete_employee/del_employee_record.dart';
import '../../../get_employees_list.dart';
import 'home_event.dart';
import 'home_state.dart';

/// Bloc for conversions widget
///
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetEmployeeList _getEmployeeList;
  final InsertEmployeeRecord _insertEmployeeRecord;
  final DelEmployeeRecord _delEmployeeRecord;

  List<EmployeeData> currentEmployees = [];
  List<EmployeeData> previousEmployees = [];

  bool _canUndo = false;
  EmployeeData? _employeeData;

  bool get canUndo => _canUndo;

  HomeBloc(this._getEmployeeList, this._insertEmployeeRecord, this._delEmployeeRecord)
      : super(HomePageInitial()) {
    // ✅ Register event handlers properly
    on<HomePageOpened>(_onHomePageOpened);
    on<DelEmployeeTapped>(_onDelEmployeeTapped);
    on<UndoDelEmployeeTapped>(_onUndoDelEmployeeTapped);
  }

  /// Handles HomePageOpened event
  Future<void> _onHomePageOpened(
      HomePageOpened event, Emitter<HomeState> emit) async {
    emit(HomePageLoadInProgress());

    final result = await _getEmployeeList(NoParams());
    result.fold(
          (Failure failure) => emit(HomePageLoadFailure(failure)),
          (List<EmployeeData> employees) {
        currentEmployees.clear();
        previousEmployees.clear();

        for (var element in employees) {
          if (element.toDate == null || element.toDate!.isAfter(DateTime.now())) {
            currentEmployees.add(element);
          } else {
            previousEmployees.add(element);
          }
        }

        emit(HomePageLoadSuccess());
      },
    );
  }

  /// Handles DelEmployeeTapped event
  Future<void> _onDelEmployeeTapped(
      DelEmployeeTapped event, Emitter<HomeState> emit) async {
    emit(DelEmployeeInProgress());
    _employeeData = event.employeeData;

    final result = await _delEmployeeRecord(_employeeData!);
    result.fold(
          (Failure failure) => emit(DelEmployeeFailure(failure)),
          (_) {
        _canUndo = true;
        add(HomePageOpened());
        Future.delayed(const Duration(seconds: 3), () {
          if (_canUndo) {
            _canUndo = false;
            _employeeData = null;
            add(HomePageOpened());
          }
        });
      },
    );
  }

  /// Handles UndoDelEmployeeTapped event
  Future<void> _onUndoDelEmployeeTapped(
      UndoDelEmployeeTapped event, Emitter<HomeState> emit) async {
    if (_canUndo && _employeeData != null) {
      emit(UndoDelInProgress());

      final result = await _insertEmployeeRecord(_employeeData!);
      result.fold(
            (Failure failure) => emit(UndoDelFailure(failure)),
            (_) {
          _canUndo = false;
          _employeeData = null;
          add(HomePageOpened());
        },
      );
    }
  }
}
