import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/struct/storage/app_shared_preferences.dart';

/// this class used for saving user data used for whole app
class UserManager {
  final _currentUser = BehaviorSubject<User?>();
  Stream<User?> get currentUser => _currentUser.stream;

  static String globalToken = '';

  Future<void> clear() async {
    globalToken = '';
    _currentUser.add(null);
    AppSharedPreferences.setAccessToken(null);
  }

  Future<void> setAccessToken(String token) async {
    globalToken = token;
    AppSharedPreferences.setAccessToken(globalToken);
  }

  Future<void> broadcastUser(User user) async {
    _currentUser.add(user);
  }
}
