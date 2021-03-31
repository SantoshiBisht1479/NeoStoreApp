# NeoSTORE

NeoSTORE is an e-commerce mobile application developed in flutter. It provides user with catalog of different products available for purchase in store. User can add product to their cart and then place order. 

For this project we going to use NeoSTORE API to fetch details and render on UI.

## How to Use

### Step 1:
Download or clone this repo by using the link below:
`https://github.com/SantoshiBisht1479/NeoStoreApp.git`

### Step 2:
If you are developing the project without cloning then
Add the below dependencies in your `pubspec.yaml` file and run `flutter pub get` to install the dependencies.

```flutter_bloc: ^6.1.1
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
```NeoStoreApp/
   |- android
   |- build
   |- ios
   |- lib
   |- test
```



A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
