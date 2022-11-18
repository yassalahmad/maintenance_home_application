

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../modal/products_model.dart';

class ServiceProvider with ChangeNotifier{

  //////////////// Making Object of ProductModel ////////////////////////
  late ProductModel productModel;

  List<ProductModel> search = [];
  
  /////////////// Making a Function to Save Ourself From Writing same code again and again
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      userImage: element.get('profileImage'),
      userName: element.get('username'),
      userMobileNo: element.get('mobileNo'),
      userArea: element.get('area'),
      userCity: element.get('city'),
      userUid: "",
      userProfession: element.get('profession'),
    );
    search.add(productModel);
  }

  List<ProductModel> adminProductList = [];

  // Get Admin Products
  void getServiceProviders() async {
    ProductModel _productModel;
    List<ProductModel> _newList = [];
    QuerySnapshot value = (await FirebaseFirestore.instance
        .collection("Service Provider")
        .doc(FirebaseAuth.instance.currentUser!.uid).get()) as QuerySnapshot;
    value.docs.forEach((data) {
      _productModel = ProductModel(
        userImage: data.get('profileImage'),
        userName: data.get('username'),
        userMobileNo: data.get('mobileNo'),
        userUid: data.get("userUid"),
        userArea: data.get("area"),
        userCity: data.get("city"),
        userProfession: data.get("profession"),
      );
      _newList.add(_productModel);
      notifyListeners();
    });
    adminProductList = _newList;
    notifyListeners();
  }

  List<ProductModel> get getAdminProductsList {
    return adminProductList;
  }

}