import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
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
          icon: Icon(CupertinoIcons.info),
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
