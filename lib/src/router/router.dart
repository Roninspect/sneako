import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sneako/src/features/auth/pages/login_page.dart';
import 'package:sneako/src/features/auth/pages/register_page.dart';
import 'package:sneako/src/features/auth/repository/remote/auth_repository.dart';
import 'package:sneako/src/features/cart/pages/cart_page.dart';
import 'package:sneako/src/features/checkout/pages/add_new_address.dart';
import 'package:sneako/src/features/checkout/pages/address_page.dart';
import 'package:sneako/src/features/checkout/pages/checkout_page.dart';
import 'package:sneako/src/features/favourite/pages/fav_page.dart';
import 'package:sneako/src/features/orders/pages/order_details_page.dart';
import 'package:sneako/src/features/orders/pages/orders_page.dart';
import 'package:sneako/src/features/product_details/pages/product_details_page.dart';
import 'package:sneako/src/features/root/pages/rootpage.dart';
import 'package:sneako/src/models/order.dart';
import 'package:sneako/src/models/product.dart';
import 'package:sneako/src/router/state_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AppRoutes {
  login,
  register,
  root,
  product,
  cart,
  checkout,
  addresses,
  addAddress,
  favourite,
  orders,
  orderDetails,
}

final routerProvider = Provider<GoRouter>((ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
    routes: [
      GoRoute(
          path: "/login",
          name: AppRoutes.login.name,
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              path: "register",
              name: AppRoutes.register.name,
              builder: (context, state) => const RegisterPage(),
            ),
          ]),
      GoRoute(
        path: '/',
        name: AppRoutes.root.name,
        builder: (context, state) => const RootPage(),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: AppRoutes.product.name,
            builder: (_, state) {
              return ProductDetailsPage(
                productId: int.parse(state.pathParameters['id']!),
                product: state.extra as Product,
              );
            },
          ),
          GoRoute(
            path: 'favourite',
            name: AppRoutes.favourite.name,
            builder: (context, state) => const FavPage(),
          ),
          GoRoute(
              path: 'cart',
              name: AppRoutes.cart.name,
              builder: (context, state) => const CartPage(),
              routes: [
                GoRoute(
                  path: 'checkout',
                  name: AppRoutes.checkout.name,
                  builder: (context, state) => const CheckOutPage(),
                  routes: [
                    GoRoute(
                      path: 'addresses',
                      name: AppRoutes.addresses.name,
                      builder: (context, state) => const AddressPage(),
                    ),
                  ],
                ),
              ]),
          GoRoute(
              path: 'orders',
              name: AppRoutes.orders.name,
              builder: (context, state) => const OrdersPage(),
              routes: [
                GoRoute(
                  path: ':id',
                  name: AppRoutes.orderDetails.name,
                  builder: (context, state) {
                    state.pathParameters['id'];
                    return OrderDetailsPage(
                      order: state.extra as ProductOrder,
                    );
                  },
                )
              ])
        ],
      ),
    ],
    redirect: (context, state) {
      final User? session = Supabase.instance.client.auth.currentUser;
      final isAuth = session != null;

      final isHome = state.fullPath == '/';

      if (isHome) {
        return isAuth ? '/' : '/login';
      }

      final isLoggingIn = state.fullPath == '/login';
      final isRegister = state.fullPath == '/login/register';

      if (isLoggingIn) return isAuth ? '/' : null;

      if (isRegister) {
        if (isAuth) {
          return '/';
        } else {
          return null;
        }
      }

      return isAuth ? null : '/';
    },
  );
});
