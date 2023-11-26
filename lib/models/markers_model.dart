class MarkerModel{
  int? id;
  String? latitude;
  String? longitude;
  String? title;

  MarkerModel({this.id, this.latitude, this.longitude, this.title});
  factory MarkerModel.fromMap(Map<String,dynamic> map){
    return MarkerModel(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      title: map['title']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'title': title,
    };
  }
}