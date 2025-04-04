import 'package:flutter/material.dart';

class BmiInfo extends StatelessWidget {
  BmiInfo({
    required this.resultColor,
    required this.bmi,
    required this.classfication,
  });

  final Color resultColor;
  final double bmi;
  final String classfication;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        border: Border.all(width: 10, color: resultColor!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${bmi?.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 36, color: resultColor!),
          ),
          SizedBox(height: 12),
          Text(
            classfication!,
            style: TextStyle(fontSize: 20, color: resultColor!),
          ),
        ],
      ),
    );
  }
}
