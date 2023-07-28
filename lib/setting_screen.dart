import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toee/bloc/setting_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingCubit bloc;

  @override
  void initState() {
    bloc = context.read<SettingCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: bloc.isDark ? Colors.white : Colors.black,
            ),
          ),
          title: Text(
            'Settings',
            style: bloc.appFont
                .copyWith(color: bloc.isDark ? Colors.white : Colors.black),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Themes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            title: Text('Light Theme'),
            onTap: () {
              bloc.isDark = false;
              bloc.setTheme('light');
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Dark Theme'),
            onTap: () {
              bloc.isDark = true;
              bloc.setTheme('dark');
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Orange Theme'),
            onTap: () {
              bloc.isDark = false;
              bloc.setTheme('orange');
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Blue Theme'),
            onTap: () {
              bloc.isDark = false;
              bloc.setTheme('blue');
              setState(() {});
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Fonts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            title: Text('Roboto font'),
            onTap: () {
              bloc.changeFont('roboto', GoogleFonts.roboto(), bloc.isDark);
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Arapey font'),
            onTap: () {
              bloc.changeFont('arapey', GoogleFonts.arapey(), bloc.isDark);
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Bahiana font'),
            onTap: () {
              bloc.changeFont('bahiana', GoogleFonts.bahiana(), bloc.isDark);
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Marvel font'),
            onTap: () {
              bloc.changeFont('marvel', GoogleFonts.marvel(), bloc.isDark);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
