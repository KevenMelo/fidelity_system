import 'package:eatagain/app/commons/constants/local_save_keys.dart';
import 'package:eatagain/app/commons/utils/api_client.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/commons/utils/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:melo_ui/melo_ui.dart';

import '../models/user_model.dart';

abstract class AuthRepository {
  Future<({bool? sucess, String? error})> register();
  Future<({UserModel? data, List<MeloUIHttpErrorFieldModel>? errors})> login(
      {required String email, required String password});
  Future<({UserModel? data, String? error})> verifyToken();
}

class AuthRepositoryImplementation with ApiClient implements AuthRepository {
  final String _path = "auth";
  AuthRepositoryImplementation();

  @override
  Future<({UserModel? data, List<MeloUIHttpErrorFieldModel>? errors})> login(
      {required String email, required String password}) async {
    try {
      final response = await post(
        "$_path/login",
        {"email": email, "password": password},
      );

      if (response.ok) {
        await AppUtils.saveLocal(LocalSaveKeys.token, response.result!);
        await AppUtils.saveLocal(LocalSaveKeys.restaurantId, '');

        final verify = await verifyToken();
        if (verify.error != null) {
          return (
            errors: [
              MeloUIHttpErrorFieldModel(
                  key: 'server', errors: ['Falha ao verificar token'])
            ],
            data: null
          );
        }
        return (errors: null, data: verify.data);
      }
      return (errors: response.errors, data: null);
    } catch (e) {
      return (
        errors: [
          MeloUIHttpErrorFieldModel(key: 'server', errors: [e.toString()])
        ],
        data: null
      );
    }
  }

  @override
  Future<({String? error, bool? sucess})> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  // Future<bool> isAuthenticated() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return false;
  //   var response =
  //       await get<UserModel>('$_path/verify-token', parser: UserModel.fromJson);
  //   return response.ok;
  // }

  // Future<bool> signUp() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return false;
  //   var response = await post<bool>(_path, {});
  //   return response.ok;
  // }

  @override
  Future<({UserModel? data, String? error})> verifyToken() async {
    var response =
        await get<UserModel>('$_path/verify-token', parser: UserModel.fromJson);
    if (response.ok) {
      return (data: response.result, error: null);
    }
    return (data: null, error: 'Not user');
  }
}
