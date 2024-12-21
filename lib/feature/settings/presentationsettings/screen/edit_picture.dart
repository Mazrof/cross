import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';
import 'package:image_picker/image_picker.dart';

class EditPictureScreen extends StatelessWidget {
  const EditPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsCubit, UserSettingsState>(
      builder: (context, state) {
        return EditPicturePage(state: state);
      },
    );
  }
}

class EditPicturePage extends StatelessWidget {
  final UserSettingsState state;
  const EditPicturePage({required this.state, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: Text(AppStrings.editProfilePicture),
        leadingIcon: Icons.arrow_back,
        onLeadingTap: () {
          context.go(AppRouter.ksettings);
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.profilePicture.isNotEmpty)
              CircleAvatar(
                radius: 80,
                backgroundImage:
                    MemoryImage(_decodeBase64(state.profilePicture)),
              )
            else
              CircleAvatar(
                radius: 80,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(context),
              icon: Icon(Icons.edit),
              label: Text("Edit Picture"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final cubit = context.read<UserSettingsCubit>();

                cubit.saveSettings(newProfilePicture: "");
              },
              icon: Icon(Icons.delete),
              label: Text("Delete Picture"),
            ),
          ],
        ),
      ),
    );
  }

  Uint8List _decodeBase64(String base64String) {
    final base64Data = base64String.split(',').last;
    return base64Decode(base64Data);
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      final String base64Image = "data:image/png;base64,${base64Encode(bytes)}";

      context.read<UserSettingsCubit>().saveSettings(
            newProfilePicture: base64Image,
          );
    }
  }
}
