// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:http/browser_client.dart';

import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/common/common_services.dart';

/// HistoryService interface definition
///
class HistoryService extends WebService {

  HistoryService(Recipes2Logger logger, BrowserClient http, Recipes2AppConfig config) : super(logger, http, config);

  Future<List<HistoryItem>> getAllHistory() => new Future(() => null);
  Future<Null> recipeViewed(int recipeId) => new Future(() => null);
  Future<Null> deleteHistory(int historyId) => new Future(() => null);
}

/// HistoryService implementation
///
@Injectable()
class WebHistoryService extends HistoryService {
  final Recipes2Logger _log;

  WebHistoryService(this._log, BrowserClient http, Recipes2AppConfig config) : super(_log, http, config) {
    _log.loggerName = 'WebHistoryService';
  }

  // TODO need an implementation
  @override
  Future<List<HistoryItem>> getAllHistory() => new Future(() => []);

  @override
  Future<Null> recipeViewed(int recipeId) => new Future(() => null);

  @override
  Future<Null> deleteHistory(int recipeId) => new Future(() => null);
}
