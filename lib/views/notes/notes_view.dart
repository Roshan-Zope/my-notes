// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enum/menu_action.dart';
import 'package:mynotes/services/auth/auth_services.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/firebase_cloud_storage.dart';
import 'package:mynotes/utilities/dialog_box.dart';
import 'package:mynotes/views/loading_screen.dart';
import 'package:mynotes/views/notes/notes_list_view.dart';

extension Count<T extends Iterable> on Stream<T> {
  Stream<int> get getLength => map((event) => event.length);
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _noteService;
  String get userId => AuthService.firebase().currentUser!.id;
  final OverlayManager _overlayManager = OverlayManager();

  @override
  void initState() {
    _noteService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _overlayManager.simulateLoadingProcess(context, () async {
                await Future.delayed(const Duration(seconds: 2));
              });
              Navigator.of(context).pushNamed(newNoteRoute);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add New Note',
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDailog(context);
                  if (shouldLogout) {
                    await _overlayManager.simulateLoadingProcess(context,
                        () async {
                      await Future.delayed(const Duration(seconds: 2));
                    });
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _noteService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: _buildLoadingIndicator());
          } else if (snapshot.hasData) {
            final allNotes = snapshot.data as Iterable<CloudNote>;
            return NotesListView(
              notes: allNotes,
              onDeleteNote: (note) async {
                await _overlayManager.simulateLoadingProcess(context,
                    () async {
                  await Future.delayed(const Duration(seconds: 2));
                });
                await _noteService.deleteNote(documentId: note.documentId);
              },
              onTap: (note) async {
                await _overlayManager.simulateLoadingProcess(context,
                    () async {
                  await Future.delayed(const Duration(seconds: 2));
                });
                Navigator.of(context).pushNamed(
                  newNoteRoute,
                  arguments: note,
                );
              },
            );
          } else {
            return const Center(child: Text('No notes available.'));
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          strokeWidth: 6.0,
        ),
      ),
    );
  }
}
