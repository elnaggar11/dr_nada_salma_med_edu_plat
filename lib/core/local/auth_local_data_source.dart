import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userCacheConst = "user_cache";
const cacheTokenConst = "cache_token";
const verifyInfoConst = "verify_info";
const registerBodyConst = "register_body_const";
const userInfoConst = 'user_info_const';

abstract class AuthLocalDataSource {
  Future<void> clearCachedUser();

  Future<void> cacheUserAccessToken({required String token});
  Future<String> getCachedUserAccessToken();

  // Future<void>cacheUserLoginInfo({required User params});
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheUserAccessToken({required String token}) async {
    try {
      await sharedPreferences.setString(cacheTokenConst, token);
    } catch (e) {
      throw CacheException();
    }
  }

  /* @override
  Future<void> cacheUserVerificationInfo({required params}) {
    // TODO: implement cacheUserVerificationInfo
    throw UnimplementedError();
  }*/

  @override
  Future<void> clearCachedUser() async {
    try {
      await sharedPreferences.clear();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<String> getCachedUserAccessToken() async {
    try {
      final userShared =
          sharedPreferences.getString(cacheTokenConst) ?? 'noAuth';
      if (userShared != 'noAuth') {
        return userShared;
      } else {
        throw NoCachedUserException();
      }
    } on NoCachedUserException {
      throw NoCachedUserException();
    } catch (e) {
      throw CacheException();
    }
  }
}
