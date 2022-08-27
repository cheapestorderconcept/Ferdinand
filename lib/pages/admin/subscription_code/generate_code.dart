import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';
import '../../../components/form.dart';
import '../../../services/admin/generate_discount_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionPage extends StatefulWidget {
  static const routeName = "/gen-code";

  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String? newPassword;
  String? discountName;
  String? percentage;
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
                    AppLocalizations.of(context)!.generateSubCode,
                    style: const TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Discount name';
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.discountName,
                    onChanged: (value) {
                      discountName = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    inputType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter enter number of percentage off e.g 5';
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.percentage,
                    onChanged: (value) {
                      percentage = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: AppLocalizations.of(context)!.broadCast,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        GeneratePromoCodeApi _generateCode =
                            GeneratePromoCodeApi();
                        _generateCode.generateCode(
                            percentage, discountName, context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: AppLocalizations.of(context)!.invalidateCode,
                    onTap: () {
                      ExpiredCode _expiredCode = ExpiredCode();
                      _expiredCode.expiredCode();
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
