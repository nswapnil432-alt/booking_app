import 'package:flutter_dotenv/flutter_dotenv.dart';

DotEnv dotEnv = DotEnv();
class EnvironmentConfiguration {
  static var baseUrlApi = dotEnv.env['BASE_URL_API'];
  static var faceUrlApi =dotEnv.env['FACE_URL_API'];
  static var deploymentMode = dotEnv.env['DEPLOYMENT_MODE'];
  static var baseWebUrl = dotEnv.env['BASE_WEB_URL'];
  static var credentialingClientSecret =
      dotEnv.env['CREDENTIALING_CLIEN_SECRET'];
/*  static var CREDENTIALING_CLIEN_ID = dotEnv.env['CREDENTIALING_CLIEN_ID'];
  static var CREDENTIALING_WIDGETS_BASE_API =
      dotEnv.env['CREDENTIALING_WIDGETS_BASE_API'];
  static var CREDENTIALING_BASE_API = dotEnv.env['CREDENTIALING_BASE_API'];*/

  static const baseUrlApiVersion = 'api/v1/';
  static var baseUrl = baseUrlApi! + baseUrlApiVersion;
  static const basePublicUrlApiVersion = 'public/api/v1/';
  static var baseUrlPublic = baseUrlApi! + basePublicUrlApiVersion;

  static final keyCloakUri = dotEnv.env['KEY_CLOAK_URI'];
  static final clientId = dotEnv.env['CLIENT_ID'];
  static final citizenRoleId = dotEnv.env['CITIZEN_ROLE_ID'];
  static final dashboardUrl = dotEnv.env['DASHBOARD_URL'];

  //ChatBot
  static final chatBotUrl = dotEnv.env['chatbot_URL'];
  static final chatBotEnvType = dotEnv.env['chatbot_env_type'];

  //preq
  static final preQualificationURL = dotEnv.env['prequalification_URL'];
  static final preQualificationStagingURL =
      dotEnv.env['prequalification_staging_URL'];

  static final cookieUrl = dotEnv.env['cookie_URL'];
}
