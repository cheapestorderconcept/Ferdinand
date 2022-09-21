import 'package:ferdinand_coffee/components/form.dart';
import 'package:ferdinand_coffee/components/mainsubmitbutton.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/model/productlist.dart';
import 'package:ferdinand_coffee/services/admin/add_product.dart';
import 'package:ferdinand_coffee/utils/helpers/fetch_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../components/fluttertoast.dart';
import '../../../services/images/upload_images.dart';
import '../../../utils/helpers/image_picker.dart';

class ManageProduct extends StatefulWidget {
  static const routeName = "/manage-product";

  const ManageProduct({Key? key, this.productDetails}) : super(key: key);

  final Map<String, dynamic>? productDetails;

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? productName;
  TextEditingController? productPrice;
  TextEditingController? productDesc;
  TextEditingController? productImage;
  TextEditingController? productVat;
  TextEditingController? em;
  @override
  void initState() {
    productName = TextEditingController()
      ..text = widget.productDetails?["productName"];
    productPrice = TextEditingController()
      ..text = '${widget.productDetails?["productPrice"]}';
    productDesc = TextEditingController()
      ..text = '${widget.productDetails?["aboutProduct"]}';
    productImage = TextEditingController()
      ..text = '${widget.productDetails?["productPicture"]}';
    productVat = TextEditingController()
      ..text = '${widget.productDetails?["productVat"]}';
    List productVariants = widget.productDetails?["productVariants"];
    for (var i = 0; i < productVariants.length; i++) {
      controllers.add(TextEditingController(text: productVariants[i].name));
      variantPrice
          .add(TextEditingController(text: '${productVariants[i].price}'));
      priceWithVat.add(
          TextEditingController(text: '${productVariants[i].priceWithVat}'));
    }
    super.initState();
  }

  List<TextEditingController> controllers = [];
  List<TextEditingController> variantPrice = [];
  List<TextEditingController> priceWithVat = [];
  List<Map<String, ProductVariants>>? data;
  @override
  Widget build(BuildContext context) {
    List<ProductVariants> productVariants =
        widget.productDetails?["productVariants"];
    print(productVariants);
    String? productId = widget.productDetails?["productId"];
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
                    AppLocalizations.of(context)!.updateProduct,
                    style: const TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: InkWell(
                      onTap: () async {
                        final image = await imagePicker('gallery');
                        if (image == null) {
                          displayToast(Colors.red, Colors.white,
                              'You have not selected any image');
                        } else {
                          String fileName = image.path.split('/').last;
                          String path = image.path;
                          ImageUploader uploader = ImageUploader();
                          String? key = await uploader.uploadImage(
                              fileName, path, 'image', 'jpeg', context);

                          if (key != null) {
                            setState(() {
                              productImage?.text = key;
                            });
                          }
                        }
                      },
                      child: fetchImage(
                          "${Constants.baseUrl}/admin/download-image/${productImage?.text}/${Constants.imageBucket}",
                          100,
                          100,
                          true),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    controller: productName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.productName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: List.generate(productVariants.length, (index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CustomFormField(
                              controller: controllers[index],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Variantenname';
                                }
                                return null;
                              },
                              labelText: 'Variantenname',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CustomFormField(
                                controller: variantPrice[index],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Bitte Produktpreis ohne MwSt. eingeben';
                                  }
                                  return null;
                                },
                                labelText: AppLocalizations.of(context)!
                                    .priceWithoutVat),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CustomFormField(
                                controller: priceWithVat[index],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Bitte Produktpreis zzgl. MwSt. eingeben';
                                  }
                                  return null;
                                },
                                labelText:
                                    AppLocalizations.of(context)!.priceWithVat),
                          ),
                          MainSubmitButton(
                            function: () {
                              print(priceWithVat[index].text);
                              productVariants[index] = ProductVariants(
                                name: controllers[index].text,
                                price: num.parse(
                                  variantPrice[index].text,
                                ),
                                priceWithVat: num.parse(
                                  priceWithVat[index].text,
                                ),
                              );
                              displayToast(Colors.green, Colors.white,
                                  'Variants Updated. Click on update product button to save');
                            },
                            buttonlabel:
                                AppLocalizations.of(context)!.updateVariants,
                          )
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    inputType: TextInputType.number,
                    controller: productVat,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.vat;
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please product description';
                      }
                      return null;
                    },
                    controller: productDesc,
                    labelText: AppLocalizations.of(context)!.productDesc,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      onTap: () {
                        print(productVariants.map((e) => e.toJson()).toList());
                        if (_formKey.currentState!.validate()) {
                          UpdateProductapi _updateProduct = UpdateProductapi();
                          _updateProduct.updateProduct(
                              productId,
                              productName?.text,
                              productVariants.map((e) => e.toJson()).toList(),
                              productDesc?.text,
                              productImage?.text,
                              productVat?.text,
                              context);
                        }
                      },
                      buttonText: AppLocalizations.of(context)!.updateProduct),
                ],
              ),
            ),
            const SizedBox(height: 10),
            MainSubmitButton(
              function: () {
                DeleteProductapi deleteProductapi = DeleteProductapi();
                deleteProductapi.deleteProduct(productId, context);
              },
              buttonlabel: 'Produkt löschen',
              buttoncolor: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
