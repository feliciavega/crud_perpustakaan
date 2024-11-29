import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crud_perpustakaan/insert.dart';
// import 'update.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  //Buat variabel untuk menyimpan data buku
  List<Map<String, dynamic>> books =
      []; //books itu nama tabel di database supabase

  @override
  void initState() {
    super
      .initState(); //super.initState() digunakan untuk menginisialisasi variabel atau memanggil fungsi pada widget parent
    fetchBooks(); //Panggil fungsi untuk mengambil data buku
  }

  //Fungsi untuk mengambil data buku dari supabase
  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client.from('books').select();

    setState(() {
      books = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //Scaffold digunakan untuk membuat tampilan dasar aplikasi
        appBar: AppBar(
          title: const Text('Daftar Buku'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed:
                  fetchBooks, //Tombol untuk refresh data buku, aksi untuk mengambil data buku
            ),
          ],
        ),
        body: books.isEmpty
            ? const Center(
                child:
                  CircularProgressIndicator()) //untuk menampilkan indikator loading saat data belum tersedia
            : ListView.builder(
                //untuk membuat tampilan list secara urut
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return ListTile(
                      title: Text(book['title'] ?? 'No Title',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, //CrossAxisAlignment.start digunakan untuk mengatur posisi teks di bagian kiri
                        children: [
                          Text(
                            book['author'] ?? 'No Author',
                            style: const TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 14),
                          ),
                          Text(
                            book['description'] ?? 'No Description',
                            style: const TextStyle(fontSize: 12),
                          ), //?? digunakan untuk menampilkan teks default jika data buku kosong
                        ],
                      ),
                      trailing: Row( //trailing digunakan untuk mengatur posisi tombol/icon di bagian kanan
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Tombol edit
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              //Arahkan ke halaman EditBookPage untuk mengirim data buku yang akan diedit
                              // Navigator.push(
                                      //setelah ditekan akan masuk dibagian edit buku
                                      // context,
                                      // MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       EditBookPage(book: book),
                                      // ),
                              //         )
                              //     .then((_) {
                              //   fetchBooks(); //Refresh data buku setelah kembali dari halaman EditBookPage
                              // });
                            },
                          ),
                          //Tombol hapus
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors
                                    .red), //Tombol untuk menghapus data buku
                            onPressed: () {
                              //Konfirmasi sebelum menghapus data buku
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog( //
                                        title: const Text('Delete Book'),
                                        content: const Text(
                                            'Are you sure you want to delete this book?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                            // await deleteBook(book['id']);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                  });
                            },
                          )
                        ],
                      )
                    );
                  }
                ),
                //Fungsi untuk membuat FloatingButton
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    // Navigasi ke halaman InsertPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBookPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add), 
                  // Ikon plus untuk menambahkan buku
                    tooltip: 'Add Book',
                )
              );
  }
}