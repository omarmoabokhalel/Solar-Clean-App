import 'package:flutter/material.dart';
import 'package:solar_clean/widgets/show_account.dart';

class DeviceControlPage extends StatefulWidget {
  const DeviceControlPage({super.key});

  @override
  State<DeviceControlPage> createState() => _DeviceControlPageState();
}

class _DeviceControlPageState extends State<DeviceControlPage> {
  double progress = 0.0;
  int cyclesCompleted = 125;
  String lastCleanedDate = '2024-07-28';
  bool isCleaning = false;
  bool ecoMode = false;
  double cyclesPerRun = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(color: const Color.fromARGB(62, 158, 158, 158)),
        ),
        centerTitle: true,
        title: Text(
          "Device Control",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Cleaning Status Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF6F8FB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepPurple,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "${(progress * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Progress",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Idle",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Cycles Completed: $cyclesCompleted"),
                  Text("Last Cleaned: $lastCleanedDate"),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Start / Stop Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    setState(() {
                      isCleaning = true;
                      progress = 0.1; // just for demo
                    });
                  },
                  icon: Icon(Icons.play_arrow,color: Colors.white,),
                  label: Text(
                    "Start Cleaning",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    setState(() {
                      isCleaning = false;
                      progress = 0.0;
                    });
                  },
                  icon: Icon(Icons.stop,color: Colors.white,),
                  label: Text("Stop Cleaning",style: TextStyle(color: Colors.white)),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Cleaning Preferences
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cleaning Preferences",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Adjust cleaning cycle parameters.",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Text("Cycles per Run: ${cyclesPerRun.toInt()}"),
                  Slider(
                    value: cyclesPerRun,
                    onChanged: (value) {
                      setState(() {
                        cyclesPerRun = value;
                      });
                    },
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: "${cyclesPerRun.toInt()}",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Eco Mode", style: TextStyle(fontSize: 16)),
                      Switch(
                        value: ecoMode,
                        onChanged: (val) {
                          setState(() {
                            ecoMode = val;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () {
                        // Save settings action
                      },
                      child: Text(
                        "Save Settings",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Activity Log
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Activity Log",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Recent cleaning operations and status updates.",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  _logItem(
                    "🌀",
                    "Cycle Started",
                    "2 minutes ago",
                    Colors.deepPurple,
                  ),
                  _logItem(
                    "🌱",
                    "Eco Mode Enabled",
                    "1 hour ago",
                    Colors.green,
                  ),
                  _logItem(
                    "🛠️",
                    "Maintenance Performed",
                    "Yesterday",
                    Colors.orange,
                  ),
                  _logItem(
                    "✅",
                    "Cycle Completed",
                    "3 days ago",
                    Colors.blueGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logItem(String icon, String title, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: 20)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
