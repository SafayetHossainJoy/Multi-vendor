
//============================Map Keys==============================//

const stateKey = "state";
const operatorKey = "operator";
const limitKey = "limit";
const offsetKey = "offset";
const sellerIdKey = "domain";
const categoryKey = "categoryName";
const fromMarketplaceKey = "fromMarketplace";
const sellerNameKey = "sellerName";
const titleKey = "titleKey";
const policyKey = "policyKey";

//===============================================================//


Map<String, String> sellerProductDataMap(String state, String operator){
  Map<String, String> args = {};
  args[stateKey] = state;
  if(state != '') {
    args[operatorKey] = operator;
  }
  return args;
}

Map<String, dynamic> catalogDataMap(int limit, int offset, int sellerId,String categoryName,{bool fromMarketplace = true, }){
  Map<String, dynamic> args = {};
  args[limitKey] = limit;
  args[offsetKey] = offset;
  args[sellerIdKey] = "[('marketplace_seller_id','=',$sellerId)]";
  args[fromMarketplaceKey] = fromMarketplace;
  args[categoryKey] = categoryName;
  return args;
}

Map<String, dynamic> sellerDetails(int sellerId, String sellerName){
  Map<String, dynamic> args = {};
  args[sellerNameKey] = sellerName;
  args[sellerIdKey] = sellerId;
  return args;
}

Map<String, dynamic> sellerPolicy(String title, String policy){
  Map<String, dynamic> args = {};
  args[titleKey] = title;
  args[policyKey] = policy;
  return args;
}