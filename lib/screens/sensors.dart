import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:solar_clean/widgets/show_account.dart';

class SensorReadingsPage extends StatelessWidget {
  const SensorReadingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(color: const Color.fromARGB(62, 158, 158, 158)),
        ),
        centerTitle: true,
        title: Text(
          "Sensor Readings",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions:[IconButton(
      icon: Icon(Icons.account_circle_outlined),
      onPressed: () {
        showAccountDrawer(context);
      },
    ), SizedBox(width: 13)],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _sensorCard(
            title: "💧 Water Level",
            subtitle: "Current level: 75%. Optimal range achieved.",
            graphColor: Colors.blue,
            valueSpots: [80, 75, 70, 65, 60, 63, 68, 75],
          ),
          SizedBox(height: 16),
          _sensorCard(
            title: "🧱 Dirt Accumulation",
            subtitle: "Avg. accumulation: 25%. Cleaning recommended at 30%.",
            graphColor: Colors.grey,
            valueSpots: [10, 15, 22, 30, 25, 20, 28, 35],
          ),
          SizedBox(height: 16),
          _sensorCard(
            title: "🌡️ Panel Temperature",
            subtitle: "Average temp: 27°C. Within operational limits.",
            graphColor: Colors.deepOrange,
            valueSpots: [28, 29, 27, 25, 24, 26, 28, 30],
            maxY: 40,
            minY: 10,
          ),
          SizedBox(height: 16),
          _sensorCard(
            title: "💨 Ambient Humidity",
            subtitle: "Current humidity: 62%. Consistent with local climate.",
            graphColor: Colors.black87,
            valueSpots: [55, 58, 60, 62, 61, 63, 64, 62],
            chartType: ChartType.bar,
          ),
        ],
      ),
    );
  }

  Widget _sensorCard({
    required String title,
    required String subtitle,
    required List<double> valueSpots,
    required Color graphColor,
    double maxY = 100,
    double minY = 0,
    ChartType chartType = ChartType.line,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("Last 24 Hours", style: TextStyle(fontSize: 12)),
              )
            ],
          ),
          SizedBox(height: 12),

          // Chart
          SizedBox(
            height: 100,
            child: chartType == ChartType.line
                ? LineChart(_buildLineChart(valueSpots, graphColor, maxY, minY))
                : BarChart(_buildBarChart(valueSpots, graphColor)),
          ),

          SizedBox(height: 12),

          // Subtitle + View Details
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text("View Details →"),
            ),
          )
        ],
      ),
    );
  }

  LineChartData _buildLineChart(List<double> values, Color color, double maxY, double minY) {
    return LineChartData(
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i])),
          isCurved: true,
          color: color,
          barWidth: 2,
          belowBarData: BarAreaData(
            show: true,
            color: color.withOpacity(0.2),
          ),
          dotData: FlDotData(show: false),
        )
      ],
    );
  }

  BarChartData _buildBarChart(List<double> values, Color color) {
    return BarChartData(
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      barGroups: List.generate(values.length, (i) {
        return BarChartGroupData(x: i, barRods: [
          BarChartRodData(
            toY: values[i],
            color: color,
            width: 8,
            borderRadius: BorderRadius.circular(4),
          )
        ]);
      }),
    );
  }
}

enum ChartType { line, bar }
