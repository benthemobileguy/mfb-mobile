import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/initiate_transfer_request.dart';

import '../../domain/model/request/transfer_request.dart';
part 'transactions_api_client.g.dart';

@RestApi()
abstract class TransactionsApiClient {
  factory TransactionsApiClient(Dio dio, {String baseUrl}) =
      _TransactionsApiClient;

  @GET("/api/v1/transactions/me?limit=10")
  Future<dynamic> recentTransactions(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @GET("/api/v1/banks")
  Future<dynamic> banks(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @GET("/api/v1/banks/account-enquiry")
  Future<dynamic> accountInfo(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Query("bank_code") String bankCode,
    @Query("account_number") String accountNumber,
  );
  @POST("/api/v1/wallets/transfer/initiate")
  Future<dynamic> initiateTransfer(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Header("idempotent-key") String idempotentKey,
    @Body() InitiateTransferRequest initiateTransferRequest,
  );
  @POST("/api/v1/wallets/transfer")
  Future<dynamic> transfer(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Body() TransferRequest transferRequest,
  );
}
