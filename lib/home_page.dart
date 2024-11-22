import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'insert.dart';
// import 'update.dart';
class BookListPage extends StatefulWidget{
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  //buat variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> books = []; //buku adalah nama tabel pada database

  @override
  void initState(){
    super.initState();
    fetchBooks(); //fungsi untuk mengambil data pada tabel buku
  }
  //fungsi untuk mengambil data buku dari Supabase
  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client
    .from('books')
    .select();

    setState(() {
      books = List<Map<String, dynamic>>.from(response);
    });
  }
  //create
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Daftar Buku')
        ),
        backgroundColor: Colors.pink[50],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchBooks, //Tombol untuk refrresh
          ),
        ],
      ),
      body: books.isEmpty
          ? const Center(child: CircularProgressIndicator()) //digunakan untuk menampilkan loading indikator
          : ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index){
              final book = books [index];
              return ListTile(
                title: Text(book['title'] ?? 'No Title', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book['author'] ?? 'No Author',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                    ),
                    Text(book['description'] ?? 'No Description', 
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Tombol Edit
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Navigator.push(
                        //   // context,
                          // MaterialPageRoute(
                          //   builder: (context) => EditBookPage(book: book)
                          // ),
                        // ).then((_){
                        //   fetchBooks(); //refresh data setelah kembali dari
                        // });
                      },
                    ),
                    //Tombol Delete
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        //konfirmasi sebelum menghapus buku ALERT
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Book'),
                              content: Text('Are you sure you want to delete this book?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async{
                                    // await deleteBook(book['id']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          }
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
    );
  }

}