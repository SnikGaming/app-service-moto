class Commune {
  final String name;

  Commune({required this.name});
}

class District {
  final String name;
  final List<Commune> communes;

  District({required this.name, required this.communes});
}

class Province {
  final String name;
  final List<District> districts;

  Province({required this.name, required this.districts});
}

