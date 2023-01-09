class HomeItem {
  String title;
  bool isLink;
  bool isLocked;
  bool isPinned;
  bool isAnimated;
  bool isDublicated;

  HomeItem(
      {required this.title,
      this.isLink = false,
      this.isLocked = false,
      this.isAnimated = false,
      this.isDublicated = false,
      this.isPinned = false});

  void setItLink(bool isLink) {
    this.isLink = isLink;
  }

  void setItLocked(bool isLocked) {
    this.isLocked = isLocked;
  }

  void setItPinned(bool isPinned) {
    this.isPinned = isPinned;
  }

  void setItAnimated(bool isAnimated) {
    this.isAnimated = isAnimated;
  }

  void setItDublicated(bool isDublicated) {
    this.isDublicated = isDublicated;
  }
}
