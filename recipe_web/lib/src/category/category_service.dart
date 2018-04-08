// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:http/browser_client.dart';

import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/common/common_services.dart';

/// CategoryService interface definition
///
class CategoryService extends WebService {

  CategoryService(Recipes2Logger logger, BrowserClient http, Recipes2AppConfig config) : super(logger, http, config) {}

  Future<List<Category>> getAllCategories() => new Future(() => null);
}

/// CategoryService implementation
///
@Injectable()
class WebCategoryService extends CategoryService {
  final Recipes2Logger _log;

  WebCategoryService(this._log, BrowserClient http, Recipes2AppConfig config) : super(_log, http, config) {
    _log.loggerName = 'WebCategoryService';
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final response = await makeTheCall('getAllCategories', null);
    _log.fine('getAllCategories() response = $response');

    List<Category> returnList = Category.fromList(response);
    _log.fine('getAllCategories() returnList = $returnList');
    return returnList;
  }
}
