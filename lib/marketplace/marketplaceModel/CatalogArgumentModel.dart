
class CatalogArgumentModel{
  int? limit;
  int? offset;
  String? domain;
  CatalogArgumentModel({this.limit = 25, this.offset= 0, this.domain = ''});
  Map getData(){
    return {
      'limit':limit,
      'offset':offset,
      'domain':domain
    };

  }
}