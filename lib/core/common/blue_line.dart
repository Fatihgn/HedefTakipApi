import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hedef_takip_app/core/app/theme/app_colors.dart';

class BlueLine extends StatelessWidget {
  final double height;
  final double opacity;
  const BlueLine({super.key, required this.height, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primaryColor.withOpacity(opacity),
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(opacity),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
