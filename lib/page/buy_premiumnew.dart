// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../generated/l10n.dart';
import '../model/purchasable_product.dart';
import '../repo/iap_repo.dart';
import '../stores/logic/dash_counter.dart';
import '../stores/logic/dash_purchases.dart';
import '../stores/logic/firebase_notifier.dart';
import 'login_page.dart';

const bool _kAutoConsume = true;

//const String _kConsumableId = 'consumable';//消耗品
// const String _kUpgradeId = 'oneclickvpn_oneyear';
// const String _kSilverSubscriptionId = 'oneclickvpn_onemonth';
// const String _kGoldSubscriptionId = 'oneclickvpn_6month';
// const String _kUpgradeId = 'upgrade';
// const String _kSilverSubscriptionId = 'subscription_silver';
// const String _kGoldSubscriptionId = 'subscription_gold';
// const List<String> _kProductIds = <String>[
//   // _kConsumableId,
//   _kUpgradeId,
//   _kSilverSubscriptionId,
//   _kGoldSubscriptionId,
// ];

class BuyPremiumNew extends StatefulWidget {
  @override
  _BuyPremiumNewState createState() => _BuyPremiumNewState();
}

class _BuyPremiumNewState extends State<BuyPremiumNew> {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    var firebaseNotifier = context.watch<FirebaseNotifier>();
    // if (!firebaseNotifier.loggedIn) {
    //   return const LoginPage();
    // }
    stack.add(
      ListView(
        children: [
          _buildConnectionCheckTile(),
          _buildProductList(),
          // _buildConsumableBox(),
          !firebaseNotifier.loggedIn
              ? _buildButton(S.current.Pleaseloginfirst, () {
                  firebaseNotifier.login();
                })
              : Container(),
          // _buildClientProductList()
        ],
      ),
    );
    // else {
    //   stack.add(Center(
    //     child: Text(_queryProductError!),
    //   ));
    // }
    // if (_purchasePending) {
    //   stack.add(
    //     const Stack(
    //       children: [
    //         Opacity(
    //           opacity: 0.3,
    //           child: ModalBarrier(dismissible: false, color: Colors.grey),
    //         ),
    //         Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: Colors.white,
              highlightColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const SizedBox(width: 24),
                    const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 30,
                      weight: 100,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      S.of(context).hichatbotpro,
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 26,
                        height: 0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF6F1F1),
        elevation: 0,
      ),
      body: Stack(
        children: stack,
      ),
    );
  }

  Widget _buildConnectionCheckTile() {
    // if (_loading) {
    //   return Card(child: ListTile(title: const Text('Trying to connect...')));
    // }
    // final Widget storeHeader = ListTile(
    //   leading: Icon(_isAvailable ? Icons.check : Icons.block,
    //       color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
    //   title: Text(
    //       'The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
    // );
    // const Widget storeHeader = Text(
    //   'PREMIUM',
    //   style: TextStyle(
    //     fontSize: 30,
    //     color: Colors.black,
    //     fontWeight: FontWeight.w900,
    //   ),
    // );
    // final List<Widget> children = <Widget>[storeHeader];
    final List<Widget> children = <Widget>[];
    final Widget premiumNotes = Padding(
      padding: EdgeInsets.only(top: 1.0),
      child: Center(
        child: Container(
          //height: 210.h,
          width: 350,
          // decoration: BoxDecoration(
          //   gradient: const LinearGradient(colors: [
          //     //orange.........
          //     Color(0xfff12711),
          //     Color(0xfff5af19),
          //     // Colors.black12,
          //     // Colors.black,
          //   ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          //   border: Border.all(color: Colors.deepOrange),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getpremiumNoteschildren(),
            // children:
            // [
            //   Padding(
            //     padding: EdgeInsets.only(top: 5.0, left: 58, right: 58),
            //     child: Text(
            //       '介绍一',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(top: 5.0, left: 58, right: 58),
            //     child: Text(
            //       '说明二',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(top: 5.0, left: 58, right: 58),
            //     child: Text(
            //       '说明三',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(top: 5.0, left: 58, right: 58),
            //     child: Text(
            //       '说明四',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            //   SizedBox(
            //     height: 24,
            //   ),
            // ],
          ),
        ),
      ),
    );
    children.add(premiumNotes);

    return Column(children: children);
  }

  _getpremiumNoteschildren() {
    List<Widget> children = [];
    for (var element in purchasedetails) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        // padding: const EdgeInsets.all(5),
        child: Container(
          constraints: const BoxConstraints(minWidth: 350, minHeight: 48.0),
          // padding: EdgeInsets.all(12),
          // alignment: Alignment.center,
          child: ListTile(
            leading: Image.asset(
              element["icon"],
              width: 45,
            ),
            title: Text(
              element['title'],
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  // letterSpacing: 1,
                  fontSize: 20,
                  color: Colors.black),
            ),
            subtitle: Text(element['detail']),
          ),
        ),
        // child: Ink(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Colors.red,
        //         Colors.redAccent,
        //       ],
        //     ),
        //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
        //   ),
        //   child: Container(
        //     constraints: const BoxConstraints(minWidth: 350, minHeight: 48.0),
        //     // padding: EdgeInsets.all(12),
        //     // alignment: Alignment.center,
        //     child: ListTile(
        //       leading: Image.asset(
        //         element["icon"],
        //         width: 45,
        //       ),
        //       title: Text(
        //         element['title'],
        //       ),
        //       subtitle: Text(element['detail']),
        //     ),
        //   ),
        // ),
      ));
    }
    return children;
  }

  Widget _buildProductList() {
    var purchases = context.watch<DashPurchases>();
    var products = purchases.products;
    var firebaseNotifier = context.watch<FirebaseNotifier>();

    if (products.isEmpty && firebaseNotifier.loggedIn) {
      return Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.pink[350],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.pinkAccent.withOpacity(0.5),
              offset: const Offset(0, 1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ElevatedButton(
            //..........................start the workout...........................
            onPressed: () {
              purchases.loadPurchases();
            },
            style: ElevatedButton.styleFrom(
              elevation: 15,
              shadowColor: Colors.black12,
              padding: const EdgeInsets.all(0.0),
              primary: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Container(
              constraints: BoxConstraints(minWidth: 350, minHeight: 48.0),
              padding: EdgeInsets.all(12),
              // alignment: Alignment.center,
              child: ListTile(
                title: Text(
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      // letterSpacing: 1,
                      fontSize: 18,
                      color: Colors.black),
                  S.current.getproducts,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: products
          .map((product) => _PurchaseWidget(
              product: product,
              onPressed: () {
                firebaseNotifier.loggedIn
                    ? purchases.buy(product)
                    : firebaseNotifier.login();
              }))
          .toList(),
    );
  }

  Widget _buildButton(String? text, VoidCallback onPressed) {
    // if (_loading) {
    //   return Container();
    // }
    var firebaseNotifier = context.watch<FirebaseNotifier>();

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        //..........................start the workout...........................
        // onPressed: () => firebaseNotifier.login(),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 15,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(0.0),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(minWidth: 350, minHeight: 30.0),
            padding: const EdgeInsets.all(12),
            // alignment: Alignment.center,
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  // letterSpacing: 1,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _PurchaseWidget extends StatelessWidget {
  final PurchasableProduct product;
  final VoidCallback onPressed;

  const _PurchaseWidget({
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var title = product.title;
    var purchases = context.watch<IAPRepo>().purchases;
    String trailing = product.price;
    // for (var element in purchases) {
    //   if(product.price==element.)
    // }
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Colors.pink[350],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.5),
            offset: const Offset(0, 1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ElevatedButton(
          //..........................start the workout...........................
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 15,
            shadowColor: Colors.black12,
            padding: const EdgeInsets.all(0.0),
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Container(
            constraints: BoxConstraints(minWidth: 350, minHeight: 48.0),
            padding: EdgeInsets.all(1),
            // alignment: Alignment.center,
            child: ListTile(
              title: Text(
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    // letterSpacing: 1,
                    fontSize: 18,
                    color: Colors.black),
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(product.description),
              trailing: Text(
                _trailing(),
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    // letterSpacing: 1,
                    fontSize: 15,
                    color: Colors.black38),
              ),
            ),
          ),
        ),
      ),
    );
    // return InkWell(
    //     onTap: onPressed,
    //     child: ListTile(
    //       title: Text(
    //         title,
    //       ),
    //       subtitle: Text(product.description),
    //       trailing: Text(_trailing()),
    //     ));
  }

  String _trailing() {
    return switch (product.status) {
      ProductStatus.purchasable => product.price,
      ProductStatus.purchased => S.current.purchased,
      ProductStatus.pending => S.current.buying
    };
  }
}
