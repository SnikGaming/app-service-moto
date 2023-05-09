import 'dart:math';

String randomName({int length = 6}) {
  const _chars = 'abcdefghijklmnopqrstuvwxyz';
  final rand = Random();
  return String.fromCharCodes(
    Iterable.generate(
        length, (_) => _chars.codeUnitAt(rand.nextInt(_chars.length))),
  );
}
