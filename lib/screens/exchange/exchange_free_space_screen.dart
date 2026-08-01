import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:provider/provider.dart';

class ExchangeFreeSpaceScreen extends StatefulWidget {
  const ExchangeFreeSpaceScreen({super.key});

  @override
  State<ExchangeFreeSpaceScreen> createState() =>
      _ExchangeFreeSpaceScreenState();
}

class _ExchangeFreeSpaceScreenState extends State<ExchangeFreeSpaceScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<ExchangeProvider>();
    _controller.text = provider.freeSpace;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPink,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Consumer<ExchangeProvider>(
        builder: (context, provider, child) {
          final canSubmit = provider.freeSpace.trim().isNotEmpty;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Free Space', style: AppTextStyles.titleLarge),
              const SizedBox(height: 24),
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  minLines: 8,
                  onChanged: provider.updateFreeSpace,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'あなたの気持ちやメッセージを書いてね',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: AppTextStyles.bodyText,
                ),
              ),
              const SizedBox(height: 20),
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
            ],
          );
        },
      ),
    );
  }
}
