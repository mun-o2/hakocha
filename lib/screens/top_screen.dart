import 'package:flutter/material.dart';
import 'package:hakocha/screens/settings_screen.dart'; // ※エラーが出る場合は適宜修正してください

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.grey, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 画面全体を左寄せ
          children: [
            const SizedBox(height: 16),
            
            // --- 1. プロフィールカード ---
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFFF6699), width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFFE0E0E0),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'あかり',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF6666FF),
                          side: const BorderSide(color: Color(0xFF6666FF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(120, 32),
                        ),
                        child: const Text('プロフィール編集'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // --- 2. 交換人数＆ページ数カード ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFFF6699), width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('交換した人数', '30', '人'),
                  Container(width: 1, height: 50, color: Colors.grey.shade300),
                  _buildStatItem('プロフィール帳', '32', 'ページ'),
                ],
              ),
            ),

            const SizedBox(height: 32), // 少し広めの隙間

            // --- 3. お知らせセクション ---
            const Text(
              'お知らせ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // お知らせカード
            Container(
              width: double.infinity, // 横幅を親要素（画面）いっぱいにする
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0), // 縦に大きめの余白を取る
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFFF6699), width: 2), // ピンクの枠線
                borderRadius: BorderRadius.circular(8), // Figmaに合わせて角丸を少し控えめに
              ),
              child: const Text(
                'あやめさんからプロフ帳が\n返ってきました',
                textAlign: TextAlign.center, // 文字を中央揃えにする
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5, // 2行の文字の間隔を少し開ける
                ),
              ),
            ),
            // --- お知らせセクションここまで ---
            
          ],
        ),
      ),
    );
  }

  // 数字の部分を作るための専用部品
  Widget _buildStatItem(String title, String number, String unit) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              number,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.0),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(width: 60, height: 2, color: const Color(0xFFFF6699)),
      ],
    );
  }
}