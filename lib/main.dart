import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:window_manager/window_manager.dart'; // Import this
import 'package:task_1_2/provider/name_provider.dart';
import 'package:task_1_2/provider/user_provider.dart';
import 'package:task_1_2/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load Environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Image Cache
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));

  // --- NEW: Initialize Window Manager to set Minimum Size ---
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 800), // Default starting size
    minimumSize: Size(900, 700), // User cannot shrink window smaller than this
    center: true,
    title: 'Caddayn Task',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  // ----------------------------------------------------------

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NameProvider()),
      ],
      child: MaterialApp.router(
        title: 'Caddayn Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}