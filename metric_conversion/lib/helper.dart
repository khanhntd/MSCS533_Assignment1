import 'const.dart';

double calculateConversion(String? measurement, String? targetMeasurement, double initialConversionValue) {
  if (measurement == 'Meter') {
    switch (targetMeasurement) {
      case 'Centimeter':
        return initialConversionValue * 1000;
      case 'Kilometer':
        return initialConversionValue * 0.001;
      case 'Millimeter':
        return initialConversionValue * 1000000;
      default:
        return initialConversionValue;
    }
  }

  switch (targetMeasurement) {
    case 'Pounds':
      return initialConversionValue * 2.204623;
    case 'Gram':
      return initialConversionValue * 1000;
    case 'Ounces':
      return initialConversionValue * 35.27396;
    default:
      return initialConversionValue;
  }
}
