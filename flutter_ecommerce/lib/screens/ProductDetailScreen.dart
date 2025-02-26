import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common_widget/AppBarWidget.dart';
import 'package:flutter_ecommerce/common_widget/CircularProgress.dart';
import 'package:flutter_ecommerce/models/ProductDetails.dart';
import 'package:flutter_ecommerce/utils/Urls.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreen extends StatefulWidget {
  final String? slug;

  const ProductDetailScreen({Key? key, this.slug}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<ProductDetails>? _productDetailsFuture;

  @override
  void initState() {
    super.initState();
    if (widget.slug != null) {
      _productDetailsFuture = getDetailData(widget.slug!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfafafa),
      appBar: CustomAppBar(),
      body: _productDetailsFuture == null
          ? const Center(child: Text('No product slug provided'))
          : FutureBuilder<ProductDetails>(
              future: _productDetailsFuture,
              builder: (context, AsyncSnapshot<ProductDetails> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgress();
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No data available'));
                }
                return DetailScreen(productDetails: snapshot.data!);
              },
            ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.favorite_border,
            color: Color(0xFF5e5e5e),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFfef2f2),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Text(
                "Add to cart".toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFff665e),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFff665e),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Text(
                "available at shops".toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final ProductDetails productDetails;

  const DetailScreen({Key? key, required this.productDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(
            productDetails.data!.productVariants![0].productImages![0],
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildInfoSection(
            "SKU",
            productDetails.data!.productVariants![0].sku!,
            showArrow: true,
            valueColor: const Color(0xFFfd0100),
          ),
          const SizedBox(height: 10),
          _buildInfoSection(
            "Price",
            "৳ ${_formatPrice(productDetails.data!.productVariants![0].maxPrice)}",
            valueColor: _getPriceColor(
                productDetails.data!.productVariants![0].maxPrice),
          ),
          const SizedBox(height: 10),
          _buildDescriptionSection(),
          const SizedBox(height: 10),
          _buildSpecificationSection(),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String value,
      {Color valueColor = const Color(0xFFf67426), bool showArrow = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF565656),
            ),
          ),
          Text(
            value.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          if (showArrow)
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF999999),
            ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF565656),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            productDetails.data!.productVariants![0].productDescription!,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4c4c4c),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationSection() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Specification",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF565656),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: productDetails.data!.productSpecifications!
                .map((spec) => Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            spec.specificationName!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF444444),
                            ),
                          ),
                          Text(
                            spec.specificationValue!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF212121),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  String _formatPrice(dynamic price) {
    return price?.toString() ?? "Unavailable";
  }

  Color _getPriceColor(dynamic price) {
    return price != null ? const Color(0xFFf67426) : const Color(0xFF0dc2cd);
  }
}

Future<ProductDetails> getDetailData(String slug) async {
  final response = await http.get(Uri.parse('${Urls.ROOT_URL}$slug'));

  if (response.statusCode == 200) {
    return ProductDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load product details');
  }
}
