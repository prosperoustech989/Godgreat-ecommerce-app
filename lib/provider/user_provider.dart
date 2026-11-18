import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:godgreat_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  // constructor initializing with default user object
  // purpose: Manage the state of the user object allowing updates
  UserProvider()
    : super(
        User(
          id: '',
          fullName: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          token: '',
        ),
      );

  // Getter method to extract value from an object
  User? get user => state;

  // Method to set user state from json
  // purpose: updates the user state based on json string representation of user object
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  //Method to clear user state
  void signOut() {
    state = null;
  }
}

// make the data accessible
final userProvider = StateNotifierProvider<UserProvider, User?>(
  (ref) => UserProvider(),
);
