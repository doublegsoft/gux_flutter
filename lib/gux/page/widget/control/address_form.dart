import 'package:flutter/material.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  String? _selectedCountry;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aptSuiteController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  bool _cityError = false; // Track city error state

  final List<String> _countries = [ // Replace with your countries list
    'United States', 'Canada', 'United Kingdom', // ... more countries
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDropdownField('Country', _selectedCountry, _countries, (value) {
          setState(() {
            _selectedCountry = value;
          });
        }),
        _buildTextField('Full name', 'First and last name', _fullNameController),
        _buildTextField('Address', 'Location where to ship', _addressController),
        _buildTextField(
            'Apt / Suite', 'Other optional info', _aptSuiteController),
        _buildTextField(
          'City',
          _cityError ? 'Your city does not exist' : 'Enter your city',
          _cityController,
          error: _cityError,
        ),

      ],
    );
  }


  Widget _buildDropdownField(String label, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),  // Add margin between fields
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[50], // Light blue background
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text('Select $label'), // Placeholder text for Dropdown
        decoration: const InputDecoration(border: InputBorder.none),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,

        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blue), // Dropdown arrow
        style: TextStyle(color: Colors.grey[600]),

      ),
    );

  }


  Widget _buildTextField(String label, String hintText, TextEditingController controller, {bool error = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: error ? Colors.red[50] : Colors.grey[100],  // Background color based on error
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: error ? Colors.red : Colors.grey[600]), // Text color based on error
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: InputBorder.none,
          labelStyle: TextStyle(color: error ? Colors.red : Colors.grey[600]), // Label color
        ),
        onChanged: (text) { // Clear error when user types
          if (error && label == 'City') {
            setState(() {
              _cityError = false;
            });
          }

        },

      ),
    );
  }
}