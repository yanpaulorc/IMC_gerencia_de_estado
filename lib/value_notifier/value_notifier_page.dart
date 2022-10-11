import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  var imc = ValueNotifier(0.0);
  final formKey = GlobalKey<FormState>();

  void _calcularIMC({required double peso, required double altura}) {
    imc.value = 0;
    imc.value = peso / pow(altura, 2);
  }

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC ValueNotifier'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: imc,
                  builder: (_, imcValue, __) {
                    return ImcGauge(imc: imcValue);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: pesoEC,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                        symbol: '',
                        turnOffGrouping: true),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: alturaEC,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                        symbol: '',
                        turnOffGrouping: true),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigatória';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt_BR', decimalDigits: 2);
                      double peso = formatter.parse(pesoEC.text) as double;
                      double altura = formatter.parse(alturaEC.text) as double;
                      _calcularIMC(peso: peso, altura: altura);
                    },
                    child: const Text('CALCULAR IMC'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
