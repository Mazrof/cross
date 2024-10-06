
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String kMain = '/';


  static String buildRoute({required String base, required String route}) {
    return "$base/$route";
  }
}

final route = GoRouter(
  initialLocation: AppRouter.kMain,
  routes: []
);
