import 'package:floor/floor.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/entities/recent_product.dart';

@dao
abstract class RecentProductDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecentProduct(RecentProduct product);

  @Query("SELECT * FROM RecentProduct LIMIT 10 ")
  Future<List<RecentProduct>> getProducts();
}
