import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'checkout.dart';
import 'checkout_models.dart';

class CartScreen extends StatefulWidget {
	const CartScreen({super.key, this.initialItems});

	final List<CheckoutCartItem>? initialItems;

	@override
	State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
	late List<CheckoutCartItem> _items;

	@override
	void initState() {
		super.initState();
		_items = List<CheckoutCartItem>.from(widget.initialItems ?? samplePcBuildItems());
	}

	double get _subtotal => CheckoutPricing.subtotal(_items);
	double get _tax => CheckoutPricing.tax(_subtotal);
	double get _shipping => CheckoutPricing.shipping(_subtotal);
	double get _total => CheckoutPricing.total(_items);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.background,
			appBar: AppBar(
				title: const Text('CART // READY TO CHECKOUT'),
				actions: [
					IconButton(
						tooltip: 'Refresh sample order',
						onPressed: () {
							setState(() {
								_items = List<CheckoutCartItem>.from(samplePcBuildItems());
							});
						},
						icon: const Icon(Icons.restart_alt),
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
																	'Mock cart built from the PC Builder catalogue. Adjust quantities and continue to checkout with live totals.',
																	style: TextStyle(
																		color: AppColors.textSecondary,
																		height: 1.45,
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
						child: ListView.separated(
							padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
							itemCount: _items.length,
							separatorBuilder: (_, __) => const SizedBox(height: 12),
							itemBuilder: (context, index) {
								final item = _items[index];
								return Container(
									decoration: BoxDecoration(
										color: AppColors.surfaceCard,
										borderRadius: BorderRadius.circular(16),
										border: Border.all(color: AppColors.surfaceElevated.withOpacity(0.5)),
									),
									child: Padding(
										padding: const EdgeInsets.all(12),
										child: Row(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												ClipRRect(
													borderRadius: BorderRadius.circular(12),
													child: Image.asset(
														item.imageAsset,
														width: 78,
														height: 78,
														fit: BoxFit.cover,
													),
												),
												const SizedBox(width: 12),
												Expanded(
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															Row(
																children: [
																	Container(
																		padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
																		decoration: BoxDecoration(
																			color: AppColors.neonCyan.withOpacity(0.14),
																			borderRadius: BorderRadius.circular(999),
																		),
																		child: Text(
																			item.category.toUpperCase(),
																			style: const TextStyle(
																				fontSize: 10,
																				fontFamily: 'Courier',
																				color: AppColors.neonCyan,
																				fontWeight: FontWeight.bold,
																			),
																		),
																	),
																	const SizedBox(width: 8),
																	Flexible(
																		child: Text(
																			item.compatibilityTag,
																			overflow: TextOverflow.ellipsis,
																			style: const TextStyle(
																				fontSize: 10,
																				fontFamily: 'Courier',
																				color: AppColors.textMuted,
																			),
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
																						setState(() {
																							_items[index] = item.copyWith(quantity: item.quantity - 1);
																						});
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
																			setState(() {
																				_items[index] = item.copyWith(quantity: item.quantity + 1);
																			});
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
													Navigator.of(context).push(
														MaterialPageRoute(
															builder: (_) => CheckoutScreen(items: List<CheckoutCartItem>.from(_items)),
														),
													);
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

