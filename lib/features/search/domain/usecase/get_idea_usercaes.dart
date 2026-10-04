// ignore_for_file: avoid_renaming_method_parameters

import 'package:injectable/injectable.dart';
import '../../../../data/data_sources/remotes/search_service.dart';
import '../../../../data/models/search/popular_search_model.dart';

import '../../../../app/base/usecase/base_use_case.dart';

@Injectable()
class GetpopularSearchUseCase
    extends BaseUseCase<void, List<PopularSearchModel>> {
  final SearchService _searchService;
  GetpopularSearchUseCase(this._searchService);
  @override
  Future<List<PopularSearchModel>> excecute(void i) async {
    return await _searchService.getpopularSearch();
  }
}
