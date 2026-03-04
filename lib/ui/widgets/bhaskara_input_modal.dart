import 'package:flutter/material.dart';

class BhaskaraInputModal extends StatefulWidget {
  const BhaskaraInputModal({super.key});

  @override
  State<BhaskaraInputModal> createState() => _BhaskaraInputModalState();
}

class _BhaskaraInputModalState extends State<BhaskaraInputModal> {
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _cController = TextEditingController();
  String? _errorText;

  void _onCalculate() {
    final aText = _aController.text;
    final bText = _bController.text;
    final cText = _cController.text;

    if (aText.isEmpty || bText.isEmpty || cText.isEmpty) {
      setState(() {
        _errorText = 'Todos os campos são obrigatórios';
      });
      return;
    }

    final a = double.tryParse(aText);
    final b = double.tryParse(bText);
    final c = double.tryParse(cText);

    if (a == null || b == null || c == null) {
      setState(() {
        _errorText = 'Insira apenas números válidos';
      });
      return;
    }

    if (a == 0) {
      setState(() {
        _errorText = 'O coeficiente "a" não pode ser zero';
      });
      return;
    }

    Navigator.of(context).pop({'a': a, 'b': b, 'c': c});
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Fórmula de Bhaskara'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            TextField(
              controller: _aController,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Coeficiente a'),
            ),
            TextField(
              controller: _bController,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Coeficiente b'),
            ),
            TextField(
              controller: _cController,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Coeficiente c'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _onCalculate, child: const Text('Calcular')),
      ],
    );
  }
}
