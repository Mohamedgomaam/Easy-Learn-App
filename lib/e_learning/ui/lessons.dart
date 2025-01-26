class Lesson{
  String _name="";
  String _videoLink="";
  String _courseId="";
  String _id="";


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Lesson.fromMap(Map<dynamic ,dynamic> data){
    _name=data["name"];
    _videoLink=data["videoLink"];
    _courseId=data["courseId"];
    _id=data["id"];
  }

  String get videoLink => _videoLink;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get courseId => _courseId;

  set courseId(String value) {
    _courseId = value;
  }

  set videoLink(String value) {
    _videoLink = value;
  }
}