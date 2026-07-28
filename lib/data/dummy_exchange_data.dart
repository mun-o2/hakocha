import 'package:hakocha/models/exchange.dart';
import 'package:hakocha/models/user_profile.dart';

const dummyCurrentUser = UserProfile(id: 'user_001', name: 'みう', iconUrl: '');

const dummyExchangeUser = UserProfile(id: 'user_002', name: 'あかり', iconUrl: '');

final dummyExchanges = [
  Exchange(
    id: 'exchange_001',
    senderId: 'user_001',
    receiverId: 'user_002',
    freeSpace: 'また遊ぼうね！',
    exchangedAt: DateTime(2026, 4, 10),
  ),
  Exchange(
    id: 'exchange_002',
    senderId: 'user_002',
    receiverId: 'user_001',
    freeSpace: 'ライブ楽しかった！',
    exchangedAt: DateTime(2026, 5, 20),
  ),
  Exchange(
    id: 'exchange_003',
    senderId: 'user_001',
    receinghverId: 'user_002',
    freeSpace: '夏も遊ぼ〜！',
    exchangedAt: DateTime(2026, 6, 15),
  ),
];
