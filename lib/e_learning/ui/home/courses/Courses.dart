class CoursesClass{
  String _title="";
  String _id="";
  String _description="";
  String _rating="0";
  String _price="0";
  String _category="";
  String _lessons="";
  String _prof="";

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get lessons => _lessons;

  set lessons(String value) {
    _lessons = value;
  }

  String _url="https://i.pinimg.com/originals/e5/6b/cf/e56bcf0c4ed8a71151e0d4d6108fed92.jpg";

  CoursesClass.fromMap(Map<dynamic ,dynamic> data){
    _id=data["id"];
    _title=data["title"];
    _description=data["description"];
    _rating=data["rating"];
    _price=data["price"];
    _url=data["imgURL"];
    _category=data["category"];
    _lessons=data["lessons"];
    _prof=data["prof"];
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }


  String get rating => _rating;

  set rating(String value) {
    _rating = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get prof => _prof;

  set prof(String value) {
    _prof = value;
  }
}