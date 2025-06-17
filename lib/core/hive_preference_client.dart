import 'dart:convert';
import 'package:messenger/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';

const String BOX_PREFERENCE = 'preference';

class HivePreferenceClient{

  HivePreferenceClient._privateConstructor();

  late Box box;

  static final HivePreferenceClient instance = HivePreferenceClient._privateConstructor();

  init() async {
    await Hive.initFlutter();
    await Hive.openBox(BOX_PREFERENCE);
  }

  setString(String key, String value){
    box = Hive.box(BOX_PREFERENCE);
    box.put(key, value);
  }

  String getString(String key){
    box = Hive.box(BOX_PREFERENCE);
    return box.get(key, defaultValue: '');
  }

  UserModel getUser(){
    box = Hive.box(BOX_PREFERENCE);
    var dataHive=box.get(USER_KEY, defaultValue: '');
    if(dataHive.toString().isNotEmpty){
      return UserModel.fromString(jsonDecode(dataHive));
    }
    return UserModel.empty();
  }

}