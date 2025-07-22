class UserEntity {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final Dob dob;
  final Registered registered;
  final String phone;
  final String cell;
  final Pictures pictures;
  final String nat;

  UserEntity(
    this.gender,
    this.name,
    this.location,
    this.email,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.pictures,
    this.nat,
  );
}

/// Represents a full name of user
class Name {
  final String title;
  final String first;
  final String last;

  Name(this.title, this.first, this.last);

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(json['title'] ?? '', json['first'] ?? '', json['last'] ?? '');
  }

  @override
  String toString() {
    return '$title $first $last';
  }
}

/// Represents Location of user
class Location {
  final String street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final Coordinates coordinates;
  final Timezone timezone;

  Location(
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  );

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      json['street']?['number']?.toString() ?? '',
      json['city'] ?? '',
      json['state'] ?? '',
      json['country'] ?? '',
      json['postcode']?.toString() ?? '',
      Coordinates.fromJson(json['coordinates'] ?? {}),
      Timezone.fromJson(json['timezone'] ?? {}),
    );
  }
}

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates(this.latitude, this.longitude);

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
      double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0,
    );
  }
}

class Timezone {
  final String offset;
  final String description;

  Timezone(this.offset, this.description);

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      json['offset'] ?? '',
      json['description'] ?? '',
    );
  }
}

class Dob {
  final DateTime date;
  final int age;

  Dob(this.date, this.age);

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(
      DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      json['age']?.toInt() ?? 0,
    );
  }
}

class Registered {
  final DateTime date;
  final int age;

  Registered(this.date, this.age);

  factory Registered.fromJson(Map<String, dynamic> json) {
    return Registered(
      DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      json['age']?.toInt() ?? 0,
    );
  }
}

class Pictures {
  final String large;
  final String medium;
  final String thumbnail;

  Pictures(this.large, this.medium, this.thumbnail);

  factory Pictures.fromJson(Map<String, dynamic> json) {
    return Pictures(
      json['large'] ?? '',
      json['medium'] ?? '',
      json['thumbnail'] ?? '',
    );
  }
}
