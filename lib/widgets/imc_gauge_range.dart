import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGaugeRange extends GaugeRange {
  ImcGaugeRange(
      {required Color colors,
      required double start,
      required double end,
      required String label})
      : super(
            startValue: start,
            endValue: end,
            color: colors,
            label: label,
            sizeUnit: GaugeSizeUnit.factor,
            labelStyle: const GaugeTextStyle(fontSize: 12),
            startWidth: 0.55,
            endWidth: 0.55);
}
