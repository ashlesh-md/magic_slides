import 'package:flutter/material.dart';
import 'package:magic_slides/core/constants/supabase_constants.dart';
import 'package:magic_slides/core/injection/injection.dart';
import 'package:magic_slides/core/navigation/app_router.dart';
import 'package:magic_slides/core/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  Injection().inject();
  await Supabase.initialize(
    url: SupabaseConstants.projectUrl,
    anonKey: SupabaseConstants.apiKey,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Magic Slides',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.routerConfig,
    );
  }
}
