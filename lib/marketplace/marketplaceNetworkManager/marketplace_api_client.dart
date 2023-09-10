import 'package:dio/dio.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/helper/extension.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/AskToAdminModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/MarketPlaceModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerOrderModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerDashboardModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProductModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerProfileModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceModel/SellerReviewModel.dart';
import 'package:flutter_project_structure/marketplace/marketplaceNetworkManager/marketplace_apis.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';
import 'package:flutter_project_structure/networkManager/dio_exceptions.dart';
import 'package:retrofit/http.dart';
part 'marketplace_api_client.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class MarketPlaceApiClient {
  factory MarketPlaceApiClient({String? baseUrl}) {
    Dio dio = Dio();

    // dio.interceptors.add(CookieManager(PersistCookieJar(
    //     ignoreExpires: true,
    //     persistSession: true,
    //     storage: FileStorage(AppConstant.appDocPath + "/.cookies"))));
    dio.options = BaseOptions(
        receiveTimeout: const Duration(milliseconds: 5000),
        connectTimeout: const Duration(milliseconds: 5000),
        baseUrl: ApiConstant.baseUrl);
    // dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Content-Type"] = "text/plain";
    dio.options.headers["Authorization"] =
    "Basic ${generateEncodedApiKey(ApiConstant.baseData)}";
    if (AppSharedPref().getLoginKey() != null) {
      dio.options.headers[AppSharedPref().getIsSocialLogin()
          ? "Login"
          : "Login"] = AppSharedPref().getLoginKey()!;
    }
    if (AppSharedPref().getAppLanguage() != null) {
      dio.options.headers["lang"] = AppSharedPref().getAppLanguage()!;
    }

    RequestOptions? reqOptions;
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      reqOptions = options;
      return handler.next(options);
    }, onResponse: (response, handler) async {
      checkCartAndEmailVerification(response);
      return handler.next(response);
    }, onError: (DioError e, handler) {
      //retryApiFromClient(e, reqOptions, dio, handler);
      // return handler.next(err);
    }));
    return _MarketPlaceApiClient(dio, baseUrl: baseUrl);
  }

  @POST(MarketplaceApis.askToAdmin)
  Future<AskToAdminModel> onAsk(@Body() String data);

  @POST(MarketplaceApis.sellerOrders)
  Future<SellerOrderModel> getSellerOrder(@Body() String data);

  @GET(MarketplaceApis.sellerDashBoard)
  Future<SellerDashboardModel> getSellerDashboard();

  @POST(MarketplaceApis.sellerProduct)
  Future<SellerProductModel> getSellerProduct(@Body() String data);

  @GET(MarketplaceApis.allSeller)
  Future<MarketPlaceModel> getMarketPlace();

  @GET(MarketplaceApis.sellerProfile + "{sellerId}")
  Future<SellerProfileModel> getSellerDetails(@Path()int sellerId);

  @GET(MarketplaceApis.sellerReviews + "{sellerId}")
  Future<SellerReviewModel> getSellerReview(@Path()int sellerId);

  @POST(MarketplaceApis.linkeDislikeSeller + "{reviewId}")
  Future<SellerReviewModel> likeDisLikeReview(@Path()int reviewId, @Body() String data);

  @POST(MarketplaceApis.addSellerReview + "{sellerId}")
  Future<BaseModel> addSellerReview(@Path() int sellerId, @Body() String data);

  @POST(MarketplaceApis.countryList)
  Future<CountryListModel> getCountryList();

  @GET(MarketplaceApis.termsCondition)
  Future<SignUpTermsModel> getSellerTermsAndConditions();

  @POST(MarketplaceApis.becomeSeller)
  Future<BaseModel> registerAsSeller(@Body() String data);

}