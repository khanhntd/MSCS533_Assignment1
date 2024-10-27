import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:metric_conversion/dropdown.dart';
import 'package:metric_conversion/helper.dart';
import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MeasureConverter(title: 'Measures Converter'),
    );
  }
}

class MeasureConverter extends StatefulWidget {
  const MeasureConverter({super.key, required this.title});
  final String title;

  @override
  State<MeasureConverter> createState() => _MeasureConverterState();
}

class _MeasureConverterState extends State<MeasureConverter> {
  String? currentMeasurement = listOfMeasurements.first;
  String? currentMeter = meterConversion.last;
  String? currentWeight = weightConversion.first;
  double initialConversionValue = 100.0;
  double finalConversionValue = 0.0;

  _MeasureConverterState(){
    finalConversionValue = calculateConversion(
        currentMeasurement,
        currentMeasurement == 'Meter' ? currentMeter : currentWeight,
        initialConversionValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Value',
            ),
            MeasurementDropDown(
              currentMeasurement: currentMeasurement,
              measurementOptions: listOfMeasurements,
              onChanged: (String? measurement) {
                setState(() {
                  currentMeasurement = measurement!;
                });
              },
            ),
            const Text(
              'From',
            ),
            MeasurementDropDown(
              currentMeasurement: currentMeasurement,
              measurementOptions: listOfMeasurements,
              onChanged: (String? measurement) {
                setState(() {
                  currentMeasurement = measurement!;
                });
              },
            ),
            const Text(
              'To',
            ),
            MeasurementDropDown(
              currentMeasurement:
                  currentMeasurement == 'Meter' ? currentMeter : currentWeight,
              measurementOptions: currentMeasurement == 'Meter'
                  ? meterConversion
                  : weightConversion,
              onChanged: (String? measurement) {
                setState(() {
                  if (currentMeasurement == 'Meter') {
                    currentMeter = measurement;
                  } else {
                    currentWeight = measurement;
                  }
                });
              },
            ),
            Text(currentMeasurement == 'Meter'
                ? '$initialConversionValue $currentMeasurement are $finalConversionValue $currentMeter.'
                : '$initialConversionValue $currentMeasurement are $finalConversionValue $currentWeight.'),
            TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.focused)) return Colors.red;
                  return null; // Defer to the widget's default.
                }),
              ),
              onPressed: () {
                finalConversionValue = calculateConversion(currentMeasurement, currentMeasurement == 'Meter' ? currentMeter : currentWeight, initialConversionValue);
              },
              child: const Text('Convert'),
            )
          ],
        ),
      ),
    );
  }
}
