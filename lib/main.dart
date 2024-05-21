import 'package:flutter/material.dart';
import 'package:flutter_diary_app/db/service/db_service.dart';
import 'package:flutter_diary_app/screen/main_screen.dart';
import 'package:flutter_diary_app/screen/post_screen.dart';
import 'package:flutter_diary_app/state/journal_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.instance().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    JournalState journalState = JournalState();
    journalState.load();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(245, 245, 230, 1)),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => journalState)],
        child: MaterialApp.router(
          title: 'Journal',
          routerConfig: router(),
        ),
      ),
    );
  }

  GoRouter router() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const MainScreen(),
            routes: [
              GoRoute(
                path: 'edit/:id',
                builder: (context, state) => PostScreen(id: state.pathParameters['id']!),
              ),
            ]),
      ],
    );
  }
}
