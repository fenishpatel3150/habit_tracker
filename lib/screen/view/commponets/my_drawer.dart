import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/screen/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class My_Deawer extends StatelessWidget {
  const My_Deawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      child: Center(
        child: CupertinoSwitch(
          value: Provider
              .of<ThemeProvider>(context)
              .isDarkmode,
          onChanged: (value) =>
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
        ),
      ),
    );
  }
}
