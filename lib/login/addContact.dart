import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AddTrustedContacts extends StatefulWidget {
  const AddTrustedContacts({super.key});

  @override
  _AddTrustedContactsState createState() => _AddTrustedContactsState();
}

class _AddTrustedContactsState extends State<AddTrustedContacts> {
  void _openContacts() async {
    // Request permissions
    PermissionStatus permissionStatus = await Permission.contacts.status;
    if (!permissionStatus.isGranted) {
      permissionStatus = await Permission.contacts.request();
    }

    if (permissionStatus.isGranted) {
      try {
        // Retrieve contacts
        Iterable<Contact> contacts = await ContactsService.getContacts();

        // Open contacts application to select a contact (mocked here for simplicity)
        Contact? selectedContact = await showDialog<Contact>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Select a Contact"),
              content: Container(
                width: double.maxFinite,
                height: 400,
                child: ListView(
                  children: contacts.map((contact) {
                    return ListTile(
                      title: Text(contact.displayName ?? ""),
                      onTap: () {
                        Navigator.of(context).pop(contact);
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );

        // Process the selected contact
        if (selectedContact != null) {
          print("Selected Contact: ${selectedContact.displayName}");
          // Add your logic to save the selected contact as a trusted contact
        }
      } catch (e) {
        // Handle any errors that occur during contact retrieval
        print("Failed to get contacts: $e");
      }
    } else {
      // Handle the case where permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contact permission is required to select a trusted contact.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Trusted Contacts"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Add contacts who you trust that will be notified via SMS anytime you require emergency assistance during a trip",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openContacts,
              child: Text("Add"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

