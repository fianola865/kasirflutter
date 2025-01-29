import 'package:flutter/material.dart';
import 'package:kasir/admin/adminhomepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Updateproduk extends StatefulWidget {
  final int Produkid;
  const Updateproduk({super.key, required this.Produkid});

  @override
  State<Updateproduk> createState() => _UpdateprodukState();
}

class _UpdateprodukState extends State<Updateproduk> {
  final _nmprd = TextEditingController();
  final _harga = TextEditingController();
  final _stok = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _updateproduk();
  }
  Future<void> _updateproduk() async {
    try{
      final data = await Supabase.instance.client.from('produk').select().eq('Produkid', widget.Produkid).single();
      setState(() {
        _nmprd.text = data['NamaProduk'] ?? '';
        _harga.text = data['Harga']?.toString() ?? '';
        _stok.text = data['Stok']?.toString() ?? '';
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error : $error')),
      );
    }
  }

  Future<void> updateproduk() async {
    if (_formKey.currentState!.validate()) {
      await Supabase.instance.client.from('produk').update({
        'NamaProduk': _nmprd.text,
        'Harga': _harga.text,
        'Stok': _stok.text
      }).eq('Produkid', widget.Produkid);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AdminHomePage()),
      (route) => false
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Produk'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nmprd,
                decoration: InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder()
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "tidak boleh kosong";
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
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _stok,
                decoration: InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: updateproduk, child: Text('update'))
            ],
          )
        ),
      ),
    );
  }
}