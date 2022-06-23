import 'package:kalkulator_plts/generated/json/base/json_convert_content.dart';
import 'package:kalkulator_plts/app/model/product_list_entity.dart';

ProductListEntity $ProductListEntityFromJson(Map<String, dynamic> json) {
	final ProductListEntity productListEntity = ProductListEntity();
	final List<ProductListProductList>? productList = jsonConvert.convertListNotNull<ProductListProductList>(json['product_list']);
	if (productList != null) {
		productListEntity.productList = productList;
	}
	return productListEntity;
}

Map<String, dynamic> $ProductListEntityToJson(ProductListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['product_list'] =  entity.productList?.map((v) => v.toJson()).toList();
	return data;
}

ProductListProductList $ProductListProductListFromJson(Map<String, dynamic> json) {
	final ProductListProductList productListProductList = ProductListProductList();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productListProductList.id = id;
	}
	final String? productName = jsonConvert.convert<String>(json['product_name']);
	if (productName != null) {
		productListProductList.productName = productName;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		productListProductList.type = type;
	}
	final String? merk = jsonConvert.convert<String>(json['merk']);
	if (merk != null) {
		productListProductList.merk = merk;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		productListProductList.price = price;
	}
	final String? productUrl = jsonConvert.convert<String>(json['product_url']);
	if (productUrl != null) {
		productListProductList.productUrl = productUrl;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		productListProductList.image = image;
	}
	final String? currentType = jsonConvert.convert<String>(json['current_type']);
	if (currentType != null) {
		productListProductList.currentType = currentType;
	}
	return productListProductList;
}

Map<String, dynamic> $ProductListProductListToJson(ProductListProductList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['product_name'] = entity.productName;
	data['type'] = entity.type;
	data['merk'] = entity.merk;
	data['price'] = entity.price;
	data['product_url'] = entity.productUrl;
	data['image'] = entity.image;
	data['current_type'] = entity.currentType;
	return data;
}