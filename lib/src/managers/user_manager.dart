import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/struct/storage/app_shared_preferences.dart';

/// this class used for saving user data used for whole app
class UserManager {
  final _currentUser = BehaviorSubject<User?>();
  Stream<User?> get currentUser => _currentUser.stream;

  static String globalToken = '';
  static TypeRole? typeRole;

  Future<void> clear() async {
    globalToken = '';
    typeRole = null;
    _currentUser.add(null);
    AppSharedPreferences.setAccessToken(null);
    AppSharedPreferences.setTypeRole(null);
  }

  Future<void> setAccessToken(String token) async {
    globalToken = token;
    AppSharedPreferences.setAccessToken(globalToken);
  }

  Future<void> getAccessToken() async {
    String? token = await AppSharedPreferences.getAccessToken();
    if (token != null) {
      globalToken = token;
    }
  }

  Future<void> setTypeRole(TypeRole typeRole) async {
    typeRole = typeRole;
    AppSharedPreferences.setTypeRole(typeRole);
  }

  Future<void> getTypeRole() async {
    typeRole = await AppSharedPreferences.getTypeRole();
  }

  Future<void> broadcastUser(User user) async {
    _currentUser.add(user);
  }
}
