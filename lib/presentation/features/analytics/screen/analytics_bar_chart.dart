import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsBarChart extends StatelessWidget {
  const AnalyticsBarChart({
    super.key,
    required this.monthlyExpenses,
    required this.monthlyIncome,
  });

  final List<double> monthlyExpenses;
  final List<double> monthlyIncome;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              barGroups: [
                for (var i = 0; i < monthlyExpenses.length; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: monthlyIncome[i],
                        color: const Color(0xFF1A1A1A),
                        width: 8,
                      ),
                      BarChartRodData(
                        toY: monthlyExpenses[i],
                        color: const Color(0xFFB00020),
                        width: 8,
                      ),
                    ],
                  ),
              ],
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
