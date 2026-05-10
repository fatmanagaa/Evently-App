import 'package:evently_app/core/app_routes.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'features/auth/forget_pass/forget_pass_screen.dart';
import 'features/auth/login/login_screen.dart';
import 'features/auth/resgister/register_screen.dart';
import 'features/home_screen/add_event/add_event.dart';
import 'features/home_screen/home_screen.dart';
import 'features/onBoarding_screen/onboarding_screen.dart';
import 'features/splash_screen/splash_screen.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(414 , 896),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        routes: {
          AppRoutes.onboardingScreen: (context) => OnboardingScreen(),
          AppRoutes.homeScreen: (context) => HomeScreen(),
          AppRoutes.loginScreen: (context) => LoginScreen(),
          AppRoutes.splashScreen: (context) => SplashScreen(),
          AppRoutes.registerScreen: (context) => RegisterScreen(),
          AppRoutes.forgetPassScreen: (context) => ForgetPassScreen(),
          AppRoutes.addEventScreen: (context) => AddEvent(),
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(appLanguageProvider.appLanguage),
      
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appThemeProvider.appTheme,
      ),
    );
  }
}
