import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../state/app_state.dart';
import 'checkout.dart';
import 'checkout_models.dart';

class CartScreen extends StatefulWidget {
	const CartScreen({super.key, this.initialItems});

	final List<CheckoutCartItem>? initialItems;

	@override
	State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
	@override
	Widget build(BuildContext context) {
		final appState = Provider.of<AppStateNotifier>(context);
		final _items = appState.cartItems;
		
		final double _subtotal = CheckoutPricing.subtotal(_items);
		final double _tax = CheckoutPricing.tax(_subtotal);
		final double _shipping = CheckoutPricing.shipping(_subtotal);
		final double _total = CheckoutPricing.total(_items);

		return Scaffold(
			backgroundColor: AppColors.background,
			appBar: AppBar(
				title: const Text('CART // READY TO CHECKOUT'),
				actions: [
					IconButton(
						tooltip: 'Clear Cart',
						onPressed: () {
							appState.clearCart();
							ScaffoldMessenger.of(context).showSnackBar(
								const SnackBar(content: Text('CART CLEARED')),
							);
						},
						icon: const Icon(Icons.delete_sweep),
					),
				],
			),
			body: Column(
				children: [
					Padding(
						padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
						child: Container(
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(20),
								gradient: const LinearGradient(
									colors: [Color(0xFF101A28), Color(0xFF0A111A)],
									begin: Alignment.topLeft,
									end: Alignment.bottomRight,
								),
								border: Border.all(color: AppColors.neonCyan.withOpacity(0.35)),
							),
							child: ClipRRect(
								borderRadius: BorderRadius.circular(20),
								child: Stack(
									children: [
										Positioned.fill(
											child: Opacity(
												opacity: 0.16,
												child: Image.asset(
													'assets/images/buildofthemonth.webp',
													fit: BoxFit.cover,
													errorBuilder: (_, __, ___) => const SizedBox(),
												),
											),
										),
										Padding(
											padding: const EdgeInsets.all(18),
											child: Row(
												children: [
													ClipRRect(
														borderRadius: BorderRadius.circular(16),
														child: Image.asset(
															'assets/images/gaming-computer-case-isolated-png.webp',
															width: 96,
															height: 96,
															fit: BoxFit.contain,
															errorBuilder: (_, __, ___) => const Icon(Icons.computer, size: 64, color: AppColors.neonCyan),
														),
													),
													const SizedBox(width: 16),
													Expanded(
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: const [
																Text(
																	'ORDER SUMMARY',
																	style: TextStyle(
																		fontFamily: 'Courier',
																		color: AppColors.neonCyan,
																		fontWeight: FontWeight.w900,
																		letterSpacing: 1.3,
																	),
																),
																SizedBox(height: 6),
																Text(
																	'Verify your rig selections prior to initiating payment sequence.',
																	style: TextStyle(
																		fontSize: 12,
																		color: AppColors.textSecondary,
																		height: 1.3,
																	),
																),
															],
														),
													),
												],
											),
										),
									],
								),
							),
						),
					),
					Expanded(
						child: _items.isEmpty
								? Center(
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												Icon(
													Icons.shopping_cart_outlined,
													size: 64,
													color: AppColors.neonMagenta.withOpacity(0.85),
												),
												const SizedBox(height: 16),
												const Text(
													'CART_NODE // EMPTY',
													style: TextStyle(
														fontFamily: 'Courier',
														fontSize: 16,
														fontWeight: FontWeight.bold,
														color: Colors.white,
														letterSpacing: 1.5,
													),
												),
												const SizedBox(height: 8),
												const Text(
													'Add components from Shop or custom rigs.',
													style: TextStyle(
														fontSize: 12,
														color: AppColors.textSecondary,
													),
												),
											],
										),
									)
								: ListView.separated(
										padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
										itemCount: _items.length,
										separatorBuilder: (_, __) => const SizedBox(height: 12),
										itemBuilder: (context, index) {
											final item = _items[index];
											return Card(
												margin: EdgeInsets.zero,
												color: AppColors.surfaceCard,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(16),
													side: BorderSide(
														color: AppColors.neonCyan.withOpacity(0.15),
														width: 1,
													),
												),
												child: Padding(
													padding: const EdgeInsets.all(14),
													child: Row(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															Expanded(
																child: Column(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Row(
																			mainAxisAlignment: MainAxisAlignment.spaceBetween,
																			children: [
																				Container(
																					padding: const EdgeInsets.symmetric(
																						horizontal: 8,
																						vertical: 3,
																					),
																					decoration: BoxDecoration(
																						color: AppColors.neonCyan.withOpacity(0.12),
																						borderRadius: BorderRadius.circular(4),
																					),
																					child: Row(
																						mainAxisSize: MainAxisSize.min,
																						children: [
																							const Icon(
																								Icons.terminal,
																								color: AppColors.neonCyan,
																								size: 10,
																							),
																							const SizedBox(width: 4),
																							Flexible(
																								child: Text(
																									item.category.toUpperCase(),
																									overflow: TextOverflow.ellipsis,
																									style: const TextStyle(
																										fontSize: 9,
																										fontFamily: 'Courier',
																										fontWeight: FontWeight.w900,
																										color: AppColors.neonCyan,
																										letterSpacing: 1.1,
																									),
																								),
																							),
																							const SizedBox(width: 8),
																							Flexible(
																								child: Text(
																									item.compatibilityTag,
																									overflow: TextOverflow.ellipsis,
																									style: const TextStyle(
																										fontSize: 9,
																										fontFamily: 'Courier',
																										color: AppColors.textMuted,
																									),
																								),
																							),
																						],
																					),
																				),
																				GestureDetector(
																					onTap: () {
																						appState.removeFromCart(item.name);
																						ScaffoldMessenger.of(context).showSnackBar(
																							SnackBar(
																								content: Text(
																									'REMOVED ${item.name} FROM NODE',
																									style: const TextStyle(
																										fontFamily: 'Courier',
																										fontWeight: FontWeight.bold,
																										color: Colors.white,
																									),
																								),
																								backgroundColor: AppColors.neonMagenta,
																								duration: const Duration(seconds: 2),
																							),
																						);
																					},
																					child: Icon(
																						Icons.delete_outline,
																						color: AppColors.neonMagenta.withOpacity(0.85),
																						size: 20,
																					),
																				),
																			],
																		),
																		const SizedBox(height: 8),
																		Text(
																			item.name,
																			style: const TextStyle(
																				fontSize: 14,
																				color: AppColors.textPrimary,
																				fontWeight: FontWeight.w800,
																			),
																		),
																		const SizedBox(height: 8),
																		Row(
																			children: [
																				_QuantityButton(
																					icon: Icons.remove,
																					onTap: item.quantity > 1
																							? () {
																									appState.updateCartItemQuantity(item.name, item.quantity - 1);
																								}
																							: null,
																				),
																				Padding(
																					padding: const EdgeInsets.symmetric(horizontal: 12),
																					child: Text(
																						'x${item.quantity}',
																						style: const TextStyle(
																							color: AppColors.textPrimary,
																							fontWeight: FontWeight.w800,
																						),
																					),
																				),
																				_QuantityButton(
																					icon: Icons.add,
																					onTap: () {
																						appState.updateCartItemQuantity(item.name, item.quantity + 1);
																					},
																				),
																				const Spacer(),
																				Text(
																					moneyFormat.format(item.lineTotal),
																					style: const TextStyle(
																						color: AppColors.neonGreen,
																						fontSize: 15,
																						fontWeight: FontWeight.w900,
																					),
																				),
																			],
																		),
																	],
																),
															),
														],
													),
												),
											);
										},
									),
					),
				],
			),
			bottomNavigationBar: SafeArea(
				top: false,
				child: Container(
					padding: const EdgeInsets.all(16),
					decoration: const BoxDecoration(
						color: AppColors.surface,
						border: Border(top: BorderSide(color: Color(0xFF1E2B40))),
					),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							_SummaryLine(label: 'Subtotal', value: moneyFormat.format(_subtotal)),
							const SizedBox(height: 6),
							_SummaryLine(label: 'Tax (8%)', value: moneyFormat.format(_tax)),
							const SizedBox(height: 6),
							_SummaryLine(label: 'Shipping', value: _shipping == 0 ? 'FREE' : moneyFormat.format(_shipping)),
							const SizedBox(height: 10),
							const Divider(color: Color(0xFF213146)),
							const SizedBox(height: 10),
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									const Text(
										'TOTAL',
										style: TextStyle(
											fontFamily: 'Courier',
											fontSize: 13,
											color: AppColors.textSecondary,
											fontWeight: FontWeight.bold,
										),
									),
									Text(
										moneyFormat.format(_total),
										style: const TextStyle(
											fontSize: 20,
											color: AppColors.neonCyan,
											fontWeight: FontWeight.w900,
										),
									),
								],
							),
							const SizedBox(height: 12),
							SizedBox(
								width: double.infinity,
								child: ElevatedButton(
									style: ElevatedButton.styleFrom(
										minimumSize: const Size(double.infinity, 50),
										backgroundColor: AppColors.neonCyan,
										foregroundColor: Colors.black,
									),
									onPressed: _items.isEmpty
											? null
											: () {
													context.push('/checkout', extra: List<CheckoutCartItem>.from(_items));
												},
									child: const Text(
										'PROCEED TO CHECKOUT',
										style: TextStyle(
											fontFamily: 'Courier',
											fontWeight: FontWeight.w900,
											letterSpacing: 1.2,
										),
									),
								),
							),
						],
					),
				),
			),
		);
	}
}

class _QuantityButton extends StatelessWidget {
	const _QuantityButton({required this.icon, required this.onTap});

	final IconData icon;
	final VoidCallback? onTap;

	@override
	Widget build(BuildContext context) {
		return InkWell(
			onTap: onTap,
			borderRadius: BorderRadius.circular(999),
			child: Container(
				width: 32,
				height: 32,
				decoration: BoxDecoration(
					color: onTap == null ? AppColors.surfaceElevated.withOpacity(0.4) : AppColors.surfaceElevated,
					shape: BoxShape.circle,
				),
				child: Icon(icon, size: 18, color: onTap == null ? AppColors.textMuted : AppColors.textPrimary),
			),
		);
	}
}

class _SummaryLine extends StatelessWidget {
	const _SummaryLine({required this.label, required this.value});

	final String label;
	final String value;

	@override
	Widget build(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				Text(
					label,
					style: const TextStyle(
						color: AppColors.textSecondary,
						fontFamily: 'Courier',
					),
				),
				Text(
					value,
					style: const TextStyle(
						color: AppColors.textPrimary,
						fontWeight: FontWeight.w800,
					),
				),
			],
		);
	}
}

