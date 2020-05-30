class FavoritesModel {
  String _id;
  String _channelName;
 
  FavoritesModel(this._id, this._channelName);
 
  FavoritesModel.map(dynamic obj) {
    this._id = obj['id'];
    this._channelName = obj['channelname'];
  }
 
  String get id => _id;
  String get channelname => _channelName;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['channelname'] = _channelName;
 
    return map;
  }
 
  FavoritesModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._channelName = map['channelname'];
  }
}