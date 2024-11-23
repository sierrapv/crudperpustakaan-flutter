import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crud_perpustakaan/home_page.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() =>
      _AddBookPageState(); // Karena stateful, maka harus membuat state
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>(); //id
  final TextEditingController _titleController =
      TextEditingController(); //title
  final TextEditingController _authorController =
      TextEditingController(); //author
  final TextEditingController _descriptionController =
      TextEditingController(); //deskripsi

  Future<void> _addBook(context) async {
    // Validasi form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Mengambil nilai dari controller
    final title = _titleController.text;
    final author = _authorController.text;
    final description = _descriptionController.text;

    // Kirim data ke tabel 'books' di Supabase
    final response = await Supabase.instance.client.from('books').insert({
      'title': title,
      'author': author,
      'description': description,
    });

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to add book: ${response.error!.message}')),
      );
    } else {
      // Jika sukses, tampilkan pesan dan kosongkan form
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book added successfully')));
      _titleController.clear();
      _authorController.clear();
      _descriptionController.clear();
    }
    //  Kembali ke halaman utama dan kirimkan status true
    Navigator.pop(context, true);

    // Refresh data buku
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BookListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Book')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) {
                  // Agar ketika tidak diisi muncul pesan
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _addBook(context),
                child: const Text('Add Book'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
