class Wallpaper {
  final String image;
  final int height;

  Wallpaper({
    required this.image,required this.height,
  });

  factory Wallpaper.fromMap({required Map data}) {
    return Wallpaper(
      image: data["largeImageURL"], height: data['previewHeight'],
    );
  }
}
