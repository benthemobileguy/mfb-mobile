import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'STAGING_URL')
  static final String stagingUrl = _Env.stagingUrl;
  @EnviedField(obfuscate: true, varName: 'PROD_URL')
  static String prodUrl = _Env.prodUrl;
  @EnviedField(obfuscate: true, varName: 'ACCESS_KEY')
  static String accessKey = _Env.accessKey;
  @EnviedField(obfuscate: true, varName: 'SECRET_KEY')
  static String secretKey = _Env.secretKey;
}
