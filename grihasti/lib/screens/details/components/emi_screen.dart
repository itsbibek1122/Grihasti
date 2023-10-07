import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grihasti/screens/authentication/components/my_button.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';

class EmiScreen extends StatefulWidget {
  const EmiScreen({super.key});

  @override
  State<EmiScreen> createState() => _EmiScreenState();
}

class _EmiScreenState extends State<EmiScreen> {
  TextEditingController principalController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController tenureController = TextEditingController();
  double emi = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'EMI Calculator'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: principalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Principal Amount'),
            ),
            TextField(
              controller: interestRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
            ),
            TextField(
              controller: tenureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Loan Tenure (months)'),
            ),
            SizedBox(height: 20),
            AuthenticationButton(text: 'Calculate', onPressed: calculateEMI),
            SizedBox(height: 20),
            Text('EMI: $emi'),
          ],
        ),
      ),
    );
  }

  void calculateEMI() {
    double principal = double.parse(principalController.text);
    double interestRate = double.parse(interestRateController.text) / 12 / 100;
    double tenure = double.parse(tenureController.text);

    double emi = (principal * interestRate * (pow(1 + interestRate, tenure))) /
        (pow(1 + interestRate, tenure) - 1);

    setState(() {
      this.emi = emi;
    });
  }
}
