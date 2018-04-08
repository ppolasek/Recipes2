// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';

import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/category/category_service.dart';

@Component(
  selector: 'category-list',
  styleUrls: const ['category_list_component.css'],
  templateUrl: 'category_list_component.html',
  directives: const [COMMON_DIRECTIVES],
  providers: const [CategoryService]
)
class CategoryListComponent implements OnInit {
  final Recipes2Logger _log;

  List<Category> categories;

  final CategoryService _categoryService;

  CategoryListComponent(this._log, this._categoryService) {
    _log.loggerName = 'CategoryListComponent';
  }

  Future<Null> ngOnInit() async {
    _log.fine('ngOnInit()');
    _log.fine('ngOnInit() _categoryService is CategoryService: ${_categoryService is CategoryService}');
    _log.fine('ngOnInit() _categoryService is WebCategoryService: ${_categoryService is WebCategoryService}');
    await _categoryService.getAllCategories()
        .then((list) => categories = list);
  }
}