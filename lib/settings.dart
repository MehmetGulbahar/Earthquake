import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.notificationsEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Row(
          children: [
            Text('Notifications'),
            Center(
              child: ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: 1,
                totalSwitches: 2,
                labels: ['OPEN', 'CLOSE'],
                radiusStyle: true,
                onToggle: (index) {
                  print('switched to: $index');
                },
              ),
            ),
          ],
        )
      ),
    );
  }


  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple[300],
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
        content:
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              height: 80,
              decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact Us',style: GoogleFonts.openSans(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        Text('earthquaketouch@gmail.com',style: GoogleFonts.openSans(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
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
