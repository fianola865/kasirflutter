import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class addTransaksi extends StatefulWidget {
  const addTransaksi({super.key});

  @override
  State<addTransaksi> createState() => _addTransaksiState();
}

class _addTransaksiState extends State<addTransaksi> {
  final _tgl = TextEditingController();
  final _hrg = TextEditingController();
  final _penjualan = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> transaksi() async {
    if(_formKey.currentState!.validate()) {
      final TanggalPenjualan = _tgl.text;
      final TotalHarga = _hrg.text;
      final Penjualanid = _penjualan;

      try{
        final response = await Supabase.instance.client.from('penjualan').insert([
          {
            'TanggalPenjualan': TanggalPenjualan,
            'TotalHarga': TotalHarga,
            'Penjualanid': Penjualanid,
          }
        ]);

        if (response.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('berhasil ditambahkan')),
          );
        }
      }
    } 
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

