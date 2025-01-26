import 'package:hive/hive.dart';

class TokenService {
  factory TokenService() => _instance;
  TokenService._internal();
  static final TokenService _instance = TokenService._internal();
  late final Box<String> _tokenBox;
  late final Box<bool> _onBoardBox;
  late final Box<String> _expiry;
  late final Box<String> _oncomplete;

  initializePrefs() async {
    _tokenBox = Hive.box('tokenBox');
    _onBoardBox = Hive.box('onBoardBox');
    _oncomplete = Hive.box('oncomplete');
    _expiry = Hive.box('expiry');
  }

  Future<bool?> saveToken(String? token, bool remember) async {
    await _tokenBox.put(CacheManagerKey.token.toString(), token!);
    return true;
  }

  Future<bool?> saveExpiry(String? expiry, bool remember) async {
    await _expiry.put(CacheManagerKey.expiry.toString(), expiry!);
    return true;
  }

  Future<bool?> saveOnboard() async {
    await _onBoardBox.put(CacheManagerKey.onBoard.toString(), true);
    return true;
  }

  Future<bool?> savecomplete(String? complete, bool remember) async {
    await _oncomplete.put(CacheManagerKey.complete.toString(), complete!);
    return true;
  }

  Future<bool?> getOnBoard() async {
    return _onBoardBox.get(CacheManagerKey.onBoard.toString());
  }

  Future<String?> getOncomplete() async {
    return _oncomplete.get(CacheManagerKey.complete.toString());
  }

  Future<String?> getToken() async {
    return _tokenBox.get(CacheManagerKey.token.toString());
  }

  Future<String?> getExpiry() async {
    return _expiry.get(CacheManagerKey.expiry.toString());
  }

  Future<void> removeToken() async {
    _tokenBox.delete(CacheManagerKey.token.toString());
    _tokenBox.delete(CacheManagerKey.tempToken.toString());
  }

  Future<void> removeBoard() async {
    _oncomplete.delete(CacheManagerKey.complete.toString());
  }

  Future<void> removeWish() async {
    _oncomplete.delete(CacheManagerKey.wishlist.toString());
  }
}

enum CacheManagerKey { token, expiry, tempToken, onBoard, complete, wishlist }
