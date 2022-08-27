import 'package:ferdinand_coffee/pages/add_new_address/add_new_address.dart';
import 'package:ferdinand_coffee/pages/admin/notification/broadcast.dart';
import 'package:ferdinand_coffee/pages/admin/order/manage_order.dart';
import 'package:ferdinand_coffee/pages/admin/product/add_product.dart';
import 'package:ferdinand_coffee/pages/admin/product/manage_product.dart';
import 'package:ferdinand_coffee/pages/admin/subscription_code/generate_code.dart';
import 'package:ferdinand_coffee/pages/checkout/checkout.dart';
import 'package:ferdinand_coffee/pages/home/home.dart';
import 'package:ferdinand_coffee/pages/login/login.dart';
import 'package:ferdinand_coffee/pages/notification.dart';
import 'package:ferdinand_coffee/pages/password/change_password.dart';
import 'package:ferdinand_coffee/pages/points-system/award_points.dart';
import 'package:ferdinand_coffee/pages/points-system/earn_points.dart';
import 'package:ferdinand_coffee/pages/points-system/task_video.dart';
import 'package:ferdinand_coffee/pages/product_details/product_details.dart';
import 'package:ferdinand_coffee/pages/profile/personal_profile.dart';
import 'package:ferdinand_coffee/pages/profile/user_profile.dart';
import 'package:ferdinand_coffee/pages/shopping_cart/shopping_cart.dart';
import 'package:ferdinand_coffee/pages/sign_up/sign_up.dart';
import 'package:ferdinand_coffee/pages/support/support.dart';
import 'package:ferdinand_coffee/pages/user_addresses/addresses_list.dart';
import 'package:ferdinand_coffee/pages/user_addresses/select_delivery_address.dart';
import 'package:ferdinand_coffee/pages/user_orders/user_orders.dart';
import 'package:ferdinand_coffee/pages/wishlist/wishlist.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  AddNewAddress.routeName: (_) => const AddNewAddress(),
  HomePage.routeName: (_) => const HomePage(),
  LoginPage.routeName: (_) => const LoginPage(),
  UserProfile.routeName: (_) => const UserProfile(),
  ShoppingCart.routeName: (_) => const ShoppingCart(),
  ProductAddingPage.routeName: (_) => ProductAddingPage(),
  ChangePasswordPage.routeName: (context) => const ChangePasswordPage(),
  ManageOrderPage.routeName: (_) => const ManageOrderPage(),
  SendNotificationPage.routeName: (_) => const SendNotificationPage(),
  SubscriptionPage.routeName: (_) => const SubscriptionPage(),
  ManageProduct.routeName: (_) => const ManageProduct(),
  SignupPage.routeName: (_) => SignupPage(),
  EarnPointsPage.route: (_) => const EarnPointsPage(),
  AwardPointsPage.route: (_) => const AwardPointsPage(),
  TaskVideoPage.route: (_) => const TaskVideoPage(),
  UserAddressesList.routeName: (_) => const UserAddressesList(),
  UserOrders.routeName: (_) => const UserOrders(),
  WishListPage.routeName: (_) => const WishListPage(),
  SelectDeliveryAddress.routeName: (_) => const SelectDeliveryAddress(),
  Checkout.routeName: (_) => const Checkout(),
  HelpCenter.routeName: (_) => HelpCenter(),
  NotificationPage.routeName: (_) => const NotificationPage(),
  PersonalProfilePage.routeName: (_) => const PersonalProfilePage(),
  ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
};
