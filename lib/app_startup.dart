import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneako/src/core/constants/env.dart';
import 'package:sneako/src/features/auth/provider/user_data_notifer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final aappstartupProvider = FutureProvider<Supabase>((ref) async {
  final res = await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.anonKey,
  );

  return res;
});

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(aappstartupProvider).when(
          data: (data) {
            final User? session = Supabase.instance.client.auth.currentUser;
            return session != null
                ? ref.watch(userDataNotifierProvider).when(
                      data: (data) => onLoaded(context),
                      loading: () => const AppStartupLoadingWidget(),
                      error: (e, stk) {
                        print(stk);
                        return AppStartupErrorWidget(
                          message: stk.toString(),
                          onRetry: () =>
                              ref.invalidate(userDataNotifierProvider),
                        );
                      },
                    )
                : onLoaded(context);
          },
          loading: () => const AppStartupLoadingWidget(),
          error: (e, stk) {
            print(stk);
            return AppStartupErrorWidget(
              message: stk.toString(),
              onRetry: () => ref.invalidate(userDataNotifierProvider),
            );
          },
        );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
