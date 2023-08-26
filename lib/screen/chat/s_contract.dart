import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/controller/contract_controller.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/screen/util/s_error.dart';
import 'package:chat_app/screen/util/s_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContractScreen extends ConsumerWidget {
  const ContractScreen({super.key});

  _handleGoBack(BuildContext context) => Navigator.pop(context);

  _handleSendSms(String phoneNumber) async {
    // TODO : SMS 초대메시지 수정하기
    Uri uri = Uri.parse("sms:$phoneNumber?body=채팅어플로초대합니다");
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double iconSize = 25;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            _handleGoBack(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: iconSize,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Contract",
          style: GoogleFonts.lobster(
            fontSize: iconSize,
          ),
        ),
        actions: [
          InkWell(
              // TODO
              onTap: () {},
              child: const Icon(
                Icons.search,
                size: iconSize,
              )),
          const Width(width: 10),
          InkWell(
              // TODO
              onTap: () {},
              child: const Icon(
                Icons.more_horiz,
                size: iconSize,
              )),
          const Width(width: 10),
        ],
      ),
      body: ref.watch(contractControllerProvider).when(
            data: (contracts) {
              List<UserModel> firebaseContracts = contracts[0];
              List<UserModel> phoneContracts = contracts[1];

              return ListView.builder(
                itemCount: phoneContracts.length + firebaseContracts.length,
                itemBuilder: (context, index) {
                  final bool isFirebaseContract =
                      index < firebaseContracts.length;
                  late UserModel? contract;

                  contract = isFirebaseContract
                      ? firebaseContracts[index]
                      : phoneContracts[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            "Contracts On Chat App (${firebaseContracts.length ?? 0})",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      if (index == firebaseContracts.length)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            "Contracts On Phone (${phoneContracts.length ?? 0})",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      const Height(height: 10),
                      ListTile(
                        title: Text(contract.username),
                        subtitle:
                            isFirebaseContract ? const Text('Chat app') : null,
                        dense: true,
                        leading: CircleAvatar(
                          radius: 20,
                          child: contract.profileImageUrl.isNotEmpty
                              ? Image.network(contract.profileImageUrl)
                              : const Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 20,
                          right: 10,
                          top: 0,
                          bottom: 0,
                        ),
                        trailing: !isFirebaseContract
                            ? TextButton(
                                onPressed: () =>
                                    _handleSendSms(contract!.phoneNumber),
                                child: const Text("INVITE"),
                              )
                            : null,
                      )
                    ],
                  );
                },
              );
            },
            error: (error, _) => ErrorScreen(errorMessage: error.toString()),
            loading: () => const LoadingScreen(),
          ),
    );
  }
}
