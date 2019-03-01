class News {
  var img;
  var title;
  var date;
  var description;
  var category;
  var link;
  var origin;

  News(
      {this.img,
      this.title,
      this.date,
      this.description,
      this.category,
      this.link,
      this.origin});

  factory News.fromJson(Map<String, dynamic> map) {
    return new News(
      img: map['url_img'],
      title: map['tittle'],
      date: map['date'],
      description: map['description'],
      category: map['category'],
      link: map['link'],
      origin: map['origin'],
    );
  }
}
