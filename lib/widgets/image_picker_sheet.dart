import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

void showImagePickerSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: false,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.navBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("画像を選択", style: AppTextStyles.imagePickerTextTitle),

            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _PickerButton(
                  icon: Icons.photo_library_outlined,
                  text: "ギャラリーから選択",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                _PickerButton(
                  icon: Icons.photo_camera_outlined,
                  text: "カメラで撮影",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("キャンセル", style: AppTextStyles.imagePickerText),
            ),
          ],
        ),
      );
    },
  );
}

class _PickerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _PickerButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 180,
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.imapePickerBottomSheetSub,
          border: Border.all(color: AppColors.imapePickerBottomSheet),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.white,
              child: Icon(icon, color: AppColors.imapePickerBottomSheet),
            ),
            const SizedBox(height: 14),
            Text(text, style: AppTextStyles.imagePickerText),
          ],
        ),
      ),
    );
  }
}
