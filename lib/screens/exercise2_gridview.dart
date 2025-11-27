import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});
  // Tạo danh sách 12 item
  final List<Widget> galleryItems = const [
    GalleryItem(icon: Icons.photo_camera, color: Colors.red),
    GalleryItem(icon: Icons.photo_album, color: Colors.blue),
    GalleryItem(icon: Icons.image, color: Colors.green),
    GalleryItem(icon: Icons.landscape, color: Colors.orange),
    GalleryItem(icon: Icons.portrait, color: Colors.purple),
    GalleryItem(icon: Icons.collections, color: Colors.cyan),
    GalleryItem(icon: Icons.photo_filter, color: Colors.amber),
    GalleryItem(icon: Icons.camera_roll, color: Colors.indigo),
    GalleryItem(icon: Icons.style, color: Colors.lime),
    GalleryItem(icon: Icons.filter_vintage, color: Colors.pink),
    GalleryItem(icon: Icons.broken_image, color: Colors.brown),
    GalleryItem(icon: Icons.add_a_photo, color: Colors.grey),
  ];
  @override //Trên top hiển thị nội dung của bài 2
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bài 2: Gallery GridView'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'GridView.count()', icon: Icon(Icons.grid_view)),
              Tab(text: 'GridView.extent()', icon: Icon(Icons.view_quilt)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: GridView.count
            GridView.count(
              crossAxisCount: 3, // 3 cột
              padding: const EdgeInsets.all(8.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: galleryItems,
            ),
            // Tab 2: GridView.extent
            GridView.extent(
              maxCrossAxisExtent: 150.0, // Chiều rộng tối đa mỗi item
              padding: const EdgeInsets.all(8.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: galleryItems,
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  //Khai báo class hiển thị item trong gallery
  final IconData icon;
  final Color color;
  const GalleryItem({
    super.key,
    required this.icon,
    required this.color,
  }); //Khởi tạo constructor
  @override //Mô tả cách widget được vẽ lên màn hình
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: color,
      child: InkWell(
        onTap: () {},
        child: Center(child: Icon(icon, size: 50.0, color: Colors.white)),
      ),
    );
  }
}
