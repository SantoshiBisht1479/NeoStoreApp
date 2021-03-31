# NeoSTORE

NeoSTORE is an e-commerce mobile application developed in flutter. It provides user with catalog of different products available for purchase in store. User can add product to their cart and then place order. 

For this project we going to use NeoSTORE API to fetch details and render on UI.

## How to Use

### Step 1:
Download or clone this repo by using the link below:

`https://github.com/SantoshiBisht1479/NeoStoreApp.git`

### Step 2:
If you are developing the project without cloning then
add the below dependencies in your `pubspec.yaml` file and run `flutter pub get` to install the dependencies.

```
  flutter_bloc: ^6.1.1
  sqflite: ^1.3.2+2
  path_provider: ^1.6.27
  flutter_slidable: ^0.5.7
  equatable: ^1.2.5
  carousel_slider: ^2.3.1
  flutter_rating_bar: ^3.2.0+1
  sizer: ^1.1.8
  http: ^0.12.2
  dio: ^3.0.10
  shared_preferences: ^0.5.12+4
  image_picker: ^0.6.7+21
  intl: ^0.16.1
  ```

Go to project root and execute the following command in console to get the required dependencies:

`flutter pub get`

## NeoSTORE Features:
1. User
    - Login
    - Forgot Password
    - Change Password
    - Update Account Details
    - Fetch Account Details
     
2. Product
     - Get Product List
     - Get Product Details
     - Set Product Ratings
     
3. Cart
     - Add to cart
     - Edit Cart
     - Delete Cart
     - List Cart Items
     
4. Order
     - Order
     - Order List
     - Order Detail
     
## Folder Structure

Here is the core folder structure which flutter provides.
``` 
   NeoStoreApp/
   |- android
   |- build
   |- ios
   |- lib
   |- test
```

Here is the project structure of the application
```
   lib/
   |- api/
   |- bloc/
   |- database_helper/
   |- model/
   |- screens
   |- shared_preference
   |- widgets/
   |- main.dart
   |- pallet.dart
```
Lets dive into each folder

`api/` file consists of api calling 
```
   api/
   |- network_services.dart
```
`bloc` For state management of application bloc pattern is used.

Each bloc consists of corresponding event, state and bloc files.
```
   bloc/
   |- address_bloc/
      |- addressBloc_events.dart
      |- addressBloc_states.dart
      |- addressBloc.dart
   |- cartBloc/
   |- editProfileBloc
   |- forgotPasswordBloc
   |- HomeBloc
   |- loginBloc
   |- myAccountBloc
   |- myOrderBloc
   |- productDetailsBloc
   |- productListBloc
   |- registerBloc
   |- resetPasswordBloc
```
`DatabaseHelper/` is used to save the users address.
```
   DatabaseHelper/
   |- database_helper.dart
```
`model/` folder consists of all models of application.
```
   model/
   |- addressModel.dart
   |- addToCart_ListModel.dart
   |- addToCart_Success_model.dart
   |- chnage_PassReq_model.dart
   |- emptyCartModel.dart
   |- forgot_pass_request_model.dart
   |- forgot_pass_response_model.dart
   |- get_user_detail_model.dart
   |- login_error_model.dart
   |- login_request_model.dart
   |- login_response_model.dart
   |- myOrder_model.dart
   |- myOrderDetail_model.dart
   |- product_category_list_model.dart
   |- product_detail_model.dart
   |- rating_success_model.dart
   |- register_error_model.dart
   |- signup_request_model.dart
   |- signup_response_model.dart
   |- update_req_detail_model.dart
   |- update_response_detail_model.dart
```
`screens/` Folder consists of screen in the application
```
   screens/
   |- address_List.dart
   |- address_details.dart
   |- editProfile.dart
   |- forgot_password_page.dart
   |- home_page.dart
   |- login_page.dart
   |- myAccount.dart
   |- myCart.dart
   |- myOrderDetail.dart
   |- myOrders.dart
   |- product_detail.dart
   |- product_list.dart
   |- registration.dart
   |- resest_password.dart
   |- splash_screen.dart
   |- store_locator.dart
  
```
Other files like `shared_preference.dart` is used to store user's preference locally and `pallet.dart` is used to provide custom styling to widgets in application.

