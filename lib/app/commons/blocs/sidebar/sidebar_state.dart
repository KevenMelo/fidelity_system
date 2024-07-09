part of 'sidebar_cubit.dart';

class SidebarState {
  List<NavItemModel> menus = [
    NavItemModel(
        icon: Icons.storefront_rounded,
        name: 'Pedidos',
        root: OrdersRoutes.root),
    NavItemModel(
        icon: Icons.menu_book,
        name: 'Cardápio',
        root: RestaurantMenuRoutes.root),
    NavItemModel(
        icon: Icons.schedule,
        name: 'Horários de funcionamento',
        root: WorkingDaysRoutes.root),
    NavItemModel(
        icon: Icons.credit_card,
        name: 'Métodos de pagamentos',
        root: PaymentMethodsRoutes.root),
    NavItemModel(
        icon: Icons.settings,
        name: 'Configurações do restaurante',
        root: RestaurantSettingsRoutes.root),
  ];
  int active;

  SidebarState copyWith({
    int? active,
  }) {
    return SidebarState(
      active: active ?? this.active,
    );
  }

  SidebarState({this.active = 0});
}
