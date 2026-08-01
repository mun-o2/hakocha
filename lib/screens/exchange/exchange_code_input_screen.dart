import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    // TODO: Firebase接続後は交換コードでユーザーを検索する
    final isMatched = inputCode == dummyExchangeUser.exchangeCode;

    if (isMatched) {
      setState(() {
        _errorMessage = null;
      });

      provider.matchUser(dummyExchangeUser);

      // ExchangeStep.matched に変わるので、
      // exchange_screen.dart 側で matched画面へ切り替える
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 95),

              _buildTitle(),

              const SizedBox(height: 48),

              Center(child: _buildCodeArea()),

              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontFamily: 'Noto Sans JP',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 上部タイトル
  Widget _buildTitle() {
    return const Text(
      'スマホを近づけて\nタップしてシェア！',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 24,
        fontFamily: 'Noto Sans JP',
        fontWeight: FontWeight.w400,
        height: 2,
      ),
    );
  }

  /// 自分の交換コード + 相手のコード入力欄
  Widget _buildCodeArea() {
    return Container(
      width: 300,
      height: 174,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E9FD),
        border: Border.all(color: AppColors.purple5, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 自分の交換コード
          // 自分の交換コード
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              await Clipboard.setData(
                ClipboardData(text: dummyCurrentUser.exchangeCode),
              );

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('交換コードをコピーしました'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                dummyCurrentUser.exchangeCode,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.purple5,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          // 相手の交換コード入力欄
          SizedBox(
            width: 202,
            height: 37,
            child: TextField(
              controller: _codeController,
              autofocus: true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.done,

              // Enter / 完了でコード判定
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
                filled: true,
                fillColor: AppColors.backgroundWhite,

                contentPadding: EdgeInsets.zero,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(
                    color: AppColors.purple5,
                    width: 2,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(
                    color: AppColors.purple5,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
