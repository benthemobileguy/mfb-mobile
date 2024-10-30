import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tampay_mobile/app/view/home/cards/domain/model/request/create_card_request.dart';
import 'package:tampay_mobile/app/view/transactions/domain/model/request/fund_card_request.dart';
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
  @POST("/api/v1/cards/create")
  Future<dynamic> createCard(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Body() CreateCardRequest createCardRequest,
  );
  @GET("/api/v1/cards?limit=1&")
  Future<dynamic> getAllCards(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @PATCH("/api/v1/cards/freeze/{id}")
  Future<dynamic> freezeCard(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Path("id") String id,
  );
  @PATCH("/api/v1/cards/freeze/{id}")
  Future<dynamic> unfreezeCard(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Path("id") String id,
  );
  @PATCH("/api/v1/cards/unload/{id}")
  Future<dynamic> unloadCard(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Path("id") String id,
  );
  @DELETE("/api/v1/cards/{id}")
  Future<dynamic> deleteCard(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Path("id") String id,
  );
  @GET("/api/v1/cards/transactions/{id}?page=1")
  Future<dynamic> getCardTransactions(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Path("id") String id,
  );
  @PATCH("/api/v1/cards/fund/{id}")
  Future<dynamic> fundCard(
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Body() FundCardRequest fundCardRequest,
    @Path("id") String id,
  );
}
