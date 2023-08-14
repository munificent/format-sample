// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:path/path.dart' as p;

class PathUtil {
  PathUtil._();

  /// 工具库 - 路径相关

  /// 获取当前终端执行路径
  static Directory get cwd {
    return Directory.current;
  }

  /// 获取路径分隔符
  static String get separator {
    return p.separator;
  }

  /// 获取绝对路径
  ///
  /// [part1] 可选子路径
  static String joinCwd(
    String part1, [
    String? part2,
    String? part3,
    String? part4,
  ]) {
    return p.normalize(p.join(cwd.path, part1, part2, part3, part4));
  }

  /// 获取路径
  ///
  /// [part1] 子路径
  static String join(
    String part1, [
    String? part2,
    String? part3,
    String? part4,
  ]) {
    return p.normalize(p.join(part1, part2, part3, part4));
  }

  /// 获取用户目录
  ///
  /// [envName] 其他环境变量名称
  static String getUserDir({String? envName}) {
    /// 读取环境变量，获取用户目录
    if (Platform.isWindows) {
      String? p;
      if (envName != null) {
        p = Platform.environment[envName];
      }
      p ??= Platform.environment['USERPROFILE'];
      if (p is! String) {
        throw Exception('无法获取用户目录');
      }
      return p;
    }
    throw Exception('其他平台暂未支持');
  }

  /// 获取目录名称
  static String dirname(String path) {
    return p.dirname(path);
  }

  /// 获取文件名称
  static String basename(String path) {
    return p.basename(path);
  }

  /// 获取文件扩展名
  static String extension(String path) {
    return p.extension(path);
  }

  /// 获取相对地址
  static String relative(String path, {String? from}) {
    return p.relative(path, from: from);
  }
}
