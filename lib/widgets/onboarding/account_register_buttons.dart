import 'package:flutter/material.dart';

class AccountRegisterButtons extends StatelessWidget {
  final VoidCallback onApplePressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onLoginPressed;

  const AccountRegisterButtons({
    super.key,
    required this.onApplePressed,
    required this.onGooglePressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AuthButton(
          icon: Icons.apple,
          text: 'Appleで続ける',
          onPressed: onApplePressed,
        ),

        const SizedBox(height: 14),

        _AuthButton(
          icon: Icons.g_mobiledata,
          text: 'Googleで続ける',
          onPressed: onGooglePressed,
        ),

        const SizedBox(height: 24),

        TextButton(
          onPressed: onLoginPressed,
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
  final VoidCallback onPressed;

  const _AuthButton({
    required this.icon,
    required this.text,
    required this.onPressed,
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
          backgroundColor: const Color(0xFF9173F4),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
