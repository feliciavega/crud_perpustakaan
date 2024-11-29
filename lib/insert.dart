import 'package:crud_perpustakaan/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({super.key});

  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future _addBook(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _titleController.text;
    final author = _authorController.text;
    final description = _descriptionController.text;
    final response = await Supabase.instance.client.from('books').insert({
      'title': title,
      'author': author,
      'description': description,
      //'book_images': imageUrl, //menyimpan gambar url pada database
    });

    if (response != null) {
      //Jika ada error tampilkan pesan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response}')),
      );
    } else {
      //Jika success tampilkan pesan dan kosongkan form
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The Book Added Successfully")), 
      );
      _titleController.clear();
      _authorController.clear();
      _descriptionController.clear();
    }
    //mengembalikan ke halaman utama dan kirimkan status true
    Navigator.pop(context, true);
    //refresh data buku
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BookListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Book"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Gunakan _formKey untuk validasi
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title'; //validator untuk ketika tidak diisi muncul pesan 
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Center(
                //kalau ditekan dia akan kefungsi add book
                child: ElevatedButton(
                  onPressed: () => _addBook(context),
                  child: const Text('Add Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}