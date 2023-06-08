import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _notificationsEnabled = false;
  bool _afadNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.notificationsEnabled;
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
              padding: EdgeInsets.symmetric(vertical:100.0),
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
              padding: EdgeInsets.symmetric(vertical:70.0),
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
                        child: Text('Rate the App'),
                        onPressed: _rateApp,
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
                    return ListTile(
                      title: Text('3.02.24',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 4,
      indent: 5,
      endIndent: 5,
    );
  }

  Widget _buildToggleSwitch(
      String title, bool enabled, ValueChanged<bool> onChanged) {
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
              child: ToggleSwitch(
                minWidth: 65.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.green[800]!],
                  [Colors.red[800]!],
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: enabled ? 0 : 1,
                totalSwitches: 2,
                labels: ['OPEN', 'CLOSE'],
                radiusStyle: true,
                onToggle: (index) {
                  onChanged(index == 0);
                },
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
          icon: Icon(Icons.message_outlined),
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
              padding: EdgeInsets.all(16.0),
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
void _rateApp() async {
  const url =
      'https://play.google.com/store/apps/details?id=com.example.app';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
