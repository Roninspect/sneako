import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataNotifierProvider).valueOrNull;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user != null
                      ? CachedNetworkImageProvider(user.profile!)
                      : null,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 15,
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Text(
              user != null ? user.username : "00000000000",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              user != null ? user.phone : "00000000000",
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(thickness: 1),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Ionicons.person_outline),
              title: const Text(
                "Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Ionicons.md_location_outline),
              title: const Text(
                "Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Ionicons.ios_notifications_outline),
              title: const Text(
                "Notification",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(AntDesign.eyeo),
              title: const Text(
                "Dark Mode",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.lock_outline_rounded),
              title: const Text(
                "Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Ionicons.information_circle_outline,
                size: 27,
              ),
              title: const Text(
                "Help Center",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Octicons.person_add),
              title: const Text(
                "invite Friends",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)),
            ),
            ListTile(
              onTap: () async {
                await Supabase.instance.client.auth.signOut();
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
