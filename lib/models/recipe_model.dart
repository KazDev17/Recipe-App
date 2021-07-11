//THIS IS WHERE WE MAP OUR API KEY TO IT'S VALUES
class RecipeModel {
  String label;
  String image;
  String source;
  String url;
  String? postUrl;

  RecipeModel(
      {required this.label,
      required this.image,
      required this.source,
      required this.url,
      required this.postUrl});

  factory RecipeModel.fromMap(Map<String, dynamic> parsedJson) {
    return RecipeModel(
        url: parsedJson['url'],
        label: parsedJson['label'],
        image: parsedJson['image'],
        source: parsedJson['source'],
        postUrl: parsedJson['postUrl']);
  }
}
