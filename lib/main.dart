import 'package:flutter/material.dart';

import 'app_router.dart';


//Email : sakriwassim@gmail.com
//linkdin : sakri wassim
void main() {
  runApp(BreakingBadApp(appRouter: AppRouter(),));
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter appRouter;

  const BreakingBadApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
