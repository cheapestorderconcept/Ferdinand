import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/model/profile.dart';
import 'package:ferdinand_coffee/pages/home/home.dart';
import 'package:ferdinand_coffee/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/order_card.dart';
import '../../model/client_order.dart';
import '../../services/order/place_order.dart';
import '../admin/order/manage_order.dart';

class UserOrders extends StatelessWidget {
  static const routeName = "/user/all-orders";

  const UserOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetPlacedOrder fetchOrder = GetPlacedOrder();
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 25,
        title: Text(AppLocalizations.of(context)!.orderHistory),
        actions: [
          Image.asset(
            'assets/icons/logo.png',
            scale: 6,
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: FutureBuilder<ClientOrderModel?>(
          future: fetchOrder.placeOrder(context),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              final order = asyncSnapshot.data?.placedOrder;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (context
                              .read<ProfileProvider>()
                              .myprofileModel
                              ?.role !=
                          ProfileModel.clientrole) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ManageOrderPage(
                              orderDetails: {"orderId": order?[index].sId},
                            );
                          }),
                        );
                      }
                    },
                    child: OrderPlacementCard(
                      image: order?[index].productImage,
                      status: order?[index].orderStatus,
                      productName: order?[index].productName,
                      referenceNumber: order?[index].sId,
                    ),
                  );
                },
                separatorBuilder: (c, i) => const SizedBox(
                  height: 20,
                ),
                itemCount: order!.length,
              );
            } else if (asyncSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(left: 150.0),
                child: FutureBuilderLoadingIndicator(),
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
    );
  }
}
