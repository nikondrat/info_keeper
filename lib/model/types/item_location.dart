class ItemLocation {
  int inDirectory;
  int index;
  int? itemIndex;
  ItemLocation(
      {required this.inDirectory, required this.index, this.itemIndex});

  ItemLocation.fromJson(Map<String, dynamic> json)
      : inDirectory = json['inDirectory'],
        index = json['index'],
        itemIndex = json['itemIndex'];

  Map<String, dynamic> toJson() {
    return {'inDirectory': inDirectory, 'index': index, 'itemIndex': itemIndex};
  }
}
