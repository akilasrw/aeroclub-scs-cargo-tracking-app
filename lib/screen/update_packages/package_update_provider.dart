

import 'package:Cargo_Tracker/screen/update_packages/package.dart';
import 'package:Cargo_Tracker/screen/update_packages/package_search.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repository/repository.dart';
import '../../domain/shared/constants.dart';
import '../../provider/base_provider.dart';

class PackageUpdateProvider extends BaseProvider {
  late Repository repository;
  List<String> packagesByStatus = List.empty();
  List<String> uldSerialNumberList = [];
  Package? package = null;

  PackageUpdateProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  initProvider() async {

  }

  Future<bool> updatePackage(Package package) async {
    try {
      setLoading(true);
      var response = await repository.updatePackageItem(package);
      if (response.status != null) {
        if (response.status == ResultStatus.AllOK.value) {
          setLoading(false);
          return Future.value(true);
        } else {
          setLoading(false);
          return Future.value(false);
        }
      }
    } catch (e) {
      print(e);
      setLoading(false);
      return Future.value(false);
    }
    setLoading(false);
    return Future.value(false);
  }

  Future<Package> getPackageItem(String awbNumber,String packageReference) async {
    try {
      setLoading(true);
      int awbNoInt = int.parse(awbNumber);
      PackageSearch packageSearch = PackageSearch(awb: awbNoInt, packageNum: packageReference);
      var response = await repository!.getPackageFromAWBAndPackageRef(packageSearch);
      if (response != null) {
        package = response;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        setLoading(false);
      }
    }
    setLoading(false);
    notifyListeners();
    return package!;
  }
}