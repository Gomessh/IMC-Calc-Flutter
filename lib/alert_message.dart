import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Adicione valores de peso e altura \npara calcular seu IMC',
      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }
}
