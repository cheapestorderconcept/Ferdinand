import 'package:ferdinand_coffee/components/fluttertoast.dart';
import 'package:ferdinand_coffee/components/product_card.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/model/productlist.dart';
import 'package:ferdinand_coffee/model/profile.dart';
import 'package:ferdinand_coffee/pages/admin/notification/broadcast.dart';
import 'package:ferdinand_coffee/pages/admin/order/manage_order.dart';
import 'package:ferdinand_coffee/pages/admin/product/add_product.dart';
import 'package:ferdinand_coffee/pages/admin/product/manage_product.dart';
import 'package:ferdinand_coffee/pages/admin/subscription_code/generate_code.dart';
import 'package:ferdinand_coffee/pages/login/login.dart';
import 'package:ferdinand_coffee/pages/points-system/award_points.dart';
import 'package:ferdinand_coffee/pages/points-system/earn_points.dart';
import 'package:ferdinand_coffee/pages/support/support.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ferdinand_coffee/pages/profile/personal_profile.dart';
import 'package:ferdinand_coffee/pages/shopping_cart/shopping_cart.dart';
import 'package:ferdinand_coffee/pages/user_orders/user_orders.dart';
import 'package:ferdinand_coffee/pages/wishlist/wishlist.dart';
import 'package:ferdinand_coffee/provider/cart.dart';
import 'package:ferdinand_coffee/provider/profile_provider.dart';
import 'package:ferdinand_coffee/services/auth/profile.dart';
import 'package:ferdinand_coffee/services/preload/product.dart';
import 'package:ferdinand_coffee/utils/helpers/fetch_image.dart';
import 'package:ferdinand_coffee/utils/helpers/firebase_cloud_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/auth/add_shipping_address.dart';
import '../../services/images/upload_images.dart';
import '../../utils/helpers/image_picker.dart';
import '../add_new_address/add_new_address.dart';
import '../password/change_password.dart';
import '../product_details/product_details.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    UserProfileApi profileApi = UserProfileApi();
    final GetShippingAddress shippingAddress = GetShippingAddress();
    shippingAddress.getShippingAddress(context);
    profileApi.userProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<ProfileProvider>(context).myprofileModel;
    bool isClient = currentUser?.role == ProfileModel.clientrole ||
        currentUser?.role == null;

    GetAllStoreProduct storeProduct = GetAllStoreProduct();
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      drawer: const HomeDrawer(),
      appBar: PreferredSize(
        child: const CustomAppBar(),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          70,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await storeProduct.fetchProduct(context);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Constants.rustColor,
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/temp/header-ferdinand.jpeg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.topSelling,
              style: const TextStyle(
                color: Constants.greyColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<ProductListModel?>(
                future: storeProduct.fetchProduct(context),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final product = snapshot.data?.product;

                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 3.0,
                      child: ListView.separated(
                        separatorBuilder: (c, i) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: product!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            onTap: () {
                              if (currentUser?.role ==
                                      ProfileModel.clientrole ||
                                  currentUser?.role == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ProductDetailsPage(
                                      productDetails: {
                                        "productId": product[index].sId,
                                        "productVat": product[index].vat,
                                        "productVariants":
                                            product[index].productVariants,
                                        "productPicture":
                                            product[index].productPictures,
                                        "productName":
                                            product[index].productName,
                                        "productPrice": product[index]
                                            .productVariants?[0]
                                            .priceWithVat,
                                        "productDesc":
                                            product[index].productDescription,
                                        "aboutProduct":
                                            product[index].aboutProduct,
                                      },
                                    );
                                  }),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ManageProduct(
                                      productDetails: {
                                        "productVat": product[index].vat,
                                        "productVariants":
                                            product[index].productVariants,
                                        "productPicture":
                                            product[index].productPictures,
                                        "productName":
                                            product[index].productName,
                                        "productPrice":
                                            product[index].productPrice,
                                        "productDesc":
                                            product[index].productDescription,
                                        "aboutProduct":
                                            product[index].aboutProduct,
                                        "productId": product[index].sId,
                                      },
                                    );
                                  }),
                                );
                              }
                            },
                            productPicture:
                                '${Constants.baseUrl}/admin/download-image/${product[index].productPictures}/${Constants.imageBucket}',
                            productName: product[index].productName,
                            productPrice:
                                '${product[index].productVariants?[0].priceWithVat}',
                            productId: product[index].sId,
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const FutureBuilderLoadingIndicator();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const FutureBuilderLoadingIndicator();
                  } else {
                    return Center(
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          AppLocalizations.of(context)!.noOrder,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                })),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.allProduct,
              style: const TextStyle(
                color: Constants.greyColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<ProductListModel?>(
                future: storeProduct.fetchProduct(context),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    final product = snapShot.data?.product;
                    return SizedBox(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio:
                                MediaQuery.of(context).size.aspectRatio / 0.66),
                        itemCount: product?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            productId: product?[index].sId,
                            productPicture:
                                '${Constants.baseUrl}/admin/download-image/${product?[index].productPictures}/${Constants.imageBucket}',
                            productName: product?[index].productName,
                            productPrice:
                                '${product?[index].productVariants?[0].priceWithVat}',
                            onTap: () {
                              if (isClient == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ProductDetailsPage(
                                      productDetails: {
                                        "productId": product?[index].sId,
                                        "productVat": product?[index].vat,
                                        "productPicture":
                                            product?[index].productPictures,
                                        "productVariants":
                                            product?[index].productVariants,
                                        "productName":
                                            product?[index].productName,
                                        "productPrice":
                                            product?[index].productPrice,
                                        "productDesc":
                                            product?[index].productDescription,
                                        "aboutProduct":
                                            product?[index].aboutProduct,
                                      },
                                    );
                                  }),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ManageProduct(
                                      productDetails: {
                                        "productVariants":
                                            product?[index].productVariants,
                                        "productVat": product?[index].vat,
                                        "productPicture":
                                            product?[index].productPictures,
                                        "productName":
                                            product?[index].productName,
                                        "productPrice": product?[index]
                                            .productVariants?[0]
                                            .price,
                                        "productDesc":
                                            product?[index].productDescription,
                                        "aboutProduct":
                                            product?[index].aboutProduct,
                                        "productId": product?[index].sId,
                                      },
                                    );
                                  }),
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    return const FutureBuilderLoadingIndicator();
                  } else if (snapShot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 70.0, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            strokeWidth: 4.0,
                            backgroundColor: Colors.white,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          AppLocalizations.of(context)!.noOrder,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class FutureBuilderLoadingIndicator extends StatelessWidget {
  const FutureBuilderLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            strokeWidth: 4.0,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          )
        ],
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    final PushNotification _notification = PushNotification();
    _notification.initializeNotification();
    _notification.getInitialNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalitems = Provider.of<CartProvider>(context).item.length;
    final itemInCart = Provider.of<CartProvider>(context).item;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff577860),
            Color(0xff577860),
            Color(0xff577860),
          ],
        ),
      ),
      child: AppBar(
        primary: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        title: Image.asset(
          'assets/icons/logo_white.png',
          scale: 1.6,
        ),
        leading: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Image.asset(
            'assets/icons/menu.png',
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              if (itemInCart.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  ShoppingCart.routeName,
                );
              } else {
                displayToast(Colors.red, Colors.white,
                    AppLocalizations.of(context)!.checkoutError);
              }
            },
            child: SizedBox(
              width: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/icons/cart.png',
                    scale: 2.0,
                  ),
                  Positioned(
                    right: 5,
                    top: 11,
                    child: Container(
                      width: 15,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Constants.orangeColor,
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 1, color: Constants.greyColor)),
                      child: Center(
                          child: Text('$totalitems',
                              style: const TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold))),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<ProfileProvider>(context).myprofileModel;
    double horizontalgapspace = 10;
    bool isClient = currentUser?.role == ProfileModel.clientrole ||
        currentUser?.role == null;
    return Drawer(
      backgroundColor: Constants.drawerBgColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final image = await imagePicker('gallery');
                if (image == null) {
                  displayToast(Colors.red, Colors.white,
                      AppLocalizations.of(context)!.noImage);
                } else {
                  String fileName = image.path.split('/').last;
                  String path = image.path;
                  ImageUploader uploader = ImageUploader();
                  String? key = await uploader.uploadImage(
                      fileName, path, 'image', 'jpeg', context);
                  if (key != null) {
                    Map<String, dynamic> data = {"image": key};
                    UpdateUserProfileApi updateUserProfileApi =
                        UpdateUserProfileApi();
                    updateUserProfileApi.updateProfile(data, context);
                  }
                }
              },
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Constants.greenColor),
                currentAccountPicture: fetchImage(
                    currentUser?.image != null
                        ? '${Constants.baseUrl}/admin/download-image/${currentUser?.image}/${Constants.imageBucket}'
                        : 'https://cdn2.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.jpg',
                    30,
                    30,
                    true),
                accountName: Text(
                  'Hi, ${currentUser?.firstName} ${currentUser?.lastName}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  '${currentUser?.points ?? '0'} ${AppLocalizations.of(context)!.points}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              dense: true,
              onTap: () {
                Navigator.pushNamed(context, PersonalProfilePage.routeName);
              },
              leading: Image.asset('assets/icons/my_account.png'),
              title: Text(AppLocalizations.of(context)!.myAccount,
                  style: const TextStyle(
                      fontSize: 15, color: Constants.greyColor)),
              minLeadingWidth: 0,
              horizontalTitleGap: horizontalgapspace,
            ),
            ListTile(
              dense: true,
              onTap: () {
                Navigator.pushNamed(context, UserOrders.routeName);
              },
              leading: Image.asset(
                'assets/icons/box.png',
                scale: 1.3,
              ),
              title: Text(
                  isClient
                      ? AppLocalizations.of(context)!.myOrders
                      : AppLocalizations.of(context)!.incomingOrders,
                  style: const TextStyle(
                      fontSize: 15, color: Constants.greyColor)),
              minLeadingWidth: 2,
              horizontalTitleGap: horizontalgapspace,
            ),
            ListTile(
              dense: true,
              onTap: () {
                if (isClient) {
                  Navigator.pushNamed(context, WishListPage.routeName);
                } else {
                  Navigator.pushNamed(context, ProductAddingPage.routeName);
                }
              },
              leading: Image.asset(
                'assets/icons/heart_grey.png',
                scale: 2,
              ),
              title: Text(
                isClient
                    ? AppLocalizations.of(context)!.myWishlist
                    : AppLocalizations.of(context)!.addProduct,
                style:
                    const TextStyle(fontSize: 15, color: Constants.greyColor),
              ),
              minLeadingWidth: 1,
              horizontalTitleGap: horizontalgapspace,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 50),
              child: Divider(
                thickness: 1.5,
                color: Constants.greyColor,
              ),
            ),
            ListTile(
              dense: true,
              onTap: () {
                isClient
                    ? Navigator.pushNamed(context, AddNewAddress.routeName)
                    : Navigator.pushNamed(
                        context, SendNotificationPage.routeName);
              },
              leading: Image.asset(
                'assets/icons/location.png',
                scale: 2,
              ),
              title: Text(
                  isClient
                      ? AppLocalizations.of(context)!.myAddress
                      : AppLocalizations.of(context)!.sendNotification,
                  style: const TextStyle(
                      fontSize: 15, color: Constants.greyColor)),
              minLeadingWidth: 2,
              horizontalTitleGap: horizontalgapspace,
            ),
            ListTile(
              dense: true,
              onTap: () {
                if (isClient) {
                  final totalItems = context.read<CartProvider>().item.length;
                  if (totalItems < 1) {
                    displayToast(Colors.red, Colors.white,
                        AppLocalizations.of(context)!.checkoutError);
                  } else {
                    Navigator.pushNamed(context, ShoppingCart.routeName);
                  }
                } else {
                  Navigator.pushNamed(context, SubscriptionPage.routeName);
                }
              },
              leading: Image.asset(
                'assets/icons/cart_.png',
                scale: 1.2,
              ),
              title: Text(
                  isClient
                      ? AppLocalizations.of(context)!.myCart
                      : AppLocalizations.of(context)!.generateSubCode,
                  style: const TextStyle(
                      fontSize: 15, color: Constants.greyColor)),
              minLeadingWidth: 0,
              horizontalTitleGap: horizontalgapspace,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 50),
              child: Divider(
                thickness: 1.5,
                color: Constants.greyColor,
              ),
            ),
            ListTile(
              dense: true,
              leading: Image.asset('assets/icons/Icon metro-lang.png'),
              title: InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  bool? isEnglish = prefs.getBool("isEnglish");
                  if (isEnglish == false) {
                    prefs.setBool("isEnglish", true);
                    displayToast(Constants.greenColor, Colors.white,
                        "Language set to english. Kindly restart the app");
                    FlutterSecureStorage storage = const FlutterSecureStorage();
                    await storage.delete(key: "token");
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const LoginPage()),
                      ModalRoute.withName(LoginPage.routeName),
                    );
                  } else {
                    displayToast(Constants.greenColor, Colors.white,
                        "Sprache auf Deutsch eingestellt. Bitte starten Sie die App neu");
                    prefs.setBool("isEnglish", false);
                    FlutterSecureStorage storage = const FlutterSecureStorage();
                    await storage.delete(key: "token");
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const LoginPage()),
                      ModalRoute.withName(LoginPage.routeName),
                    );
                  }
                },
                child: Text(AppLocalizations.of(context)!.changeLanguage,
                    style: const TextStyle(
                        fontSize: 15, color: Constants.greyColor)),
              ),
              minLeadingWidth: 0,
              horizontalTitleGap: horizontalgapspace,
            ),
            InkWell(
              onTap: () {
                
                Share.share(AppLocalizations.of(context)!
                    .referalMessage('${currentUser!.referralID}'));
              },
              child: ListTile(
                dense: true,
                leading: const Icon(
                  Icons.share,
                  color: Colors.white10,
                ),
                title: Text(AppLocalizations.of(context)!.inviteFriends,
                    style: const TextStyle(
                        fontSize: 15, color: Constants.greyColor)),
                minLeadingWidth: 0,
                horizontalTitleGap: horizontalgapspace,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, HelpCenter.routeName);
                //Navigate to the help page
              },
              child: ListTile(
                dense: true,
                leading: Image.asset('assets/icons/help.png'),
                title: Text(AppLocalizations.of(context)!.help,
                    style: const TextStyle(
                        fontSize: 15, color: Constants.greyColor)),
                minLeadingWidth: 0,
                horizontalTitleGap: horizontalgapspace,
              ),
            ),
            ListTile(
              dense: true,
              leading: Image.asset('assets/icons/fingerprint.png'),
              title: InkWell(
                onTap: () async {
                  Uri url = Uri.parse('https://ferdinand-coffee.ch/pages/agb');
                  await launchUrl(url);
                },
                child: Text(AppLocalizations.of(context)!.privacyPolicy,
                    style: const TextStyle(
                        fontSize: 15, color: Constants.greyColor)),
              ),
              minLeadingWidth: 1,
              horizontalTitleGap: horizontalgapspace,
            ),
            ListTile(
              dense: true,
              leading: Image.asset('assets/icons/settings.png'),
              title: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ChangePasswordPage.routeName);
                },
                child: Text(AppLocalizations.of(context)!.changePassword,
                    style: const TextStyle(
                        fontSize: 15, color: Constants.greyColor)),
              ),
              minLeadingWidth: 1,
              horizontalTitleGap: horizontalgapspace,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 50),
              child: Divider(
                thickness: 1.5,
                color: Constants.greyColor,
              ),
            ),
            ListTile(
              dense: true,
              leading: Image.asset('assets/icons/settings.png'),
              title: InkWell(
                onTap: () {
                  isClient
                      ? Navigator.pushNamed(context, EarnPointsPage.route)
                      : Navigator.pushNamed(context, AwardPointsPage.route);
                },
                child: Text(
                  isClient
                      ? AppLocalizations.of(context)!.earnPoints
                      : AppLocalizations.of(context)!.awardPoints,
                  style:
                      const TextStyle(fontSize: 15, color: Constants.greyColor),
                ),
              ),
              minLeadingWidth: 1,
              horizontalTitleGap: horizontalgapspace,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 50),
              child: Divider(
                thickness: 1.5,
                color: Constants.greyColor,
              ),
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 94, 26, 22),
              ),
              title: InkWell(
                onTap: () async {
                  FlutterSecureStorage storage = const FlutterSecureStorage();
                  await storage.delete(key: "token");
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginPage()),
                    ModalRoute.withName(LoginPage.routeName),
                  );
                },
                child: Text(AppLocalizations.of(context)!.logout,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 94, 26, 22),
                      fontWeight: FontWeight.bold,
                    )),
              ),
              minLeadingWidth: 1,
              horizontalTitleGap: horizontalgapspace,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset('assets/icons/logo_white.png')),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  SocialIcon(
                    imageurl: 'assets/icons/facebook.png',
                    onTap: () async {
                      Uri url =
                          Uri.parse('https://www.facebook.com/Ferdinandkaffee');
                      await launchUrl(url);
                    },
                  ),
                  SocialIcon(
                    imageurl: 'assets/icons/twitter (1).png',
                    onTap: () async {
                      Uri url =
                          Uri.parse('https://www.twitter.com/coffeeferdinand');
                      await launchUrl(url);
                    },
                  ),
                  SocialIcon(
                    imageurl: 'assets/icons/instagram.png',
                    onTap: () async {
                      Uri url = Uri.parse(
                          'https://www.instagram.com/ferdinandcoffeeshop');
                      await launchUrl(url);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    required this.imageurl,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Function() onTap;
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imageurl),
        ));
  }
}
