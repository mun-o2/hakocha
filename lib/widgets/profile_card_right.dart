import 'package:flutter/material.dart';
import 'profile/common/profile_card_base.dart';
import '../dummy/dummy_profile.dart';
import '../constants/profile_theme.dart';
import '../widgets/profile/sections/profile_if_corner.dart';
import '../widgets/profile/sections/profile_free_space.dart';
import '../widgets/profile/sections/profile_which_one.dart';

import '../dummy/dummy_profile2.dart';
import '../models/profile_data.dart';

class ProfileCardRight extends StatefulWidget {
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileCardRight({
    super.key,
    this.editable = true,
    required this.theme,
  });

  @override
  State<ProfileCardRight> createState() => _ProfileCardRightState();
}

class _ProfileCardRightState extends State<ProfileCardRight> {
  late ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    profileData = widget.theme == pinkProfileCardTheme
        ? dummyProfile
        : dummyProfile2;
    return Center(
      child: SizedBox(
        width: 360,
        height: 666,
        child: ProfileCardBody(
          isLeft: false,
          theme: widget.theme,
          child: Stack(
            children: [
              // もしもコーナー
              ProfileIfCorner(
                profile: profileData,
                editable: widget.editable,
                theme: widget.theme,
              ),

              // WhichOne?コーナー
              ProfileWhichOne(
                editable: widget.editable,
                theme: widget.theme,
                profile: profileData,
              ),

              // Free Spaceコーナー
              ProfileFreeSpace(
                profile: profileData,
                editable: widget.editable,
                theme: widget.theme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
