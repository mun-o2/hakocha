import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/dummy/dummy_profile.dart';
import 'package:hakocha/models/user_profile.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:hakocha/widgets/outlined_text.dart';
import 'package:provider/provider.dart';

class ExchangeFreeSpaceScreen extends StatefulWidget {
  const ExchangeFreeSpaceScreen({super.key});

  @override
  State<ExchangeFreeSpaceScreen> createState() =>
      _ExchangeFreeSpaceScreenState();
}

class _ExchangeFreeSpaceScreenState extends State<ExchangeFreeSpaceScreen> {
  late final TextEditingController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final provider = context.read<ExchangeProvider>();

      // プロフィール帳のFree Spaceを初期値として使用
      final initialText = dummyProfile.freeSpace;

      _controller.text = initialText;

      // ExchangeProvider側にも初期値を入れておく
      provider.updateFreeSpace(initialText);

      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );

      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExchangeProvider>(
      builder: (context, provider, child) {
        final matchedUser = provider.matchedUser;
        final textLength = provider.freeSpace.length;
        final isEmpty = provider.freeSpace.trim().isEmpty;
        final isOverLimit = textLength > 50; // 50文字制限判定
        final canSubmit = !isEmpty && !isOverLimit;

        return Container(
          color: matchedUser != null
              ? _getBackgroundColor(matchedUser.themeColor)
              : AppColors.backgroundPink,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Figmaに合わせて少し下げる
                  const SizedBox(height: 70),

                  // Free Space見出し ＋ 白い入力欄
                  SizedBox(
                    height: 260,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // 白いFree Space入力欄
                        Positioned(
                          top: 30,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
                            decoration: const BoxDecoration(
                              color: AppColors.backgroundWhite,
                            ),
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,

                              // プロフィール帳の入力文字と同じ
                              style: AppTextStyles.profileText,

                              onChanged: provider.updateFreeSpace,

                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                            ),
                          ),
                        ),

                        // Free Space見出し
                        Positioned(
                          top: 0,
                          left: 8,
                          child: OutlinedText(
                            text: 'Free Space',
                            style: AppTextStyles.profileTitle,
                            mainColor: AppColors.white,
                            outlineColor: AppColors.pink4,
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // エラーメッセージ
                      Expanded(
                        child: Text(
                          isEmpty
                              ? 'メッセージを書いてください'
                              : isOverLimit
                              ? '50文字以内で入力してください'
                              : '',
                          style: TextStyle(
                            fontSize: 12,
                            color: isEmpty || isOverLimit
                                ? AppColors.pink4
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),

                      // 文字数
                      Text(
                        '$textLength / 50',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isOverLimit
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isOverLimit
                              ? AppColors.pink4
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // 既存の完了ボタンはそのまま
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pink4,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: canSubmit ? provider.completeExchange : null,
                    child: const Text('書き終わった！'),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 相手が選択しているカラーを背景色として使用
  Color _getBackgroundColor(ProfileThemeColor themeColor) {
    switch (themeColor) {
      case ProfileThemeColor.pink:
        return AppColors.pink5;
      case ProfileThemeColor.blue:
        return AppColors.blue5;
    }
  }
}
