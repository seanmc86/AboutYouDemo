class ImageConfig {
  static String mainTileImage(String url) {
    String formattedUrl = 'https://cdn.aboutstatic.com/file/' +
        url +
        '?width=400&amp;' +
        'height=400&amp;' +
        'quality=75&amp;' +
        'bg=ffffff00&amp;' +
        'brightness=0.96&amp;' +
        'trim=1';
    return formattedUrl;
  }
}
