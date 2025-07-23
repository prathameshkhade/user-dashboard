import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';

class UserProfile extends StatelessWidget {
  final UserEntity user;

  const UserProfile({super.key, required this.user});

  Container _container({
    required String heading,
    required List<Map<String, String>> content,
    required ThemeData theme
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Heading
          Text(
            heading,
            style: theme.textTheme.headlineMedium
          ),
          const Divider(height: 30),

          // Main Content
          ...content.expand(
              (map) => map.entries.map(
                  (e) => Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Align(
                            heightFactor: 2,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(
                                e.key,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.start,
                              )],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            heightFactor: 2,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(e.value, textAlign: TextAlign.start,)],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Users Details'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: <Widget>[
            // Image with name and gender
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Circular Image
                  Hero(
                    tag: 'pic',
                    child: CircleAvatar(
                      radius: 90.0,
                      backgroundImage: NetworkImage(user.pictures.large),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name
                  Text(
                    '${user.name.title}. ${user.name.toString()}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    user.gender,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Contact Information
            _container(
              heading: 'Contact Information',
              content: [{
                'Email': user.email,
                'Phone': user.phone,
                'Cell': user.cell
              }],
              theme: theme
            ),

            // Location Information
            _container(
                heading: 'Location',
                content: [{
                  'Address': user.location.toString(),
                  'City': user.location.city,
                  'State': user.location.state,
                  'Country': user.location.country,
                  'Postcode': user.location.postcode,
                  'Coordinates': '${user.location.coordinates.latitude}, ${user.location.coordinates.longitude}',
                }],
                theme: theme
            ),

            // Location Information
            _container(
                heading: 'Personal Details',
                content: [{
                  'Date of Birth': DateFormat('MMMM dd, yyyy').format(user.dob.date),
                  'Age': user.dob.age.toString(),
                  'Nationality': user.nat,
                  'Registration Date': DateFormat('MMMM dd, yyyy').format(user.registered.date),
                }],
                theme: theme
            ),

          ],
        ),
      ),
    );
  }
}
