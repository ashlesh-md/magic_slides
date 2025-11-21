import 'dart:io';

import 'package:magic_slides/core/exceptions/auth_failed_exception.dart';
import 'package:magic_slides/core/exceptions/network_exception.dart';
import 'package:magic_slides/feature/authentication/domain/repository/authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      return true;
    } on SocketException catch (error) {
      throw NetworkException(error.message);
    } on AuthApiException catch (error) {
      throw AuthFailedException(error.message);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _client.auth.signOut();
      return true;
    } on SocketException catch (error) {
      throw NetworkException(error.message);
    } on AuthApiException catch (error) {
      throw AuthFailedException(error.message);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> signUp({required String email, required String password}) async {
    try {
      await _client.auth.signUp(email: email, password: password);
      return true;
    } on SocketException catch (error) {
      throw NetworkException(error.message);
    } on AuthApiException catch (error) {
      throw AuthFailedException(error.message);
    } catch (_) {
      return false;
    }
  }
}
