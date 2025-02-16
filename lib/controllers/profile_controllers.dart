import 'package:maingateguard/models/profile_models.dart';

class ProfileController {
  Profile? _profile;

  // Get the current profile
  Profile? getProfile() {
    return _profile;
  }

  // Update the profile
  void updateProfile(Profile profile) {
    _profile = profile;
  }

  // Clear the profile (optional)
  void clearProfile() {
    _profile = null;
  }
}