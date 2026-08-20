import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';

class AccountRegisterButtons extends StatelessWidget {
  final VoidCallback onApplePressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onLoginPressed;
  final bool canRegister;
  final bool canUseApple;
  final bool isLoading;

  const AccountRegisterButtons({
    super.key,
    required this.onApplePressed,
    required this.onGooglePressed,
    required this.onLoginPressed,
    this.canRegister = true,
    this.canUseApple = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AuthButton(
          icon: Icons.apple,
          text: 'Appleで続ける',
          onPressed: canRegister && canUseApple ? onApplePressed : null,
        ),

        const SizedBox(height: 14),

        _AuthButton(
          icon: Icons.g_mobiledata,
          text: 'Googleで続ける',
          onPressed: canRegister ? onGooglePressed : null,
          isLoading: isLoading,
        ),

        const SizedBox(height: 24),

        TextButton(
          onPressed: canRegister ? onLoginPressed : null,
          child: const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'ご利用中の方は',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'こちら',
                  style: TextStyle(color: Color(0xFF8E72F4)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AuthButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _AuthButton({
    required this.icon,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 285,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.purple4,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 24),
                  const SizedBox(width: 16),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
