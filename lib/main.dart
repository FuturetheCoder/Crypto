
import 'package:cryptotest/utils/pageroute/app_navigation.dart';
import 'package:cryptotest/utils/pageroute/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';



void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glade Crypto Assessment',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
      ),
      navigatorKey: ref.read(navigationServiceProvider).navigationKey,
      onGenerateRoute: AppNavigation.generateRoute,
    );
  }
}
