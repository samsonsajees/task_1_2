import 'package:go_router/go_router.dart';
import 'package:task_1_2/ui/home/home_screen.dart';
import 'package:task_1_2/ui/task1_user_details/user_details_screen.dart';
import 'package:task_1_2/ui/task2_name_updater/name_updater_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/task1',
      builder: (context, state) => const UserDetailsScreen(),
    ),
    GoRoute(
      path: '/task2',
      builder: (context, state) => const NameUpdaterScreen(),
    ),
  ],
);