// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of recipe_web.common_model;

class HistoryItem {
  int recipeId;
  DateTime whenViewed = new DateTime.now();

  HistoryItem(this.recipeId);

  @override
  String toString() {
    return 'HistoryItem[ recipeId: $recipeId, whenViewed: $whenViewed ]';
  }

  Map toJson() {
    var jsonMap = {};
    RecipeUtil.addIntIfNotNull(jsonMap, "recipeId", recipeId);
    RecipeUtil.addDateTimeIfNotNull(jsonMap, "whenViewed", whenViewed);
    return jsonMap;
  }

  HistoryItem.fromJson(Map jsonMap) {
    if (jsonMap['recipeId']   != null) this.recipeId   = jsonMap['recipeId'];
    if (jsonMap['whenViewed'] != null) this.whenViewed = DateTime.parse(jsonMap['whenViewed']);
  }
}
