import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  CalcButton({required this.onPressed});

  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text('Calcular', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
