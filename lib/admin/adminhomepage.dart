import 'package:flutter/material.dart';
import 'package:kasir/admin/detail/indeksjual.dart';
import 'package:kasir/admin/pelanggan/indexpelanggan.dart';
import 'package:kasir/admin/penjualan/indexpenjualan.dart';
import 'package:kasir/admin/produk/indexproduk.dart';
import 'package:kasir/admin/regristrasi/indexuser.dart';
import 'package:kasir/admin/adminhomepage.dart';
import 'package:kasir/loginpage.dart';


class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.drafts, color: Colors.pink.shade200), text: 'Detail Penjualan'),
              Tab(icon: Icon(Icons.inventory, color: Colors.pink.shade200), text: 'Produk'),
              Tab(icon: Icon(Icons.people, color: Colors.pink.shade200), text: 'Customer'),
              Tab(icon: Icon(Icons.money, color: Colors.pink.shade200), text: 'Penjualan'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  child: ListTile(
                    leading: Icon(Icons.arrow_back),
                    title: Text(
                      'Pengaturan dan Aktivitas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminHomePage()),
                      );
                    },
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Register'),
                onTap: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => UserTab())
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.bar_chart),
                title: Text('Laporan'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Pengaturan'),
              ),
              ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DetailPenjualanTab(),
            ProdukTab(),
            PelangganTab(),
            PenjualanTab(),
          ],
        ),
      ),
    );
  }
}

