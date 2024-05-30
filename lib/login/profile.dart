import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _firstName = '';
  String _lastName = '';
  String _contactNumber = '';
  String _email = '';
  DateTime? _dateOfBirth;
  String _selectedGender = 'Select Gender';

  final _formKey = GlobalKey<FormState>();

  // Function to handle date selection
  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        _dateOfBirth = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image container
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/profile_image.png'), // Replace with your image path
              ),
              SizedBox(height: 20.0),

              // TextFields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name.';
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value!,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name.';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value!,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number.';
                  }
                  return null;
                },
                onSaved: (value) => _contactNumber = value!,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email ID',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email ID.';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 10.0),

              // Date Picker
              TextButton(
                onPressed: () => _selectDate(context),
                child: Text(_dateOfBirth == null ? 'Select Date of Birth' : _dateOfBirth!.toLocal().toString().split(' ')[0]),
              ),
              SizedBox(height: 10.0),

              // Dropdown for Gender
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: [
                  DropdownMenuItem<String>(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Select Gender',
                    child: Text('Select Gender'),
                  ),
                  // Add more options as needed
                ],
                onChanged: (value) => setState(() => _selectedGender = value!),
                validator: (value) {
                  if (value == 'Select Gender') {
                    return 'Please select your gender.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),

              // Save button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle form submission logic here (e.g., save data)
                    // You can use the saved values here
                    print("First Name: $_firstName");
                    print("Last Name: $_lastName");
                    print("Contact Number: $_contactNumber");
                    print("Email: $_email");
                    print("Date of Birth: $_dateOfBirth");
                    print("Gender: $_selectedGender");
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
