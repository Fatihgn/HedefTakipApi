import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hedef_takip_app/core/app/managers/route_manager/go_router_provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    print('🔥 Firebase başlatılıyor...');
    await Firebase.initializeApp( 
      
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase başarıyla başlatıldı!');
  } catch (e) {
    print('❌ Firebase başlatma hatası: $e');
    print('🔍 Hata detayı: ${e.toString()}');
  }
  
  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ProviderScope(child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,

        //primaryColor: AppColors.appBlue,
      ),
      routerConfig: goRouterProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
