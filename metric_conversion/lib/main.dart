import 'dart:developer';
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

  _MeasureConverterState() {
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
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: const Text(
              'Value',
              style: TextStyle(fontSize: 16),
            ),
            ),
            SizedBox(
              width: 400,
              child: TextField(
                style: const TextStyle(color: Colors.deepPurple),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    initialConversionValue = double.parse(value.toString());
                    finalConversionValue = calculateConversion(
                        currentMeasurement,
                        currentMeasurement == 'Meter'
                            ? currentMeter
                            : currentWeight,
                        initialConversionValue);
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: const Text(
              'From',
              style: TextStyle(fontSize: 16),
            ),),
            SizedBox(
                width: 400,
                child: MeasurementDropDown(
                  currentMeasurement: currentMeasurement,
                  measurementOptions: listOfMeasurements,
                  onChanged: (String? measurement) {
                    setState(() {
                      currentMeasurement = measurement;
                      finalConversionValue = calculateConversion(
                          currentMeasurement,
                          currentMeasurement == 'Meter'
                              ? currentMeter
                              : currentWeight,
                          initialConversionValue);
                    });
                  },
                )),
             Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: const Text(
                'To',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
                width: 400,
                child: MeasurementDropDown(
                  currentMeasurement: currentMeasurement == 'Meter'
                      ? currentMeter
                      : currentWeight,
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
                      finalConversionValue = calculateConversion(
                          currentMeasurement,
                          currentMeasurement == 'Meter'
                              ? currentMeter
                              : currentWeight,
                          initialConversionValue);
                    });
                  },
                )),
            TextButton(
              onPressed: () {
                setState(() {
                  finalConversionValue = calculateConversion(
                      currentMeasurement,
                      currentMeasurement == 'Meter'
                          ? currentMeter
                          : currentWeight,
                      initialConversionValue);
                });
              },
              child: const Text(
                'Convert',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Text(currentMeasurement == 'Meter'
                ? '$initialConversionValue $currentMeasurement are $finalConversionValue $currentMeter.'
                : '$initialConversionValue $currentMeasurement are $finalConversionValue $currentWeight.',
                style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
