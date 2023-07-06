// ignore_for_file: file_names

String hideExcessCharacters(String input) {
  const int maxCharacters = 40;
  if (input.length > maxCharacters) {
    return '${input.substring(0, maxCharacters)}...';
  }
  return input;
}
