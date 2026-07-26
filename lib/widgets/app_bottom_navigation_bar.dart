import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/models/app_tab.dart';

/// カスタム下部ナビゲーションバー
///
/// アイコンとラベルを縦に配置し、選択時はピンク系の色で表示します。
/// SafeAreaを考慮した高さで設計されています。
class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  /// 現在選択されているタブのインデックス
  final int currentIndex;

  /// タブが選択されたときのコールバック
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundPink,
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.black.withValues(alpha: 0.08),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: SizedBox(
            height: 56,
            child: Row(
              children: List.generate(
                AppTab.values.length,
                (index) => Expanded(
                  child: _buildTabItem(
                    context: context,
                    tab: AppTab.values[index],
                    isSelected: index == currentIndex,
                    onTap: () => onTap(index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 各タブアイテムをビルド
  Widget _buildTabItem({
    required BuildContext context,
    required AppTab tab,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.navSelectedBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconData(tab),
              color: isSelected
                  ? AppColors.navSelectedText
                  : AppColors.navUnselectedText,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              _getLabel(tab),
              style: isSelected
                  ? AppTextStyles.navSelectedLabel
                  : AppTextStyles.navUnselectedLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// タブに対応するアイコンを取得
  IconData _getIconData(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return Icons.home_outlined;
      case AppTab.exchange:
        return Icons.swap_horiz_outlined;
      case AppTab.profile:
        return Icons.badge_outlined;
    }
  }

  /// タブのラベルテキストを取得
  String _getLabel(AppTab tab) {
    return tab.label;
  }
}
