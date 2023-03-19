
class RssModel 
{
  int? id;
  String? title;
  String? url;


  RssModel({
    this.id,
    this.title,
    this.url,

  });

  factory RssModel.fromMap(Map<String, dynamic> json) => RssModel
  (
    id: json["id"] as int,
    title: json["title"] as String,
    url: json["url"] as String,

  );
  Map<String, dynamic > toMap() => 
  {
    "id" : id,
    "title" :title,
    "url" : url,

  };

  @override
  String toString() {
    return '{id: $id, title: $title, url: $url,}';
  }
}