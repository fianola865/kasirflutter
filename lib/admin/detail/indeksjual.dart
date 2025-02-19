import 'package:flutter/material.dart';
import 'package:kasir/admin/adminhomepage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailPenjualanTab extends StatefulWidget {
  const DetailPenjualanTab({super.key});

  @override
  State<DetailPenjualanTab> createState() => _DetailPenjualanTabState();
}

class _DetailPenjualanTabState extends State<DetailPenjualanTab> {
  List<Map<String, dynamic>> detaill = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Supabase.instance.client.from('detailpenjualan').select('*, penjualan(*, pelanggan(*)), produk(*)');
      setState(() {
        detaill = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.twoRotatingArc(
                color: Colors.grey,
                size: 30,
              ),
            )
          : detaill.isEmpty
              ? Center(
                  child: Text(
                    'Detail penjualan tidak ada',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: detaill.length,
                  itemBuilder: (context, index) {
                    final detail = detaill[index];

                    final int Subtotal = (detail['Subtotal'] is int)
                        ? detail['Subtotal']
                        : int.tryParse(detail['Subtotal'].toString()) ?? 0;

                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Pelanggan: ${detail['penjualan']['pelanggan']['NamaPelanggan']?.toString() ?? 'Tidak tersedia'}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Nama Produk: ${detail['produk']['NamaProduk']?.toString() ?? 'Tidak tersedia'}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Jumlah Produk: ${detail['JumlahProduk']?.toString() ?? 'Tidak tersedia'}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Subtotal: ${detail['Subtotal']?.toString() ?? 'Tidak tersedia'}',
                              style: TextStyle(fontSize: 16),
                            ),
                            
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
