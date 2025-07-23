import 'package:flutter/material.dart';
import 'package:userdashboard/features/users/domain/entity/user_entity.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;
  final GestureTapCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        horizontalTitleGap: 8,
        contentPadding: EdgeInsets.zero,
        enableFeedback: true,
        titleTextStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.inverseSurface,
          fontWeight: FontWeight.bold,
        ),
        subtitleTextStyle: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.inverseSurface.withValues(alpha: 0.5),
          fontWeight: FontWeight.w400,
        ),

        leading: CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(user.pictures.large, scale: 100),
        ),
        title: Text(user.name.toString()),
        subtitle: Text(user.email),
        onTap: onTap,
      ),
    );
  }
}
