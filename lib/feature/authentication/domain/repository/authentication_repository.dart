abstract class AuthenticationRepository {
  Future<bool> signUp({required String email, required String password});
  Future<bool> signIn({required String email, required String password});
  Future<bool> signOut();
}
