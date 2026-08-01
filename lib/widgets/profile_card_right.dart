import 'package:flutter/material.dart';
import 'profile_card_parts.dart';
import '../dummy/dummy_profile.dart';

class ProfileCardRight extends StatelessWidget {
  final bool editable;

  const ProfileCardRight({super.key, this.editable = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 740,
        child: ProfileCardBody(
          isLeft: false,
          child: Stack(
            children: [
              // もしもコーナー
              ProfileIfCorner(
                ifMagicWish: dummyProfile.ifMagicWish,
                ifNextLife: dummyProfile.ifNextLife,
              ),

              // WhichOne?コーナー
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                child: const ProfileWhichOne(),
              ),

              // Free Spaceコーナー
              Positioned(
                top: 510,
                left: 30,
                right: 0,
                child: ProfileFreeSpace(freeSpace: dummyProfile.freeSpace),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
