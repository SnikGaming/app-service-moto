import 'dart:math';

String randomName({int length = 6}) {
  const chars = 'abcdefghijklmnopqrstuvwxyz';
  final rand = Random();
  return String.fromCharCodes(
    Iterable.generate(
        length, (_) => chars.codeUnitAt(rand.nextInt(chars.length))),
  );
}
