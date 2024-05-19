import 'package:animated_switch/animated_switch.dart';
import 'package:earthquake_project/Settings/settings_save.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_app/rate_my_app.dart';

class SettingsPage extends StatefulWidget {
  final ValueChanged<bool> onNotificationsEnabledChanged;
  final bool notificationsEnabled;

  const SettingsPage({
    Key? key,
    required this.onNotificationsEnabledChanged,
    required this.notificationsEnabled,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _afadNotificationsEnabled = false;
  final rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
  );

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    _notificationsEnabled = await SettingsSave.getKandilliNotificationEnabled();
    _afadNotificationsEnabled = await SettingsSave.getAfadNotificationEnabled();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.indigo.shade100,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              itemCount: 4,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildSectionTitle('Notification');
                  case 1:
                    return _buildDivider();
                  case 2:
                    return _buildToggleSwitch(
                      'Kandilli Notification',
                      _notificationsEnabled,
                      (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                        widget.onNotificationsEnabledChanged(
                            _notificationsEnabled);
                      },
                    );
                  case 3:
                    return _buildToggleSwitch(
                      'Afad Notification',
                      _afadNotificationsEnabled,
                      (value) {
                        setState(() {
                          _afadNotificationsEnabled = value;
                        });
                        widget.onNotificationsEnabledChanged(
                            _afadNotificationsEnabled);
                      },
                    );
                  default:
                    return ListTile(
                      title: Text('Item ${index - 3}'),
                    );
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              itemCount: 3,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildSectionTitle('Rate It');
                  case 1:
                    return _buildDivider();
                  case 2:
                    return ListTile(
                      title: ElevatedButton(
                        child: const Text('Rate the App'),
                        onPressed: () {
                          // Show the rating dialog.
                          rateMyApp.showRateDialog(
                            context,
                            title: 'Rate this app',
                            message:
                                'If you like this application,\nwould you please take your time to evaluate it for us?',
                            rateButton: 'RATE',
                            noButton: 'NO THANKS',
                            laterButton: 'MAYBE LATER',
                            ignoreNativeDialog: true,
                          );
                        },
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildSectionTitle('Version');
                  case 1:
                    return _buildDivider();
                  case 2:
                    return const ListTile(
                      title: Text(
                        '3.02.24',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 4,
      indent: 5,
      endIndent: 5,
    );
  }

  Widget _buildToggleSwitch(
      String title, bool enabled, ValueChanged<bool> onChanged) {
    bool value;
    if (title == 'Kandilli Notification') {
      value = _notificationsEnabled;
    } else if (title == 'Afad Notification') {
      value = _afadNotificationsEnabled;
    } else {
      value = enabled;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Center(
              child: AnimatedSwitch(
                value: value,
                onChanged: (newValue) async {
                  if (title == 'Kandilli Notification') {
                    setState(() {
                      _notificationsEnabled = newValue;
                    });
                    await SettingsSave.setKandilliNotificationEnabled(newValue);
                    widget.onNotificationsEnabledChanged(_notificationsEnabled);
                  } else if (title == 'Afad Notification') {
                    setState(() {
                      _afadNotificationsEnabled = newValue;
                    });
                    await SettingsSave.setAfadNotificationEnabled(newValue);
                    widget.onNotificationsEnabledChanged(
                        _afadNotificationsEnabled);
                  }
                },
                textOn: "On",
                textOff: "Off",
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                colorOn: Colors.green,
                colorOff: Colors.red,
                indicatorColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo,
      title: Center(
        child: Text(
          'SETTINGS',
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.message_outlined),
          onPressed: () => _showSnackBar(context),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Us',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'earthquaketouch@gmail.com',
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
