import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart'; //Moulフォント導入のため

/// アプリケーション全体で使用するテキストスタイル定数を管理
class AppTextStyles {
  AppTextStyles._();

  // フォントファミリ共通定数
  static const String _fontFamilyDefault = 'Noto Sans JP';
  static const String _fontFamilyRounded = 'Rounded Mplus 1c';

  // ナビゲーションバー
  /// ナビゲーションバー選択時のテキストスタイル
  static const TextStyle navSelectedLabel = TextStyle(
    color: AppColors.navSelectedText, // Color(0xFFEC6AA7)
    fontSize: 11,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w700,
  );

  /// ナビゲーションバー未選択時のテキストスタイル
  static const TextStyle navUnselectedLabel = TextStyle(
    color: AppColors.navUnselectedText, // Color(0xFF848598)
    fontSize: 11,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w700,
  );

  // 見出し・タイトル
  /// 画面の小見出し（15px）
  static const TextStyle bodyMedium = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 15,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
  );

  /// 画面タイトル（24px）
  static const TextStyle titleLarge = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 24,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
  );

  /// サブタイトル（16px）
  static const TextStyle subtitle = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 16,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
  );

  /// 大きな数字（36px）
  static const TextStyle numberLarge = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 36,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
  );

  /// 数字のユニット（21px）
  static const TextStyle numberUnit = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 21,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
  );

  /// セクションタイトル（24px、中央配置用）
  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 24,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
    height: 2,
  );

  /// 本文テキスト（16px）
  static const TextStyle bodyText = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 16,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
    height: 2,
  );

  /// アクションテキスト（パープル、16px）
  static const TextStyle actionText = TextStyle(
    color: Color(0xFF9B7CF5), // パープル4
    fontSize: 16,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w400,
    height: 3,
  );

  // ユーザー名・プロフィール
  /// ユーザー名（24px、Rounded Mplus 1c）
  static const TextStyle userName = TextStyle(
    color: AppColors.textPrimary, // Color(0xFF4D4643)
    fontSize: 24,
    fontFamily: _fontFamilyRounded,
    fontWeight: FontWeight.w400,
  );

  // プロフィール帳の見出しフォント
  static TextStyle get profileTitle =>
      GoogleFonts.moul(fontSize: 35, color: AppColors.white);

  //テキストスタイル系リファクタリング完了しました
  //プロフィール帳のカードに特化して作っているので、他のパーツでは使わないことを推奨します
  static final TextStyle profileFormatLarge = GoogleFonts.zenMaruGothic(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle profileFormatSmall = GoogleFonts.zenMaruGothic(
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle profileSNSLabel = GoogleFonts.zenMaruGothic(
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle profileText = GoogleFonts.zenKurenaido(fontSize: 16);

  //画像選択ボトムシートのテキスト
  static const TextStyle imagePickerText = TextStyle(
    fontSize: 13,
    color: AppColors.navUnselectedText,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w700,
  );

  //画像選択ボトムシートのタイトルテキスト
  static const TextStyle imagePickerTextTitle = TextStyle(
    fontSize: 24,
    color: AppColors.navUnselectedText,
    fontFamily: _fontFamilyDefault,
    fontWeight: FontWeight.w700,
  );
}
