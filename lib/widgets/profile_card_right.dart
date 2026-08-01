import 'package:flutter/material.dart';
import 'profile_card_parts.dart';
import '../dummy/dummy_profile.dart';
import '../constants/profile_theme.dart';

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
        width: 400,
        height: 740,
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
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: ProfileWhichOne(
                  editable: widget.editable,
                  theme: widget.theme,
                  profile: profileData,
                ),
              ),

              // Free Spaceコーナー
              Positioned(
                top: 510,
                left: 30,
                right: 0,
                child: ProfileFreeSpace(
                  profile: profileData,
                  editable: widget.editable,
                  theme: widget.theme,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
