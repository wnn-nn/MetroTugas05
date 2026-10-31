import 'package:flutter/material.dart';

// Fungsi utama yang pertama kali dijalankan saat aplikasi Flutter dimulai
void main() {
  runApp(const MyApp());
}

// Widget utama (root) aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Menghilangkan banner debug di sudut kanan atas
      debugShowCheckedModeBanner: false,
      // Halaman awal yang ditampilkan
      home: DetailMenuPage(),
    );
  }
}

// 1. Persiapan: Mengubah DetailMenuPage menjadi StatefulWidget
class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({super.key});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  // 2. Deklarasi state di kelas State:
  // o bool isFavorite = false;
  bool isFavorite = false;

  // o int jumlahPesanan = 1;
  int jumlahPesanan = 1;

  // o String catatanPesanan = '';
  String catatanPesanan = '';

  // o Tambahkan juga final int hargaSatuan sebagai harga per porsi (bukan state)
  final int hargaSatuan = 25000;

  // FocusNode untuk mendeteksi apakah input field catatan sedang ditekan/difokuskan
  late FocusNode _catatanFocusNode;

  @override
  void initState() {
    super.initState();
    _catatanFocusNode = FocusNode();
    // Mendengarkan perubahan fokus agar tampilan diperbarui saat field ditekan
    _catatanFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Membersihkan FocusNode saat halaman ditutup
    _catatanFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. Fitur Favorit: Pasang ikon hati di AppBar
      appBar: AppBar(
        title: const Text(
          'Detail Menu',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            // Ikon dan warnanya berubah sesuai nilai isFavorite
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            // Saat ditekan, ubah isFavorite dengan setState memakai !isFavorite
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk kopi
            Image.network(
              'https://picsum.photos/600/400',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama menu dan harga satuan
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kopi Susu Gula Aren',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp 25.000',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tampilan Sesuai Gambar 3: Info Rating, Waktu, dan Kalori berdampingan horizontal
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4ECE4), // Warna krem lembut sesuai gambar 3
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Rating bintang (horizontal)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '4.9',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                        // Waktu penyajian (horizontal dengan ikon cokelat)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time_filled, color: Colors.brown, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '10 Menit',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                        // Kalori (horizontal dengan ikon api oranye)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '150 Kal',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Fitur Jumlah Pesanan: Buat tombol + dan -
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Atur Porsi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          // Tombol - (tidak boleh membuat jumlah kurang dari 1)
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              if (jumlahPesanan > 1) {
                                setState(() {
                                  jumlahPesanan--;
                                });
                              }
                            },
                          ),
                          // Angka jumlah pesanan
                          Text(
                            '$jumlahPesanan',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Tombol +
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                jumlahPesanan++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Deskripsi Menu
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Perpaduan sempurna antara biji kopi espresso pilihan dari dataran tinggi dengan susu segar full cream dan manis legitnya gula aren organik asli. Cocok menemani waktu santai maupun saat fokus ngoding seharian.',
                    style: TextStyle(color: Colors.black87, height: 1.4),
                  ),
                  const SizedBox(height: 16),

                  // 6. Catatan Pesanan Sesuai Gambar 2:
                  // Jika menekan field (sedang difokuskan), placeholder dihilangkan
                  TextField(
                    focusNode: _catatanFocusNode,
                    onChanged: (value) {
                      setState(() {
                        catatanPesanan = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.edit_note),
                      labelText: 'Catatan untuk Barista (Opsional)',
                      // Logika: Saat ditekan / fokus (_catatanFocusNode.hasFocus), placeholder menjadi null (hilang)
                      hintText: _catatanFocusNode.hasFocus ? null : 'Catatan untuk Barista (Opsional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Teks pratinjau langsung di bawah TextField
                  Text(
                    catatanPesanan.isEmpty
                        ? 'Catatan: Tidak ada catatan khusus.'
                        : 'Catatan: "$catatanPesanan"',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 5. Total Harga: Tampilkan hargaSatuan * jumlahPesanan pada tombol Pesan
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        // Aksi ketika tombol pesan ditekan
                      },
                      // Nilai total harga otomatis ikut berubah saat jumlah berubah
                      child: Text(
                        'Pesan Sekarang (Rp ${hargaSatuan * jumlahPesanan})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
