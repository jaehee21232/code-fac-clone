import 'package:code_fac/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });
  //요청이 보내질때 마다 요청에 헤더에 accessToken : true라는 값이 있다면
  //실제토큰을 가져와서 authorization: bearer $token으로 헤더를 변경
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("[REQ] [${options.method}] ${options.uri}");

    //헤더에서 accessToken이 true이면 삭제하고 authorization : Bearer token으로 토큰 받기
    if (options.headers["accessToken"] == "true") {
      options.headers.remove("accessToken");
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'authorization': "Bearer $token",
      });
    }
    if (options.headers["refreshToken"] == "true") {
      options.headers.remove("accessToken");
      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization': "Bearer $token",
      });
    }
    print("$options, $handler");
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print("[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}");
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    //리프레쉬 토큰이 없으면 에러가 난다
    if (refreshToken == null) {
      return handler.reject(err);
      //에러를 돌려주는 방법
    }
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "/auth/token";

    //401이면서 토큰 변경이 필요할때
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post(
          "http://$ip/auth/token",
          options: Options(
            headers: {
              "authorization": "Bearer $refreshToken",
            },
          ),
        );
        final accessToken = resp.data["accessToken"];

        final options = err.requestOptions;

        //토큰 변경하기
        options.headers.addAll({
          "authorization": "Bearer $accessToken",
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        //요청 재전송
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }

    return super.onError(err, handler);
  }

  //리액트를 받았을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}");
    return super.onResponse(response, handler);
  }
}
