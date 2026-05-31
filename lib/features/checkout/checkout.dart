import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'checkout_models.dart';

class CheckoutScreen extends StatefulWidget {
	const CheckoutScreen({super.key, required this.items});

	final List<CheckoutCartItem> items;

	@override
	State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	final TextEditingController _nameController = TextEditingController();
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _addressController = TextEditingController();
	final TextEditingController _promoController = TextEditingController();

	String _paymentMethod = 'Card';
	bool _isPlacingOrder = false;
	bool _orderPlaced = false;
	late String _orderNumber;

	double get _subtotal => CheckoutPricing.subtotal(widget.items);
	double get _tax => CheckoutPricing.tax(_subtotal);
	double get _shipping => CheckoutPricing.shipping(_subtotal);
	double get _discount => _promoController.text.trim().toUpperCase() == 'NEXUS10' ? _subtotal * 0.10 : 0.0;
	double get _total => (_subtotal + _tax + _shipping - _discount).clamp(0, double.infinity);

	@override
	void dispose() {
		_nameController.dispose();
		_emailController.dispose();
		_addressController.dispose();
		_promoController.dispose();
		super.dispose();
	}

	String _nextOrderNumber() {
		final now = DateTime.now();
		return 'RGB-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';
	}

	void _placeOrder() async {
		if (!(_formKey.currentState?.validate() ?? false)) return;

		setState(() {
			_isPlacingOrder = true;
		});

		await Future<void>.delayed(const Duration(milliseconds: 900));

		setState(() {
			_orderNumber = _nextOrderNumber();
			_isPlacingOrder = false;
			_orderPlaced = true;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.background,
			appBar: AppBar(
				title: const Text('CHECKOUT // MOCK FLOW'),
			),
			body: AnimatedSwitcher(
				duration: const Duration(milliseconds: 300),
				child: _orderPlaced ? _buildSuccessView(context) : _buildCheckoutView(context),
			),
		);
	}

	Widget _buildCheckoutView(BuildContext context) {
		return Form(
			key: _formKey,
			child: ListView(
				key: const ValueKey('checkout-form'),
				padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
				children: [
					Container(
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(22),
							gradient: const LinearGradient(
								colors: [Color(0xFF101827), Color(0xFF0A111A)],
								begin: Alignment.topLeft,
								end: Alignment.bottomRight,
							),
							border: Border.all(color: AppColors.neonMagenta.withOpacity(0.35)),
						),
						child: ClipRRect(
							borderRadius: BorderRadius.circular(22),
							child: Stack(
								children: [
									Positioned.fill(
										child: Opacity(
											opacity: 0.15,
											child: Image.asset(
												'assets/images/buildofthemonth.webp',
												fit: BoxFit.cover,
											),
										),
									),
									Padding(
										padding: const EdgeInsets.all(18),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												const Text(
													'ORDER REVIEW',
													style: TextStyle(
														fontFamily: 'Courier',
														color: AppColors.neonCyan,
														fontWeight: FontWeight.w900,
														letterSpacing: 1.2,
													),
												),
												const SizedBox(height: 8),
												Text(
													'${widget.items.length} items in your build order.',
													style: const TextStyle(color: AppColors.textSecondary),
												),
											],
										),
									),
								],
							),
						),
					),
					const SizedBox(height: 16),
					...widget.items.map((item) => Padding(
								padding: const EdgeInsets.only(bottom: 10),
								child: Container(
									decoration: BoxDecoration(
										color: AppColors.surfaceCard,
										borderRadius: BorderRadius.circular(16),
									),
									child: ListTile(
										contentPadding: const EdgeInsets.all(12),
										leading: ClipRRect(
											borderRadius: BorderRadius.circular(10),
											child: Image.asset(item.imageAsset, width: 56, height: 56, fit: BoxFit.cover),
										),
										title: Text(item.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800)),
										subtitle: Text(
											'${item.category} • ${item.compatibilityTag} • Qty ${item.quantity}',
											style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
										),
										trailing: Text(
											moneyFormat.format(item.lineTotal),
											style: const TextStyle(color: AppColors.neonGreen, fontWeight: FontWeight.w900),
										),
									),
								),
							)),
					const SizedBox(height: 8),
					Container(
						padding: const EdgeInsets.all(16),
						decoration: BoxDecoration(
							color: AppColors.surfaceCard,
							borderRadius: BorderRadius.circular(18),
							border: Border.all(color: AppColors.surfaceElevated.withOpacity(0.5)),
						),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								const Text('LIVE SUMMARY', style: TextStyle(fontFamily: 'Courier', color: AppColors.neonCyan, fontWeight: FontWeight.w900)),
								const SizedBox(height: 12),
								summaryLine(label: 'Subtotal', value: moneyFormat.format(_subtotal)),
								const SizedBox(height: 6),
								summaryLine(label: 'Tax (8%)', value: moneyFormat.format(_tax)),
								const SizedBox(height: 6),
								summaryLine(label: 'Shipping', value: _shipping == 0 ? 'FREE' : moneyFormat.format(_shipping)),
								const SizedBox(height: 6),
								summaryLine(label: 'Discount', value: _discount == 0 ? '-\$0.00' : '-${moneyFormat.format(_discount)}'),
								const SizedBox(height: 12),
								const Divider(color: Color(0xFF243447)),
								const SizedBox(height: 12),
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										const Text('TOTAL DUE', style: TextStyle(fontFamily: 'Courier', color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
										Text(moneyFormat.format(_total), style: const TextStyle(color: AppColors.neonCyan, fontSize: 22, fontWeight: FontWeight.w900)),
									],
								),
							],
						),
					),
					const SizedBox(height: 16),
					_buildField(
						controller: _nameController,
						label: 'Full name',
						icon: Icons.person_outline,
						validator: (value) => value == null || value.trim().isEmpty ? 'Enter a name' : null,
					),
					const SizedBox(height: 12),
					_buildField(
						controller: _emailController,
						label: 'Email address',
						icon: Icons.alternate_email,
						keyboardType: TextInputType.emailAddress,
						validator: (value) {
							if (value == null || value.trim().isEmpty) return 'Enter an email';
							if (!value.contains('@')) return 'Enter a valid email';
							return null;
						},
					),
					const SizedBox(height: 12),
					_buildField(
						controller: _addressController,
						label: 'Shipping address',
						icon: Icons.local_shipping_outlined,
						maxLines: 3,
						validator: (value) => value == null || value.trim().isEmpty ? 'Enter a shipping address' : null,
					),
					const SizedBox(height: 12),
					_buildField(
						controller: _promoController,
						label: 'Promo code (optional)',
						icon: Icons.local_offer_outlined,
						onChanged: (_) => setState(() {}),
					),
					const SizedBox(height: 16),
					const Text('PAYMENT METHOD', style: TextStyle(fontFamily: 'Courier', color: AppColors.neonMagenta, fontWeight: FontWeight.w900)),
					const SizedBox(height: 8),
					Wrap(
						spacing: 10,
						runSpacing: 10,
						children: ['Card', 'PayPal', 'Cash on Delivery'].map((method) {
							final selected = _paymentMethod == method;
							return ChoiceChip(
								label: Text(method),
								selected: selected,
								onSelected: (_) => setState(() => _paymentMethod = method),
								selectedColor: AppColors.neonCyan,
								labelStyle: TextStyle(
									color: selected ? Colors.black : AppColors.textPrimary,
									fontWeight: FontWeight.w700,
								),
								backgroundColor: AppColors.surfaceElevated,
							);
						}).toList(),
					),
					const SizedBox(height: 18),
					Container(
						padding: const EdgeInsets.all(14),
						decoration: BoxDecoration(
							color: AppColors.surfaceCard,
							borderRadius: BorderRadius.circular(16),
							border: Border.all(color: AppColors.neonGreen.withOpacity(0.25)),
						),
						child: Row(
							children: [
								const Icon(Icons.verified, color: AppColors.neonGreen),
								const SizedBox(width: 10),
								Expanded(
									child: Text(
										'This is a mock checkout. Placing the order will show a success receipt flow without charging a payment method.',
										style: TextStyle(color: AppColors.textSecondary, height: 1.45),
									),
								),
							],
						),
					),
					const SizedBox(height: 18),
					SizedBox(
						width: double.infinity,
						child: ElevatedButton(
							style: ElevatedButton.styleFrom(
								minimumSize: const Size(double.infinity, 54),
								backgroundColor: AppColors.neonMagenta,
								foregroundColor: Colors.white,
							),
							onPressed: _isPlacingOrder ? null : _placeOrder,
							child: _isPlacingOrder
								? const SizedBox(
										width: 18,
										height: 18,
										child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
									)
								: const Text(
										'PLACE MOCK ORDER',
										style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, letterSpacing: 1.1),
									),
						),
					),
				],
			),
		);
	}

	Widget _buildSuccessView(BuildContext context) {
		return ListView(
			key: const ValueKey('checkout-success'),
			padding: const EdgeInsets.all(16),
			children: [
				Container(
					padding: const EdgeInsets.all(18),
					decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(22),
						gradient: const LinearGradient(
							colors: [Color(0xFF102032), Color(0xFF091017)],
							begin: Alignment.topLeft,
							end: Alignment.bottomRight,
						),
						border: Border.all(color: AppColors.neonGreen.withOpacity(0.35)),
					),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							ClipRRect(
								borderRadius: BorderRadius.circular(18),
								child: Image.asset(
									'assets/images/buildofthemonth.webp',
									height: 180,
									width: double.infinity,
									fit: BoxFit.cover,
								),
							),
							const SizedBox(height: 16),
							const Text(
								'ORDER SUCCESSFUL',
								style: TextStyle(
									fontFamily: 'Courier',
									color: AppColors.neonGreen,
									fontWeight: FontWeight.w900,
									fontSize: 20,
									letterSpacing: 1.2,
								),
							),
							const SizedBox(height: 8),
							Text('Order number $_orderNumber has been created.', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
							const SizedBox(height: 8),
							const Text(
								'Your build has been reserved and is waiting for dispatch. A receipt email has been mocked for this flow.',
								style: TextStyle(color: AppColors.textSecondary, height: 1.45),
							),
						],
					),
				),
				const SizedBox(height: 16),
				Container(
					padding: const EdgeInsets.all(16),
					decoration: BoxDecoration(
						color: AppColors.surfaceCard,
						borderRadius: BorderRadius.circular(18),
					),
					child: Column(
						children: [
								summaryLine(label: 'Items', value: '${widget.items.length}'),
							const SizedBox(height: 8),
								summaryLine(label: 'Paid with', value: _paymentMethod),
							const SizedBox(height: 8),
								summaryLine(label: 'Total charged', value: moneyFormat.format(_total)),
							const SizedBox(height: 8),
								summaryLine(label: 'Delivery estimate', value: '2-4 business days'),
						],
					),
				),
				const SizedBox(height: 18),
				SizedBox(
					width: double.infinity,
					child: ElevatedButton(
						style: ElevatedButton.styleFrom(
							minimumSize: const Size(double.infinity, 52),
							backgroundColor: AppColors.neonCyan,
							foregroundColor: Colors.black,
						),
						onPressed: () => Navigator.of(context).pop(),
						child: const Text(
							'BACK TO CART',
							style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.w900, letterSpacing: 1.1),
						),
					),
				),
			],
		);
	}

	Widget _buildField({
		required TextEditingController controller,
		required String label,
		required IconData icon,
		String? Function(String?)? validator,
		TextInputType keyboardType = TextInputType.text,
		int maxLines = 1,
		ValueChanged<String>? onChanged,
	}) {
		return TextFormField(
			controller: controller,
			validator: validator,
			keyboardType: keyboardType,
			maxLines: maxLines,
			onChanged: onChanged,
			style: const TextStyle(color: AppColors.textPrimary),
			decoration: InputDecoration(
				labelText: label,
				prefixIcon: Icon(icon, color: AppColors.neonCyan),
				filled: true,
				fillColor: AppColors.surfaceCard,
				border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
				enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.surfaceElevated.withOpacity(0.45))),
				focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.neonCyan)),
				errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.redAccent)),
				labelStyle: const TextStyle(color: AppColors.textMuted),
			),
		);
	}

	Widget summaryLine({required String label, required String value}) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				Text(label, style: const TextStyle(color: AppColors.textSecondary, fontFamily: 'Courier')),
				Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800)),
			],
		);
	}
}

