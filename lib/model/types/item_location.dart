class ItemLocation {
  int inDirectory;
  int index;
  int? selectedMessageIndex;
  ItemLocation(
      {required this.inDirectory,
      required this.index,
      this.selectedMessageIndex});

  ItemLocation.fromJson(Map<String, dynamic> json)
      : inDirectory = json['inDirectory'],
        index = json['index'],
        selectedMessageIndex = json['selectedMessageIndex'];

  Map<String, dynamic> toJson() {
    return {
      'inDirectory': inDirectory,
      'index': index,
      'selectedMessageIndex': selectedMessageIndex
    };
  }
}
