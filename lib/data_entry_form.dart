// data_entry_form.dart
import 'package:flutter/material.dart';

enum FormType { FeedPost, TimelinePost, HistoryPost, Contactform }

class DataEntryForm extends StatefulWidget {
  final FormType formType;

  DataEntryForm({required this.formType});

  @override
  _DataEntryFormState createState() => _DataEntryFormState();
}

class _DataEntryFormState extends State<DataEntryForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _placementController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create ${formTypeToString(widget.formType)}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 4,
              ),
              if (widget.formType == FormType.TimelinePost || widget.formType == FormType.HistoryPost) ...[
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _eventNameController,
                  decoration: InputDecoration(labelText: 'Event Name'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _placementController,
                  decoration: InputDecoration(labelText: 'Placement'),
                ),
              ],
              if (widget.formType == FormType.Contactform) ...[
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(labelText: 'Position'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  // You can access the entered data (_titleController.text, _contentController.text, etc.) here
                  // Perform your logic to save the data or send it to the server
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formTypeToString(FormType formType) {
    switch (formType) {
      case FormType.FeedPost:
        return 'Feed Post';
      case FormType.TimelinePost:
        return 'Timeline Post';
      case FormType.HistoryPost:
        return 'History Post';
      case FormType.Contactform:
        return 'Contact Form';
    }
  }
}

