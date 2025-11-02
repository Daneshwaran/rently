import 'package:go_router/go_router.dart';
import '../pages/house_list_page.dart';
import '../pages/create_house_page.dart';
import '../pages/house_detail_page.dart';
import '../pages/tenant_form_page.dart';
import '../pages/meter_reading_page.dart';
import '../pages/payment_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'house-list',
      builder: (context, state) => const HouseListPage(),
      routes: [
        GoRoute(
          path: 'house/create',
          name: 'create-house',
          builder: (context, state) => const CreateHousePage(),
        ),
        GoRoute(
          path: 'house/:id',
          name: 'house-detail',
          builder: (context, state) {
            final houseId = state.pathParameters['id']!;
            return HouseDetailPage(houseId: houseId);
          },
          routes: [
            GoRoute(
              path: 'tenant/create',
              name: 'create-tenant',
              builder: (context, state) {
                final houseId = state.pathParameters['id']!;
                return TenantFormPage(houseId: houseId);
              },
            ),
            GoRoute(
              path: 'meter-reading',
              name: 'meter-reading',
              builder: (context, state) {
                final houseId = state.pathParameters['id']!;
                return MeterReadingPage(houseId: houseId);
              },
            ),
            GoRoute(
              path: 'payment',
              name: 'payment',
              builder: (context, state) {
                final houseId = state.pathParameters['id']!;
                return PaymentPage(houseId: houseId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
