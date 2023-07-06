bool checkList(List<bool> list) {
  for (var value in list) {
    if (value) {
      return false;
    }
  }
  return true;
}
