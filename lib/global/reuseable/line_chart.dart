import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart<T> extends StatelessWidget {
  final List<T> data;
  final double minY;
  final double maxY;
  final Color lineColor;
  final double barWidth;
  final String Function(T) formatXLabel;
  final FlSpot Function(int, T) mapToSpot;

  const CustomLineChart({
    super.key,
    required this.data,
    required this.mapToSpot,
    required this.formatXLabel,
    this.minY = 5,
    this.maxY = 20,
    this.lineColor = Colors.blue,
    this.barWidth = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: data.length.toDouble() - 1,
          minY: minY,
          maxY: maxY,
          borderData: FlBorderData(
            show: true,
            border: const Border(
              top: BorderSide(color: Colors.red, width: 2),
              bottom: BorderSide(color: Colors.blue, width: 3),
              left: BorderSide(color: Colors.green, width: 2),
              right: BorderSide(color: Colors.orange, width: 3),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: data.asMap().entries.map((entry) {
                return mapToSpot(entry.key, entry.value);
              }).toList(),
              isCurved: true,
              barWidth: barWidth,
              belowBarData: BarAreaData(show: true),
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false, reservedSize: 30),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= data.length) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      formatXLabel(data[index]),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
