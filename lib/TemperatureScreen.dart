import 'package:flutter/material.dart';

class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  String selectedFromUnit = 'Celsius';
  String selectedToUnit = 'Celsius';
  double inputValue = 0;
  double convertedValue = 0;

  // Ratios de conversion constants
  static const double celsiusToFahrenheit = 33.8;
  static const double celsiusToKelvin = 274.15;

  void convert() {
    setState(() {
      double celsiusValue;

      if (selectedFromUnit == 'Celsius') {
        celsiusValue = inputValue;
      } else {
        switch (selectedFromUnit) {
          case 'Fahrenheit':
            celsiusValue = (inputValue - celsiusToFahrenheit) * (5 / 9);
            break;
          case 'Kelvin':
            celsiusValue = inputValue - celsiusToKelvin;
            break;
          default:
            celsiusValue = inputValue;
            break;
        }
      }

      switch (selectedToUnit) {
        case 'Celsius':
          convertedValue = celsiusValue;
          break;
        case 'Fahrenheit':
          convertedValue = celsiusValue * (9 / 5) + celsiusToFahrenheit;
          break;
        case 'Kelvin':
          convertedValue = celsiusValue + celsiusToKelvin;
          break;
        default:
          convertedValue = celsiusValue;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedFromUnit,
              items: [
                'Celsius',
                'Fahrenheit',
                'Kelvin',
              ].map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedFromUnit = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedToUnit,
              items: [
                'Celsius',
                'Fahrenheit',
                'Kelvin',
              ].map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedToUnit = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  inputValue = double.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter value to convert',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text('Result: $convertedValue $selectedToUnit'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TemperatureScreen(),
  ));
}
