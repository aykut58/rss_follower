import 'dart:async';
import 'dart:developer' as dev;

extension Log on Object {
  String get _className => runtimeType.toString();

  void _log(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    String? name,
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    dev.log(
      message,
      name: name ?? _className,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// log('[ANSI color code][message][ANSI reset code]');
  /// \x1B: Hexadecimal

  /// [Magenta] [Bilgilendirme]
  void logInfo(String message) => _log(
        '\x1B[35m$message\x1B[0m',
      );

  /// [Yeşil] [Başarılı]
  void logSuccess(String message) => _log('\x1B[32m$message\x1B[0m');

  /// [Sarı] [Uyarı]
  void logWarning(String message, {StackTrace? stackTrace}) => _log(
        '\x1B[33m$message\x1B[0m',
        stackTrace: stackTrace,
      );

  /// [Kırmızı] [Hata]
  void logError(String message, {StackTrace? stackTrace}) => _log(
        '\x1B[31m$message\x1B[0m',
        stackTrace: stackTrace,
      );
}
