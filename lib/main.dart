import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  late TextEditingController weightController;
  late TextEditingController heightController;

  double? bmi;
  String? classfication;
  Color? resultColor;

  @override
  void initState() {
    weightController = TextEditingController(text: '');
    heightController = TextEditingController(text: '');
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
                ? Text(
                  'Adicione valores de peso e altura \npara calcular seu IMC',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                )
                : Container(
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
                ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Seu peso'),
                    SizedBox(height: 5),
                    Container(
                      width: 75,
                      child: TextField(
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
                  ],
                ),
                SizedBox(width: 22),
                Column(
                  children: [
                    Text('Sua altura'),
                    SizedBox(height: 5),
                    Container(
                      width: 75,
                      child: TextField(
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
                  ],
                ),
              ],
            ),
            SizedBox(height: 22),
            Container(
              width: 200,
              height: 60,
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text('Calcular', style: TextStyle(color: Colors.white)),
              ),
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
