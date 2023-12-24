import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../../../configurations.dart';
import '../../../repository/auth/auth.repository.dart';

enum _EditProfileStatus {
  writing,
  loading,
  error;
}

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late TextEditingController _nicknameTec;
  late List<Asset> _assets;
  late _EditProfileStatus _status;

  static const int _maxImages = 5;

  @override
  void initState() {
    super.initState();
    _nicknameTec = TextEditingController();
    _assets = <Asset>[];
    _status = _EditProfileStatus.writing;
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameTec.dispose();
  }

  _handleClearText() => _nicknameTec.clear();

  _handleClearImages() => setState(() {
        _assets.clear();
      });

  _handleSelectImages() async {
    final temp = await MultiImagePicker.pickImages(
      maxImages: _maxImages,
      selectedAssets: _assets,
      enableCamera: true,
      cupertinoOptions: const CupertinoOptions(takePhotoIcon: "Profile Image"),
      materialOptions: const MaterialOptions(
        actionBarTitle: "Karma",
        allViewTitle: "All",
        useDetailsView: false,
      ),
    );
    setState(() {
      _assets = temp;
    });
  }

  _handleUpdateProfile() async {
    // check user input
    if (_nicknameTec.text.trim().isEmpty) {
      return;
    }
    // set status as loading
    setState(() {
      _status = _EditProfileStatus.loading;
    });
    try {
      // update profile
      await getIt<AuthRepository>()
          .updateProfile(nickname: _nicknameTec.text.trim(), assets: _assets);
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (err) {
      _status = _EditProfileStatus.error;
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case _EditProfileStatus.loading:
        return const _OnLoading();
      case _EditProfileStatus.error:
        return const _OnError();
      case _EditProfileStatus.writing:
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // nickname
                  Text(
                    "Nickname",
                    style: GoogleFonts.lobsterTwo(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18),
                  ),
                  TextFormField(
                    controller: _nicknameTec,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: _handleClearText,
                            icon: const Icon(Icons.clear))),
                  ),
                  const SizedBox(height: 30),

                  // Profile Image
                  Row(
                    children: [
                      Text(
                        "Profile Image",
                        style: GoogleFonts.lobsterTwo(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18),
                      ),
                      const Spacer(),
                      if (_assets.isNotEmpty)
                        IconButton(
                            onPressed: _handleClearImages,
                            icon: const Icon(Icons.clear))
                    ],
                  ),
                  const SizedBox(height: 30),
                  _assets.isEmpty
                      ? ElevatedButton(
                          onPressed: _handleSelectImages,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined, size: 25),
                              SizedBox(width: 20),
                              Text("Select Photo")
                            ],
                          ))
                      : SizedBox(
                          height: MediaQuery.of(context).size.width * 0.8,
                          child: PageView(
                              pageSnapping: true,
                              children: _assets
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: AssetThumb(
                                          spinner: const Center(
                                              child: Text("Loadings...")),
                                          asset: e,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width
                                              .floor(),
                                          height: MediaQuery.of(context)
                                              .size
                                              .width
                                              .floor(),
                                        ),
                                      ))
                                  .toList()),
                        ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _handleUpdateProfile,
            isExtended: true,
            elevation: 0,
            icon: Icon(Icons.upload,
                color: Theme.of(context).colorScheme.primary, size: 28),
            tooltip: "Update Profile",
            label: Text(
              "Update Profile",
              style: GoogleFonts.lobster(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        );
    }
  }
}

class _OnLoading extends StatelessWidget {
  const _OnLoading({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Column(
          children: [Text("Updating..."), CircularProgressIndicator()],
        ),
      );
}

class _OnError extends StatelessWidget {
  const _OnError({super.key});

  @override
  Widget build(BuildContext context) => const Text("Error");
}
