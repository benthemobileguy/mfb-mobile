import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'transactions_api_client.g.dart';

@RestApi()
abstract class TransactionsApiClient {
  factory TransactionsApiClient(Dio dio, {String baseUrl}) = _TransactionsApiClient;

  @POST("/api/v1/transactions/me?limit=10")
  Future<dynamic> recentTransactions(
      @Header("Access-Key") String accessKey,
      @Header("Secret-Key") String secretKey,
      );
}
