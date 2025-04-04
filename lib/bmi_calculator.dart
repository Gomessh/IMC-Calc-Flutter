import 'package:flutter/material.dart';
import 'package:imcflutter/alert_message.dart';
import 'package:imcflutter/bmi_info.dart';
import 'package:imcflutter/calc_button.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  late TextEditingController weightController;
  late TextEditingController heightController;

  double weightValue = 50;
  double heightValue = 1.2;

  double? bmi;
  String? classfication;
  Color? resultColor;

  @override
  void initState() {
    weightController = TextEditingController(text: weightValue.toString());
    heightController = TextEditingController(text: heightValue.toString());
    super.initState();
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bmi == null
                ? AlertMessage()
                : BmiInfo(
                  resultColor: resultColor!,
                  bmi: bmi!,
                  classfication: classfication!,
                ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Seu peso'),
                      SizedBox(height: 5),
                      Container(
                        width: 85,
                        child: TextField(
                          enabled: false,
                          controller: weightController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffixText: 'kg',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 1.5,
                          activeTickMarkColor: Colors.purple,
                        ),
                        child: Slider(
                          activeColor: Colors.purple,
                          value: weightValue,
                          onChanged: (weight) {
                            setState(() {
                              weightValue = weight;
                              weightController.text = weightValue
                                  .toStringAsFixed(1);
                            });
                          },
                          min: 50,
                          max: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 22),
                Expanded(
                  child: Column(
                    children: [
                      Text('Sua altura'),
                      SizedBox(height: 5),
                      Container(
                        width: 85,
                        child: TextField(
                          enabled: false,
                          controller: heightController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffixText: 'm',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 1.5,
                          activeTickMarkColor: Colors.purple,
                        ),
                        child: Slider(
                          activeColor: Colors.purple,
                          value: heightValue,
                          onChanged: (height) {
                            setState(() {
                              heightValue = height;
                              heightController.text = heightValue
                                  .toStringAsFixed(2);
                            });
                          },
                          min: 1.20,
                          max: 2.20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            CalcButton(
              onPressed: () {
                try {
                  double weight = double.parse(weightController.text);
                  double height = double.parse(heightController.text);

                  setState(() {
                    bmi = weight / (height * height);
                    classfication = getClassificationBmi(bmi!);
                    resultColor = getColorBmi(bmi!);
                  });
                } on Exception {
                  setState(() {
                    bmi = null;
                    weightController.text = '';
                    heightController.text = '';
                    classfication = null;
                    resultColor = null;
                  });
                  print('Digite valores válidos!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String getClassificationBmi(double bmi) {
    if (bmi < 18.5) {
      return 'Abaixo do peso';
    } else if (bmi >= 18.5 && bmi <= 24.99) {
      return 'Peso Normal';
    } else if (bmi >= 25.0 && bmi <= 29.99) {
      return 'Sobrepeso';
    } else if (bmi >= 30.0 && bmi <= 34.99) {
      return 'Obesidade Grau I';
    } else if (bmi >= 35.0 && bmi <= 39.99) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  Color getColorBmi(bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi <= 24.99) {
      return Colors.green;
    } else if (bmi >= 25.0 && bmi <= 29.99) {
      return Color(0xFFF4BE8E);
    } else if (bmi >= 30.0 && bmi <= 34.99) {
      return Color(0xFFee9809);
    } else if (bmi >= 35.0 && bmi <= 39.99) {
      return Color(0xFFe44f38);
    } else {
      return Colors.red;
    }
  }
}
