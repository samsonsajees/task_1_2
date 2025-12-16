import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:window_manager/window_manager.dart';
import 'package:task_1_2/provider/user_provider.dart';
import 'package:task_1_2/ui/task1_user_details/user_details_screen.dart'; // Import the screen directly

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 820),
    minimumSize: Size(1000, 820), 
    center: true,
    title: 'Caddayn Task',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      
      child: MaterialApp(
        title: 'Caddayn Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        
        home: const UserDetailsScreen(),
      ),
    );
  }
}