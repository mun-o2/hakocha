import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/exchange.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:hakocha/screens/exchange/exchange_completed_screen.dart';
import 'package:hakocha/screens/exchange/exchange_free_space_screen.dart';
import 'package:hakocha/screens/exchange/exchange_matched_screen.dart';
import 'package:hakocha/screens/exchange/exchange_start_screen.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key, required this.onOpenProfile});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPink,
      child: Consumer<ExchangeProvider>(
        builder: (context, provider, child) {
          switch (provider.currentStep) {
            case ExchangeStep.idle:
              return const ExchangeStartScreen();
            case ExchangeStep.matched:
              return const ExchangeMatchedScreen();
            case ExchangeStep.writing:
              return const ExchangeFreeSpaceScreen();
            case ExchangeStep.completed:
              return ExchangeCompletedScreen(onOpenProfile: onOpenProfile);
          }
        },
      ),
    );
  }
}
