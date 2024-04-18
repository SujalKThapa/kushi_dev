import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ContactProvider(),
        builder: (context, _) => ContactList(),
      ),
    );
  }
}

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);

    return Consumer<ContactProvider>(
      builder: (context, provider, _) {
        if (provider.contacts == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _fetchContacts(context);
                  },
                  child: Text('Sync Contacts'),
                ),
                SizedBox(height: 20),
                Text('Press "Sync Contacts" to fetch contacts'),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: provider.contacts!.length,
            itemBuilder: (context, index) {
              Contact contact = provider.contacts!.elementAt(index);
              // Check if contact's number exists in Firestore (replace with your logic)
              bool isContactInFirestore = false; // Replace with your logic
              return ListTile(
                title: Text(contact.displayName ?? ''),
                subtitle: Text(contact.phones!.isNotEmpty
                    ? contact.phones?.elementAt(0).value ?? ''
                    : 'No phone number'),
                trailing: !isContactInFirestore
                    ? ElevatedButton(
                  onPressed: () {
                    // Handle invite action
                    // Replace with your logic to handle invite action
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Invite"),
                          content: Text(
                              "Invite ${contact.displayName ?? 'this contact'}?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Send invitation
                                // Replace with your logic to send invitation
                                Navigator.pop(context);
                              },
                              child: Text("Invite"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Invite'),
                )
                    : null,
              );
            },
          );
        }
      },
    );
  }

  Future<void> _fetchContacts(BuildContext context) async {
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isDenied) {
        // Permission was denied, show a dialog explaining why the permission is necessary
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Contacts Permission Required"),
              content: Text(
                  "Please grant permission to access your contacts so that we can find friends to invite."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        return;
      }
    }

    Iterable<Contact> contacts = await ContactsService.getContacts();
    contactProvider.setContacts(contacts);
  }
}

class ContactProvider extends ChangeNotifier {
  Iterable<Contact>? _contacts;

  Iterable<Contact>? get contacts => _contacts;

  void setContacts(Iterable<Contact> contacts) {
    _contacts = contacts;
    notifyListeners();
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactPage(),
  ));
}
