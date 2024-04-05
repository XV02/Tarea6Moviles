class UserAuthRepository {
  // true -> go home page
  // false -> go login page
  bool isAlreadyAuthenticated() {
    // TODO: check if the user is authenticated
    return false;
  }

  Future<void> signOutGoogleUser() async {
    // TODO: Google user signout
  }

  Future<void> signOutFirebaseUser() async {
    // TODO: Firebase user signout
  }

  Future<void> signInWithGoogle() async {
    // TODO: set up Google sign in

    // TODO: get credenciales de usuario autenticado con Google

    // TODO: firebase sign in con credenciales de Google
  }
}
