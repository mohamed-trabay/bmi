import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _bmiResult = '';
  String _bmiStatus = '';

  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _bmiResult = 'برجاء إدخال قيم صحيحة';
        _bmiStatus = '';
      });
      return;
    }

    final double heightInMeters = height / 100; 
    final double bmi = weight / (heightInMeters * heightInMeters);

    setState(() {
      _bmiResult = 'مؤشر كتلة الجسم: ${bmi.toStringAsFixed(1)}';
      if (bmi < 18.5) {
        _bmiStatus = 'نقص في الوزن';
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        _bmiStatus = 'طبيعي';
      } else if (bmi >= 25 && bmi <= 29.9) {
        _bmiStatus = 'زيادة في الوزن';
      } else {
        _bmiStatus = 'سمنة';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حساب مؤشر كتلة الجسم'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'الطول (سم)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'الوزن (كجم)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text('احسب'),
            ),
            const SizedBox(height: 16),
            Text(
              _bmiResult,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _bmiStatus,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
