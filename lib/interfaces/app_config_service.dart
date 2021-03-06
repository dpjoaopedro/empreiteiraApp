abstract class IAppConfigService {
  Future get(String key);
  Future delete(String key);
  Future put(String key, dynamic value);
}