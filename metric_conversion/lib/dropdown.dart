import 'package:flutter/material.dart';

class MeasurementDropDown extends StatelessWidget {
  final String? currentMeasurement;
  final List<String> measurementOptions;
  final ValueChanged<String?>? onChanged;

  const MeasurementDropDown({
    super.key,
    required this.currentMeasurement,
    required this.measurementOptions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: currentMeasurement,
      icon: const Icon(Icons.arrow_downward, color: Colors.deepPurpleAccent),
      elevation: 16,
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
      onChanged: onChanged,
      items: measurementOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
