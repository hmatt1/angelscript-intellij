class ProductCoins : Purchase, ProductInfo, Purcheseable, PurchaseUpdate, ProductUILinkImpl {
	uint count;
	string _token;
	ProductCoins(uint c) {
		count = c;
		_sku = "coins" + c;
	}
}
mixin class Purchase {
	string _sku;
	bool purchased = false;
	bool _isSubs = false;
	PurchaseData@ info;
}
interface ProductInfo {
}
interface Purcheseable {
}
interface PurchaseUpdate {
}
mixin class ProductUILinkImpl : ProductUILink {
	ProductItem@ _pi;
}
interface ProductUILink {
}
class PurchaseData {}
class ProductItem {}
ProductCoins coins(100);
