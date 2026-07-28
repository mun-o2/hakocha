import 'package:flutter/material.dart';
import 'profile_card_parts.dart';

class ProfileCardRight extends StatelessWidget {
  const ProfileCardRight({super.key});

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
              const ProfileIfCorner(),

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
                child: const ProfileFreeSpace(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
