import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hedef_takip_app/core/app/theme/app_colors.dart';
import 'package:hedef_takip_app/core/common/blue_line.dart';

class MainPageView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainPageView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlueLine(height: 3, opacity: 0.3),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.background,
            selectedItemColor: AppColors.primaryColor,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            iconSize: 30.sp,
            unselectedItemColor: AppColors.white,
            elevation: 10,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Goals'),
              BottomNavigationBarItem(
                icon: Icon(Icons.bug_report),
                label: 'Progress',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Dashboard',
              ),
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: _onTap,
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
