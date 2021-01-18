import 'package:dio/dio.dart';
import 'package:neostore/model/change_PassReq_model.dart';
import 'package:neostore/model/forgot_pass_request_model.dart';
import 'package:neostore/model/login_request_model.dart';
import 'package:neostore/model/signup_request_model.dart';
import 'package:neostore/model/update_req_detail_model.dart';

class NetworkServices {
  String orderBaseUrl = 'http://staging.php-dev.in:8844/trainingapp/api';
  String baseUrl = 'http://staging.php-dev.in:8844/trainingapp/api/users';
  String baseProductUrl =
      'http://staging.php-dev.in:8844/trainingapp/api/products';

  String cartbaseUrl = 'http://staging.php-dev.in:8844/trainingapp/api';
  final Dio dio = Dio();

  Future<Response> register(RegisterRequestModel registerRequestModel) async {
    FormData formData = FormData.fromMap({
      'first_name': registerRequestModel.firstName,
      'last_name': registerRequestModel.lastName,
      'email': registerRequestModel.email,
      'password': registerRequestModel.password,
      'confirm_password': registerRequestModel.confirmPassword,
      'gender': registerRequestModel.gender,
      'phone_no': registerRequestModel.phoneNo
    });
    Response response = await dio.post('$baseUrl/register', data: formData);
    return response;
  }

  Future<Response> loginRequest(LoginRequestModel loginRequestModel) async {
    FormData formData = FormData.fromMap({
      'email': loginRequestModel.email,
      'password': loginRequestModel.password
    });
    Response response = await dio.post('$baseUrl/login',
        options: Options(contentType: 'application/form-data'), data: formData);

    return response;
  }

  Future<Response> forgotPassrequest(
      ForgotPassRequestModel forgotPassRequestModel) async {
    FormData formData =
        FormData.fromMap({'email': forgotPassRequestModel.email});

    Response response = await dio.post('$baseUrl/forgot',
        options: Options(contentType: 'application/form-data'), data: formData);

    return response;
  }

  Future<Response> getUserDetail(String accessToken) async {
    Response response = await dio.get('$baseUrl/getUserData',
        options: Options(headers: {'access_Token': '$accessToken'}));

    return response;
  }

  Future<Response> updateDetailRequest(String accessToken,
      UpdateReqUserDetailModel updateReqUserDetailModel) async {
    FormData formData = FormData.fromMap({
      'first_name': updateReqUserDetailModel.firstName,
      'last_name': updateReqUserDetailModel.lastName,
      'email': updateReqUserDetailModel.email,
      'dob': updateReqUserDetailModel.dob,
      'profile_pic': updateReqUserDetailModel.profilePic,
      'phone_no': updateReqUserDetailModel.phoneNo
    });

    Response response = await dio.post('$baseUrl/update',
        options: Options(headers: {'access_token': '$accessToken'}),
        data: formData);

    return response;
  }

  Future<Response> changePassRequest(
      String accessToken, ChangePasswordReqModel changePasswordReqModel) async {
    FormData formData = FormData.fromMap({
      'old_password': changePasswordReqModel.oldPassword,
      'password': changePasswordReqModel.password,
      'confirm_password': changePasswordReqModel.confirmPassword,
    });

    Response response = await dio.post('$baseUrl/change',
        options: Options(headers: {'access_token': '$accessToken'}),
        data: formData);

    return response;
  }

  Future<Response> getProductList(String product_category_id) async {
    Response response = await dio.get(
        '$baseProductUrl/getList?product_category_id=$product_category_id');
    return response;
  }

  // Future<ProductCategoryModel> getProductList(
  //     String product_category_id) async {
  //   Response response = await dio.get(
  //       '$baseProductUrl/getList?product_category_id=$product_category_id');
  //   if (response.statusCode == 200) {
  //     print(response.data);
  //     try {
  //       var responseData = json.decode(response.data);
  //       return ProductCategoryModel.fromJson(responseData);
  //     } on DioError catch (e) {
  //       print('error');
  //       print(e.response);
  //       //return LoginRequestModel.fromJson(json.decode(response.data));
  //     }
  //   }
  // }

  Future<Response> getProductDetails(String product_id) async {
    Response response =
        await dio.get('$baseProductUrl/getDetail?product_id=$product_id');
    return response;
  }

  Future<Response> getProductRatings(String product_id, var ratings) async {
    FormData formData =
        FormData.fromMap({'product_id': product_id, 'rating': ratings});
    Response response =
        await dio.post('$baseProductUrl/setRating', data: formData);

    return response;
  }

  Future<Response> addProductQuantity(
      String accessToken, int productId, int quantity) async {
    FormData formData =
        FormData.fromMap({'product_id': productId, 'quantity': quantity});

    Response response = await dio.post('$cartbaseUrl/addToCart',
        data: formData,
        options: Options(headers: {'access_token': accessToken}));
    return response;
  }

  Future<Response> addToCartList(String accessToken) async {
    Response response = await dio.get('$cartbaseUrl/cart',
        options: Options(headers: {'access_token': accessToken}));
    return response;
  }

  Future<Response> deleteCartItem(String accessToken, int productId) async {
    Response response = await dio.post('$cartbaseUrl/deleteCart',
        data: FormData.fromMap({'product_id': productId}),
        options: Options(headers: {'access_token': accessToken}));
    return response;
  }

  Future<Response> editCartItems(
      String accessToken, int productId, int quantity) async {
    Response response = await dio.post('$cartbaseUrl/editCart',
        data: FormData.fromMap({'product_id': productId, 'quantity': quantity}),
        options: Options(headers: {'access_token': accessToken}));

    return response;
  }

  Future<Response> placeOrder(String access_token, String address) async {
    Response response = await dio.post('$orderBaseUrl/order',
        data: FormData.fromMap({'address': address}),
        options: Options(headers: {'access_token': access_token}));

    return response;
  }

  Future<Response> getMyOrders(String accessToken) async {
    Response response = await dio.get('$orderBaseUrl/orderList',
        options: Options(headers: {'access_token': accessToken}));
    return response;
  }

  Future<Response> getMyOrderDetails(String accesstoken, int orderId) async {
    Response response = await dio.get(
        '$orderBaseUrl/orderDetail?order_id=$orderId',
        options: Options(headers: {'access_token': accesstoken}));
    return response;
  }
}
