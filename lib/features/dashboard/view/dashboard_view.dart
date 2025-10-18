import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Dashboard View',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
