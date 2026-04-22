import 'package:go_router/go_router.dart';

import '../views/dashboard_view.dart';
import '../views/detalle_departamento_view.dart';
import '../views/detalle_view.dart';
import '../views/listado_departamentos_view.dart';
import '../views/listado_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/listado',
      name: 'listado',
      builder: (context, state) => const ListadoView(),
    ),
    GoRoute(
      path: '/detalle/:id',
      name: 'detalle',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return DetalleView(id: id, item: state.extra);
      },
    ),
    GoRoute(
      path: '/departamentos',
      name: 'listadoDepartamentos',
      builder: (context, state) => const ListadoDepartamentosView(),
    ),
    GoRoute(
      path: '/departamentos/detalle/:id',
      name: 'detalleDepartamento',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return DetalleDepartamentoView(id: id, department: state.extra);
      },
    ),
  ],
);
