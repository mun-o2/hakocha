import 'package:flutter/material.dart';

/// アプリケーション全体で使用するカラー定数を管理
class AppColors {
  AppColors._();

  // Primary Colors
  /// 主要な文字色（ダークグレー）
  static const Color textPrimary = Color(0xFF4D4643);

  /// 背景2
  static const Color backgroundWhite = Color(0xFFFDF8FB);

  /// ピンク5（非常に薄いピンク系）
  static const Color backgroundPink = Color(0xFFFCF9FF);

  // Accent Colors - Pink
  /// ピンク4（選択時のメイン色）
  static const Color pink4 = Color(0xFFEC6AA7);

  /// ピンク5（選択時の背景）
  static const Color pink5 = Color(0xFFFEF8FA);

  // Accent Colors - Purple & Blue
  /// パープル4（アクセント色）
  static const Color purple4 = Color(0xFF9B7CF5);
  static const Color purple5 = Color(0xFFF3E9FD);

  /// ブルー4（アクセント色）
  static const Color blue4 = Color(0xFF2563EB);

  /// ブルー5（ブルー背景）
  static const Color blue5 = Color(0xFFEAF8FF);

  // Neutral Colors
  /// グレー系（未選択時のテキスト）
  static const Color textSecondary = Color(0xFF848598);

  /// グレー系（背景の枠線など）
  static const Color textTertiary = Color(0xFFCCCCCC);

  // Navigation Bar specific
  /// ボトムナビゲーションの背景
  static const Color navBackground = Color(0xFFFDF7FB);

  /// ボトムナビゲーションの選択時アイコン背景
  static const Color navSelectedBackground = Color(0xFFFEEDF8);

  /// ボトムナビゲーションの選択時テキスト
  static const Color navSelectedText = Color(0xFFEC6AA7);

  /// ボトムナビゲーションの未選択時テキスト
  static const Color navUnselectedText = Color(0xFF848598);

  // Splash Screen
  /// スプラッシュスクリーンの背景
  static const Color splashBackground = Color(0xFFFDF7FB);

  //プロフィール帳のカードベース色
  static const Color profileCardBackground = Color(0xFFFFE7F1);

  //ホワイト
  static const Color white = Color(0xFFFFFFFF);

  //画像選択のボトムシートメインカラー
  static const Color imapePickerBottomSheet = Color(0xFFFFBCE9);

  //画像選択時のボトムシートサブカラー
  static const Color imapePickerBottomSheetSub = Color(0xFFFEEFF8);

  //手書き風丸の線画色
  static const Color circleOutlined = Color(0xFF7B7B7B);

  /// ブルー4（アクセント色）
  static const Color blue3 = Color(0xFF6BCBFF);

  /// ブルー5（ブルー背景）
  static const Color profileCardBackgroundBlue = Color(0xFFEAF8FF);
}
