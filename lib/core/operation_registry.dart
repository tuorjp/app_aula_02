import 'operation.dart';

class OperationRegistry {
  OperationRegistry._privateConstructor();
  static final OperationRegistry _instance =
      OperationRegistry._privateConstructor();
  static OperationRegistry get instance => _instance;

  final Map<String, Operation> _operations = {};

  void register(Operation operation) {
    _operations[operation.label] = operation;
  }

  Operation? getOperation(String label) {
    return _operations[label];
  }

  List<Operation> get allOperations => _operations.values.toList();
}
