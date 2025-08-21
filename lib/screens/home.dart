import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:solar_clean/widgets/device_state_card.dart';
import 'package:solar_clean/widgets/review_cleaning.dart';
import 'package:solar_clean/widgets/show_account.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(color: const Color.fromARGB(62, 158, 158, 158)),
        ),
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.notifications_none_outlined, size: 28),
        actions: [IconButton(
      icon: Icon(Icons.account_circle_outlined),
      onPressed: () {
        showAccountDrawer(context);
      },
    ), SizedBox(width: 13)],
      ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            DeviceStatusCard(),

            ReviewCleaning(),

            // Top Banner
            SizedBox(height: 20),

            // Water and Dirt Cards
            Row(
              children: [
                Expanded(
                  child: statCard("💧 Water Level", "85%", "Optimal", 0.85),
                ),
                SizedBox(width: 10),
                Expanded(child: statCard("🧱 Dirt Accum.", "15%", "Low", 0.15)),
              ],
            ),
            SizedBox(height: 10),

            // Temperature and Humidity Cards
            Row(
              children: [
                Expanded(
                  child: statCard("🌡 Temperature", "28.5°C", "Normal", 0.7),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: statCard("☁️ Humidity", "62%", "Average", 0.62),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Cleaning Cycles Overview
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cleaning Cycles Overview",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Last 7 days activity",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                  'Sun',
                                ];
                                return Text(days[value.toInt() % 7]);
                              },
                              interval: 1,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 10),
                              FlSpot(1, 14),
                              FlSpot(2, 8),
                              FlSpot(3, 12),
                              FlSpot(4, 16),
                              FlSpot(5, 10),
                              FlSpot(6, 18),
                            ],
                            isCurved: true,
                            color: Colors.deepPurple,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.deepPurple.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard(String title, String value, String status, double progress) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[700])),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (title.contains("Temperature"))
                Text("  ", style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            color: Colors.deepPurple,
            minHeight: 5,
          ),
          SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(color: Colors.deepPurple, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
