import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../state/app_state.dart';
import '../../theme/app_colors.dart';

class BookingScreen extends StatefulWidget {
  final Function(String ticketNumber)? onBookingComplete;
  const BookingScreen({super.key, this.onBookingComplete});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _currentStep = 0;
  
  // Step 1: Service Type
  String _selectedService = 'Professional Thermal Repasting & Clean';
  final List<String> _services = [
    'Professional Thermal Repasting & Clean',
    'RAM / Storage Upgrade & Install',
    'GPU / PSU Power Supply Upgrade',
    'Custom Hardline Liquid Cooling Setup',
    'Diagnostics & System Crash Troubleshooting',
    'General Clean & Dusting Blowout'
  ];

  // Step 2: Device details
  final _deviceFormKey = GlobalKey<FormState>();
  final _deviceBrandController = TextEditingController();
  final _deviceModelController = TextEditingController();
  final _deviceSerialController = TextEditingController();
  final _issueDetailsController = TextEditingController();

  // Step 3: Date & Time Slots
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTimeSlot = '10:00 AM - 12:00 PM';
  final List<String> _timeSlots = [
    '09:00 AM - 11:00 AM',
    '10:00 AM - 12:00 PM',
    '01:00 PM - 03:00 PM',
    '03:00 PM - 05:00 PM',
    '06:00 PM - 08:00 PM'
  ];

  // Step 4: Contact details
  final _contactFormKey = GlobalKey<FormState>();
  final _contactNameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _contactPhoneController = TextEditingController();

  // Step 5: Success Summary
  String? _generatedTicketCode;

