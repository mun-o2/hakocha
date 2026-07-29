import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:hakocha/data/dummy_exchange_data.dart';
import 'package:provider/provider.dart';

class ExchangeCodeInputScreen extends StatefulWidget {
  const ExchangeCodeInputScreen({super.key});

  @override
  State<ExchangeCodeInputScreen> createState() =>
      _ExchangeCodeInputScreenState();
}

class _ExchangeCodeInputScreenState extends State<ExchangeCodeInputScreen> {
  final TextEditingController _codeController = TextEditingController();

  String? _errorMessage;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submitCode() {
    final inputCode = _codeController.text.trim();

    if (inputCode.isEmpty) {
      setState(() {
        _errorMessage = '交換コードを入力してください';
      });
      return;
    }

    final provider = context.read<ExchangeProvider>();

    // TODO:
    // 今はダミーデータで判定
    // 後でFirebase上のexchangeCode検索に差し替える
    final isMatched = inputCode == dummyExchangeUser.exchangeCode;

    if (isMatched) {
      setState(() {
        _errorMessage = null;
      });

      // 一致したユーザーをExchangeProviderに登録
      provider.matchUser(dummyExchangeUser);

      // exchange_screen.dart 側が currentStep を見て
      // ExchangeMatchedScreen に切り替える想定
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = '交換コードが見つかりませんでした';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),

              _buildTitle(),

              const SizedBox(height: 48),

              _buildMyCodeCard(),

              const SizedBox(height: 32),

              _buildCodeInput(),

              const SizedBox(height: 16),

              _buildSubmitButton(),

              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '交換コードを入力',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 24,
        fontFamily: 'Noto Sans JP',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildMyCodeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E9FD),
        border: Border.all(color: AppColors.purple5, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'あなたの交換コード',
            style: TextStyle(
              color: AppColors.purple5,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            dummyCurrentUser.exchangeCode,
            style: const TextStyle(
              color: AppColors.purple5,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInput() {
    return TextField(
      controller: _codeController,
      textAlign: TextAlign.center,

      // iPhone側のEnter/完了でも送信
      textInputAction: TextInputAction.done,

      onSubmitted: (_) {
        _submitCode();
      },

      onChanged: (_) {
        if (_errorMessage != null) {
          setState(() {
            _errorMessage = null;
          });
        }
      },

      decoration: InputDecoration(
        hintText: '交換コードを入力',
        filled: true,
        fillColor: AppColors.backgroundWhite,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: AppColors.purple5, width: 2),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: AppColors.purple5, width: 2.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitCode,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple5,
          foregroundColor: AppColors.backgroundWhite,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: const Text(
          '交換相手を探す',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
