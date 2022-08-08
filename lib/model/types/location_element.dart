class LocationElement {
  int inDirectory;
  int index;
  int? selectedMessageIndex;
  LocationElement(
      {required this.inDirectory,
      required this.index,
      this.selectedMessageIndex});

  LocationElement.fromJson(Map<String, dynamic> json)
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