  @override
  void dispose() {
    _deviceBrandController.dispose();
    _deviceModelController.dispose();
    _deviceSerialController.dispose();
    _issueDetailsController.dispose();
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _contactPhoneController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 1) {
      if (!_deviceFormKey.currentState!.validate()) return;
    }
    if (_currentStep == 3) {
      if (!_contactFormKey.currentState!.validate()) return;
      _submitBooking();
    }
    setState(() {
      _currentStep++;
    });
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitBooking() {
    final state = Provider.of<AppStateNotifier>(context, listen: false);
    final ticketCode = state.bookRepair(
      deviceName: '${_deviceBrandController.text} ${_deviceModelController.text}',
      issue: _selectedService,
      details: _issueDetailsController.text,
      date: _selectedDate,
      timeSlot: _selectedTimeSlot,
      name: _contactNameController.text,
      email: _contactEmailController.text,
      phone: _contactPhoneController.text,
    );
    setState(() {
      _generatedTicketCode = ticketCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REPAIR INTAKE'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep > 4 ? 4 : _currentStep,
        onStepContinue: _currentStep < 4 ? _nextStep : null,
        onStepCancel: _currentStep > 0 && _currentStep < 4 ? _prevStep : null,
        controlsBuilder: (context, details) {
          if (_currentStep >= 4) return const SizedBox.shrink();
          return Container(
            margin: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(_currentStep == 3 ? 'FINALIZE TICKET' : 'NEXT STEP'),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('BACK'),
                    ),
                  ),
                ]
              ],
            ),
          );
        },
        steps: [
          Step(
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            title: const Text('Service', style: TextStyle(fontSize: 10, fontFamily: 'Courier')),
            content: _buildServiceSelection(),
          ),
          Step(
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            title: const Text('Device', style: TextStyle(fontSize: 10, fontFamily: 'Courier')),
            content: _buildDeviceDetails(),
          ),
          Step(
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            title: const Text('Schedule', style: TextStyle(fontSize: 10, fontFamily: 'Courier')),
            content: _buildScheduler(),
          ),
          Step(
            isActive: _currentStep >= 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
            title: const Text('Contact', style: TextStyle(fontSize: 10, fontFamily: 'Courier')),
            content: _buildContactForm(),
          ),
          Step(
            isActive: _currentStep >= 4,
            state: StepState.complete,
            title: const Text('Done', style: TextStyle(fontSize: 10, fontFamily: 'Courier')),
            content: _buildConfirmation(),
          ),
        ],
      ),
    );
  }

  // STEP 1: SERVICE TYPE WIDGET
  Widget _buildServiceSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECT SERVICE CATEGORY',
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            color: AppColors.neonCyan,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final svc = _services[index];
            final isSelected = _selectedService == svc;
            return Card(
              color: isSelected ? AppColors.surfaceElevated : AppColors.surfaceCard,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected ? AppColors.neonCyan : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    _selectedService = svc;
                  });
                },
                leading: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
                ),
                title: Text(
                  svc,
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // STEP 2: DEVICE DETAILS WIDGET
  Widget _buildDeviceDetails() {
    return Form(
      key: _deviceFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DEVICE SPECIFICATIONS & IDENTIFICATION',
            style: TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
              color: AppColors.neonCyan,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _deviceBrandController,
            decoration: const InputDecoration(
              labelText: 'BRAND (e.g. ASUS, MSI, Razer)',
            ),
            validator: (value) => value!.isEmpty ? 'Field required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _deviceModelController,
            decoration: const InputDecoration(
              labelText: 'MODEL NAME / NUMBER (e.g. Zephyrus G14, Aegis 5)',
            ),
            validator: (value) => value!.isEmpty ? 'Field required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _deviceSerialController,
            decoration: const InputDecoration(
              labelText: 'SERIAL NUMBER (Optional / Mock)',
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _issueDetailsController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'DESCRIBE THE ISSUE / REQUEST DETAILS',
              hintText: 'e.g. Temps spike to 95C when starting Cyberpunk, dust blowout requested.',
            ),
            validator: (value) => value!.isEmpty ? 'Field required' : null,
          ),
        ],
      ),
    );
  }

  // STEP 3: SCHEDULER WIDGET
  Widget _buildScheduler() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BOOK DROP-OFF APPOINTMENT',
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            color: AppColors.neonCyan,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                'DATE: ${DateFormat('EEEE, MMM d, yyyy').format(_selectedDate)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: AppColors.neonCyan,
                          surface: AppColors.surfaceCard,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              },
              child: const Text('PICK DATE'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'AVAILABLE TIME SLOTS',
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            color: AppColors.neonMagenta,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _timeSlots.map((slot) {
            final isSelected = _selectedTimeSlot == slot;
            return ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.neonCyan,
              backgroundColor: AppColors.surfaceCard,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedTimeSlot = slot;
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // STEP 4: CONTACT FORM WIDGET
  Widget _buildContactForm() {
    return Form(
      key: _contactFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CONTACT INFORMATION',
            style: TextStyle(
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
              color: AppColors.neonCyan,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _contactNameController,
            decoration: const InputDecoration(
              labelText: 'FULL NAME',
            ),
            validator: (value) => value!.isEmpty ? 'Field required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _contactEmailController,
            decoration: const InputDecoration(
              labelText: 'EMAIL ADDRESS',
            ),
            validator: (value) => value!.isEmpty ? 'Field required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _contactPhoneController,
            decoration: const InputDecoration(
              labelText: 'PHONE NUMBER',
            ),
            validator: (value) => value!.isEmpty ? 'Field required' : null,
          ),
        ],
      ),
    );
  }

  // STEP 5: CONFIRMATION WIDGET
  Widget _buildConfirmation() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 36,
              child: Icon(
                Icons.check,
                color: Colors.black,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'INTAKE REQUEST GENERATED',
              style: TextStyle(
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: AppColors.neonGreen,
                fontSize: 18,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your system diagnostics profile has been successfully generated and queued in our records.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.neonCyan, width: 1),
              ),
              child: Column(
                children: [
                  const Text(
                    'DIAGNOSTICS ACCESS TICKET',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _generatedTicketCode ?? 'RGB---',
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neonCyan,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonCyan,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                if (widget.onBookingComplete != null && _generatedTicketCode != null) {
                  widget.onBookingComplete!(_generatedTicketCode!);
                }
              },
              child: const Text('TRACK TICKET STATUS'),
            ),
          ],
        ),
      ),
    );
  }
}
