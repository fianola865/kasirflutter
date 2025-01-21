import 'package:flutter/material.dart';

class ProdukDetailPage extends StatefulWidget {
  final Map<String, dynamic> produk;
  const ProdukDetailPage({Key? key, required this.produk}) : super(key: key);

  @override
  _ProdukDetailPageState createState() => _ProdukDetailPageState();
}

class _ProdukDetailPageState extends State<ProdukDetailPage> {
  int jumlahPesanan = 0;
  int totalHarga = 0;

  void updateJumlahPesanan(int harga, int delta) {
    setState(() {
      jumlahPesanan += delta;
      if (jumlahPesanan < 0) jumlahPesanan = 0; // Tidak boleh negatif

      // Update total harga
      totalHarga = jumlahPesanan * harga;
      if (totalHarga < 0) totalHarga = 0; // Tidak boleh negatif
    });
  }

  @override
  Widget build(BuildContext context) {
    final produk = widget.produk;
    final harga = produk['Harga'] ?? 0;

    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.white], // Choose your colors
            begin: Alignment.topLeft, // Start point of the gradient
            end: Alignment.bottomRight, // End point of the gradient
          ),
        ),
      child :Padding( 
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Produk: ${produk['NamaProduk'] ?? 'Tidak Tersedia'}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 16),
                Text('Harga: $harga', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Text('Stok: ${produk['Stok'] ?? 'Tidak Tersedia'}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        updateJumlahPesanan(harga, -1);
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(
                      '$jumlahPesanan',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        updateJumlahPesanan(harga, 1);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Tutup', style: TextStyle(fontSize: 20),),
                    ),
                    Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Total Harga', style: TextStyle(fontSize: 20),),
                            content: Text('Total harga pesanan: $totalHarga', style: TextStyle(fontSize: 20),),
                          ),
                        );
                      },
                      label: Text('Pesan ($totalHarga)', style: TextStyle(fontSize: 20),),
                      
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}
