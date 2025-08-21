import 'package:flutter/material.dart';
import 'package:solar_clean/widgets/show_account.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool lowWaterAlert = true;
  bool highTempAlert = false;
  bool darkMode = false;
  String cleaningFrequency = "3×/week";
  String alertChannel = "Push Notification";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(color: const Color.fromARGB(62, 158, 158, 158)),
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(
      icon: Icon(Icons.account_circle_outlined),
      onPressed: () {
        showAccountDrawer(context);
      },
    ), SizedBox(width: 13)],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // User & Device Section
          _sectionTitle("User & Device"),
          _switchTile(
            title: "Notifications",
            subtitle: "Receive alerts for device status and issues.",
            value: notifications,
            onChanged: (val) => setState(() => notifications = val),
          ),
          _buttonTile(
            title: "Cleaning Frequency",
            value: cleaningFrequency,
            onTap: () {
              // Open cleaning frequency settings
            },
          ),
          _simpleTile("Subscription & Billing"),

          SizedBox(height: 24),

          // Sensor Alerts
          _sectionTitle("Sensor Alerts"),
          _switchTile(
            title: "Low Water Alert",
            subtitle: "Notify when the water tank level is critically low.",
            value: lowWaterAlert,
            onChanged: (val) => setState(() => lowWaterAlert = val),
          ),
          _switchTile(
            title: "High Temp Alert",
            subtitle: "Alert if the solar panel temperature exceeds safe limits.",
            value: highTempAlert,
            onChanged: (val) => setState(() => highTempAlert = val),
          ),
          _buttonTile(
            title: "Alert Channel",
            value: alertChannel,
            onTap: () {
              // open alert channel selector
            },
          ),

          SizedBox(height: 24),

          // App Preferences
          _sectionTitle("App Preferences"),
          _switchTile(
            title: "Dark Mode",
            subtitle: "Enable or disable the dark theme for the app interface.",
            value: darkMode,
            onChanged: (val) => setState(() => darkMode = val),
          ),
          _simpleTile("Help & Support"),
          _simpleTile("About Solar Clean"),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFF9F9F9),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 13)),
        trailing: Switch(value: value, onChanged: onChanged),
      ),
    );
  }

  Widget _buttonTile({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFF9F9F9),
      ),
      child: ListTile(
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: TextStyle(color: Colors.blue)),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _simpleTile(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFF9F9F9),
      ),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // handle action
        },
      ),
    );
  }
}
