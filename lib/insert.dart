import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransaksi extends StatefulWidget {
  const AddTransaksi({super.key});

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final _tanggal = TextEditingController();
  final _harga = TextEditingController();
  final _pelanggan = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> addtransaksi() async {
    if (_formKey.currentState!.validate()) {
      final tanggal = _tanggal.text;
      final harga = _harga.text;
      final pelanggan = _pelanggan.text;

      try {
        final response = await Supabase.instance.client.from('penjualan').insert([
          {
            'tanggal': tanggal,
            'harga': harga,
            'pelanggan': pelanggan
          }
        ]);
        if (response.error == null) {
          ScaffoldMessenger.of(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal'))
          );
        }
      } catch (e) {
        print('error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('salah'))
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _tanggal,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Penjualan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                   if (value == null || value.isEmpty) {
                    return 'tidak boleh kosong';
                   } 
                   return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _harga,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _pelanggan,
                  decoration: InputDecoration(
                    labelText: 'Pelanggan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return 'tidak boleh kosong';
                    }
                    return null;
                  }
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: addtransaksi, 
                  child: Text('Tambah')
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}