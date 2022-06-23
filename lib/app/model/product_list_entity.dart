import 'dart:convert';
import 'package:kalkulator_plts/generated/json/base/json_field.dart';
import 'package:kalkulator_plts/generated/json/product_list_entity.g.dart';

@JsonSerializable()
class ProductListEntity {

	@JSONField(name: "product_list")
	List<ProductListProductList>? productList;
  
  ProductListEntity();

  factory ProductListEntity.fromJson(Map<String, dynamic> json) => $ProductListEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductListProductList {

	int? id;
	@JSONField(name: "product_name")
	String? productName;
	String? type;
	String? merk;
	String? price;
	@JSONField(name: "product_url")
	String? productUrl;
	String? image;
	@JSONField(name: "current_type")
	String? currentType;
  
  ProductListProductList();

  factory ProductListProductList.fromJson(Map<String, dynamic> json) => $ProductListProductListFromJson(json);

  Map<String, dynamic> toJson() => $ProductListProductListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}