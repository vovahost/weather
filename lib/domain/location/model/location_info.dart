class LocationInfo {
  LocationInfo({
    num? placeId,
    String? licence,
    String? osmType,
    num? osmId,
    String? lat,
    String? lon,
    String? locationClass,
    String? type,
    num? placeRank,
    num? importance,
    String? addresstype,
    String? name,
    String? displayName,
    List<String>? boundingbox,
  }) {
    _placeId = placeId;
    _licence = licence;
    _osmType = osmType;
    _osmId = osmId;
    _lat = lat;
    _lon = lon;
    _class = locationClass;
    _type = type;
    _placeRank = placeRank;
    _importance = importance;
    _addresstype = addresstype;
    _name = name;
    _displayName = displayName;
    _boundingbox = boundingbox;
  }

  LocationInfo.fromJson(dynamic json) {
    _placeId = json['place_id'];
    _licence = json['licence'];
    _osmType = json['osm_type'];
    _osmId = json['osm_id'];
    _lat = json['lat'];
    _lon = json['lon'];
    _class = json['class'];
    _type = json['type'];
    _placeRank = json['place_rank'];
    _importance = json['importance'];
    _addresstype = json['addresstype'];
    _name = json['name'];
    _displayName = json['display_name'];
    _boundingbox =
        json['boundingbox'] != null ? json['boundingbox'].cast<String>() : [];
  }

  num? _placeId;
  String? _licence;
  String? _osmType;
  num? _osmId;
  String? _lat;
  String? _lon;
  String? _class;
  String? _type;
  num? _placeRank;
  num? _importance;
  String? _addresstype;
  String? _name;
  String? _displayName;
  List<String>? _boundingbox;

  LocationInfo copyWith({
    num? placeId,
    String? licence,
    String? osmType,
    num? osmId,
    String? lat,
    String? lon,
    String? locationClass,
    String? type,
    num? placeRank,
    num? importance,
    String? addresstype,
    String? name,
    String? displayName,
    List<String>? boundingbox,
  }) =>
      LocationInfo(
        placeId: placeId ?? _placeId,
        licence: licence ?? _licence,
        osmType: osmType ?? _osmType,
        osmId: osmId ?? _osmId,
        lat: lat ?? _lat,
        lon: lon ?? _lon,
        locationClass: locationClass ?? _class,
        type: type ?? _type,
        placeRank: placeRank ?? _placeRank,
        importance: importance ?? _importance,
        addresstype: addresstype ?? _addresstype,
        name: name ?? _name,
        displayName: displayName ?? _displayName,
        boundingbox: boundingbox ?? _boundingbox,
      );

  num? get placeId => _placeId;

  String? get licence => _licence;

  String? get osmType => _osmType;

  num? get osmId => _osmId;

  String? get lat => _lat;

  String? get lon => _lon;

  String? get locationClass => _class;

  String? get type => _type;

  num? get placeRank => _placeRank;

  num? get importance => _importance;

  String? get addresstype => _addresstype;

  String? get name => _name;

  String? get displayName => _displayName;

  List<String>? get boundingbox => _boundingbox;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place_id'] = _placeId;
    map['licence'] = _licence;
    map['osm_type'] = _osmType;
    map['osm_id'] = _osmId;
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['class'] = _class;
    map['type'] = _type;
    map['place_rank'] = _placeRank;
    map['importance'] = _importance;
    map['addresstype'] = _addresstype;
    map['name'] = _name;
    map['display_name'] = _displayName;
    map['boundingbox'] = _boundingbox;
    return map;
  }
}
