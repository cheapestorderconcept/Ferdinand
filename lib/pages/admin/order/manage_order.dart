import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/services/admin/update_order.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

import '../../../components/form.dart';

class ManageOrderPage extends StatefulWidget {
  static const routeName = "/manage-order";

  const ManageOrderPage({Key? key, this.orderDetails}) : super(key: key);
  final Map<String, dynamic>? orderDetails;
  @override
  State<ManageOrderPage> createState() => _ManageOrderPageState();
}

class _ManageOrderPageState extends State<ManageOrderPage> {
  String? logisticName;
  String? arrivalDate;
  String? status;
  String? trackingNumber;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                'assets/icons/logo.png',
                scale: 2.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.updateOrder,
                    style: const TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    AppLocalizations.of(context)!.generalInstruction,
                    style: const TextStyle(
                        color: Constants.greyColor,
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.arrivalDate;
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.arrivalDate,
                    onChanged: (value) {
                      arrivalDate = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    labelText: AppLocalizations.of(context)!.shippedBy,
                    onChanged: (value) {
                      logisticName = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    labelText: AppLocalizations.of(context)!.orderStatus,
                    onChanged: (value) {
                      status = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    labelText: AppLocalizations.of(context)!.trackingNumber,
                    onChanged: (value) {
                      trackingNumber = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    buttonText: AppLocalizations.of(context)!.updateOrder,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        UpdateClientOrder updateClientOrder =
                            UpdateClientOrder();
                        updateClientOrder.updateOrder(
                            widget.orderDetails?["orderId"],
                            trackingNumber,
                            logisticName,
                            status,
                            arrivalDate);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
