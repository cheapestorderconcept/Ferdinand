import 'dart:convert';

import 'package:ferdinand_coffee/components/form.dart';
import 'package:ferdinand_coffee/components/mainsubmitbutton.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/model/productlist.dart';
import 'package:ferdinand_coffee/provider/add_product_provider.dart';
import 'package:ferdinand_coffee/services/admin/add_product.dart';
import 'package:ferdinand_coffee/utils/helpers/fetch_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../components/fluttertoast.dart';
import '../../../model/productlist.dart';
import '../../../services/images/upload_images.dart';
import '../../../utils/helpers/image_picker.dart';

String? productName;
String? productPrice;
String? productDesc;
String? productType;
String? aboutProduct;
String? productPicture;
String? productVat;
String? variantsName;
String? variantsPrice;

class ProductAddingPage extends StatefulWidget {
  static const routeName = "/add-product";

  ProductAddingPage({Key? key}) : super(key: key);

  @override
  State<ProductAddingPage> createState() => _ProductAddingPageState();
}

class _ProductAddingPageState extends State<ProductAddingPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, ProductVariants> productVariants =
        context.watch<AddProductProviderAdmin>().productVariants;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: height * 0.05),
            Center(
              child: Image.asset(
                'assets/icons/logo.png',
                scale: 2.0,
              ),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.productPage,
                    style: const TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      productName = value;
                    },
                    labelText: AppLocalizations.of(context)!.productName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please product description';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      productDesc = value;
                    },
                    labelText: AppLocalizations.of(context)!.productDesc,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    inputType: TextInputType.number,
                    onChanged: (value) {
                      productVat = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter procuct type';
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.vat,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    maxLines: null,
                    onChanged: (value) {
                      aboutProduct = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter procuct type';
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.fullProductInfo,
                  ),
                  const SizedBox(height: 15),
                  CustomFormField(
                    onChanged: (v) {
                      variantsName = v;
                    },
                    labelText: AppLocalizations.of(context)!.variantName,
                  ),
                  const SizedBox(height: 15),
                  CustomFormField(
                    inputType: TextInputType.number,
                    onChanged: (v) {
                      variantsPrice = v;
                    },
                    labelText: AppLocalizations.of(context)!.variantPrice,
                  ),
                  const SizedBox(height: 15),
                  MainSubmitButton(
                    function: () {
                      final variants = ProductVariants(
                        name: variantsName,
                        price: double.parse('$variantsPrice'),
                      );
                      context
                          .read<AddProductProviderAdmin>()
                          .addVariant(variants);
                      displayToast(Colors.green, Colors.white,
                          AppLocalizations.of(context)!.variantsResponse);
                    },
                    buttonlabel: AppLocalizations.of(context)!.addVariant,
                  ),
                  const SizedBox(height: 15),
                  ...productVariants.values.map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            context
                                .read<AddProductProviderAdmin>()
                                .removeVariant('${e.name}');
                          },
                          child: Text(
                            '${AppLocalizations.of(context)!.variantName}:${e.name}, ${AppLocalizations.of(context)!.variantPrice}: ${e.price}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
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
                                setState(() {
                                  productPicture = key;
                                });
                              }
                            }
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            height: 100,
                            child: const Icon(
                              Icons.photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      fetchImage(
                          productPicture != null
                              ? "${Constants.baseUrl}/admin/download-image/$productPicture/${Constants.imageBucket}"
                              : 'https://cdn2.vectorstock.com/i/1000x1000/17/61/male-avatar-profile-picture-vector-10211761.jpg',
                          100,
                          100,
                          false),
                    ],
                  ),
                  CustomButton(
                    onTap: () {
                      if (productVariants.isEmpty) {
                        displayToast(Colors.red, Colors.white,
                            'You need to add at least one variant');
                      } else {
                        final variants = productVariants.values
                            .map((e) => e.toJson())
                            .toList();
                        if (_formKey.currentState!.validate()) {
                          AddProductToStore store = AddProductToStore();
                          store.addProduct(
                              productName,
                              productPrice,
                              productPicture,
                              variants,
                              productDesc,
                              aboutProduct,
                              productVat,
                              context);
                        }
                      }
                    },
                    buttonText: AppLocalizations.of(context)!.addProduct,
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
