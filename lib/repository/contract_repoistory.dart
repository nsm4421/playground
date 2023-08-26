import 'dart:developer';

import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contractRepositoryProvider =
    Provider((ref) => ContractRepository(FirebaseFirestore.instance));

class ContractRepository {
  final FirebaseFirestore firebaseFirestore;

  ContractRepository(this.firebaseFirestore);

  Future<List<List<UserModel>>> getAllContracts() async {
    List<UserModel> firebaseContracts = [];
    List<UserModel> phoneContracts = [];
    try {
      // 권한(연락처) 체크
      final contractPermission = await FlutterContacts.requestPermission();
      if (!contractPermission) throw Exception('Permission Denied');

      final users = await firebaseFirestore.collection('users').get();
      final contracts = await FlutterContacts.getContacts(withProperties: true);
      bool isContractFound = false;
      // Phone에 있는 연락처들에 대해, DB에 있는 연락처인지 확인
      // 만약 DB에 있는 전화번호면, firebaseContracts 리스트에 추가
      // DB에 없는 전화번호면, phoneContracts 리스트에 추가
      for (var contract in contracts) {
        isContractFound = false;
        var phoneNumberInPhone = contract.phones[0].number.replaceAll(' ', '');
        for (var doc in users.docs) {
          print(doc);
          var userInDB = UserModel.fromJson(doc.data());
          if (userInDB.phoneNumber == phoneNumberInPhone) {
            firebaseContracts.add(userInDB);
            isContractFound = true;
            break;
          }
        }
        if (!isContractFound) {
          phoneContracts.add(
            UserModel(
              username: contract.displayName,
              uid: '',
              profileImageUrl: '',
              active: false,
              phoneNumber: phoneNumberInPhone,
              groupId: [],
            ),
          );
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return [firebaseContracts, phoneContracts];
  }
}
