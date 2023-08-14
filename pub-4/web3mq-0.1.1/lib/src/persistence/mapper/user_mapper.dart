import 'package:web3mq/src/api/responses.dart';

import '../db/drift_chat_database.dart';

/// Useful mapping functions for [UserEntity]
extension UserEntityX on UserEntity {
  /// Maps a [UserEntity] into [User]
  UserModel toUser() => UserModel(
      userId: id,
      nickname: nickname,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt);
}

/// Useful mapping functions for [User]
extension UserX on UserModel {
  /// Maps a [User] into [UserEntity]
  UserEntity toEntity() => UserEntity(
      id: userId,
      nickname: nickname,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt);
}
