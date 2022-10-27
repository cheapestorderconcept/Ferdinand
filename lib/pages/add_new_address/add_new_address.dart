import 'dart:async';

// import 'package:ecommerce_ui/providers/address.dart';
import 'package:ferdinand_coffee/components/mainsubmitbutton.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/provider/shipping_address_provider.dart';
import 'package:ferdinand_coffee/services/auth/add_shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewAddress extends StatefulWidget {
  static const routeName = "/address/new";

  const AddNewAddress({
    Key? key,
  }) : super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  _AddNewAddressState();

  final key = GlobalKey<FormState>();
  Completer<GoogleMapController> mapController = Completer();
  String street = "Choose Location";
  String province = "";
  LatLng center = const LatLng(22.1399153, -100.9734282);
  Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;

  LatLng _lastMapPosition = const LatLng(22.1399153, -100.9734282);

  String title = "choose location";

  _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  _onCameraMove(CameraPosition position) async {
    _lastMapPosition = position.target;
  }

  bool isFirst = true;
  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? mobile;
  TextEditingController? landregion;
  TextEditingController? zipCode;
  TextEditingController? myAddress;
  @override
  void initState() {
    //csll shipping address endpoint
    final shippingInfo =
        context.read<ShippingAddressProvider>().shippingAddress;
    firstName = TextEditingController()..text = shippingInfo?.firstName ?? "";
    lastName = TextEditingController()..text = shippingInfo?.lastName ?? "";
    myAddress = TextEditingController()..text = shippingInfo?.address ?? "";
    mobile = TextEditingController()..text = shippingInfo?.phoneNumber ?? "";
    zipCode = TextEditingController()..text = shippingInfo?.zipCode ?? "";
    landregion = TextEditingController()..text = shippingInfo?.region ?? "";
    super.initState();
    // _center = LatLng(lat, lang);
    // _lastMapPosition = _center;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 25,
        title: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.addAddress)),
        actions: const [],
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Constants.orangeColor),
                    borderRadius: BorderRadius.circular(3)),
                height: MediaQuery.of(context).size.height / 2.3,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GoogleMap(
                    mapToolbarEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onCameraIdle: () {
                      placemarkFromCoordinates(_lastMapPosition.latitude,
                              _lastMapPosition.longitude)
                          .then((value) {
                        setState(() {
                          street = value[0].name! +
                              " " +
                              value[0].street! +
                              " " +
                              value[0].locality!;
                          province = value[0].subLocality!;
                        });
                      });
                    },
                    onTap: (e) {
                      _markers = {};
                    },
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: center,
                      zoom: 19.0,
                    ),
                    mapType: MapType.normal,
                    onCameraMove: _onCameraMove,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppFormField(
                              fieldcontroller: firstName,
                              labeltext:
                                  AppLocalizations.of(context)!.firstName,
                              hinttext: AppLocalizations.of(context)!.firstName,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: AppFormField(
                              fieldcontroller: lastName,
                              hinttext: AppLocalizations.of(context)!.lastName,
                              labeltext: AppLocalizations.of(context)!.lastName,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                      ),
                      child: AppFormField(
                        fieldcontroller: myAddress,
                        hinttext: 'Enter aaddress',
                        labeltext: AppLocalizations.of(context)!.enterAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                      ),
                      child: AppFormField(
                        fieldcontroller: zipCode,
                        hinttext: AppLocalizations.of(context)!.zipCode,
                        labeltext: AppLocalizations.of(context)!.zipCode,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                      ),
                      child: AppFormField(
                        fieldcontroller: landregion,
                        hinttext: 'Enter Land Region',
                        labeltext: AppLocalizations.of(context)!.landRegion,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            height: 95,
                            // width: 360,1
                            // width: 340,
                            child: SizedBox(
                                child: AppFormField(
                              fieldcontroller: mobile,
                              hinttext: 'Enter Mobile Number',
                              labeltext:
                                  AppLocalizations.of(context)!.phoneNumber,
                            )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 20,
                      ),
                      child: MainSubmitButton(
                          function: () {
                            final AddShippingAddressApi addShippingAddressApi =
                                AddShippingAddressApi();
                            addShippingAddressApi.postAddress(
                                firstName?.text,
                                lastName?.text,
                                myAddress?.text,
                                zipCode?.text,
                                mobile?.text,
                                landregion?.text,
                                context);
                            // Navigator.pop(context);
                          },
                          buttonlabel:
                              AppLocalizations.of(context)!.addAddress),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppFormField extends StatelessWidget {
  const AppFormField({
    Key? key,
    required this.fieldcontroller,
    required this.hinttext,
    required this.labeltext,
  }) : super(key: key);

  final TextEditingController? fieldcontroller;
  final String hinttext;
  final String labeltext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldcontroller,
      validator: (val) {
        if (val == "") {
          return "Please Enter First name";
        } else {
          return null;
        }
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              color: Color.fromRGBO(241, 241, 241, 1), width: 1.5),
        ),

        labelStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.white, fontSize: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: Constants.orangeColor, width: 1.5),
        ),
        hintText: hinttext, //first name
        labelText: labeltext,

        alignLabelWithHint: true,
        hintStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(152, 152, 152, 1)),
      ),
    );
  }
}

class MapScreenArg {
  final double lat;
  final double lang;

  MapScreenArg(this.lat, this.lang);
}
