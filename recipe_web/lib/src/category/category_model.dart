// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of recipe_web.common_model;

class Category extends DomainCommon {

  String title;
  String caption;
  String assetName;

  String get tagName => assetName; // Assuming that all asset names are unique.

  bool get isValid => assetName != null && title != null && caption != null;

  Category({ this.assetName, this.title, this.caption });

  @override
  String toString() {
    return 'Category[ '
        'id: $id, '
        'version: $version, '
        'title: $title, '
        'caption: $caption, '
        'assetName: $assetName, '
        'isValid: $isValid'
        ' ]';
  }

  Map toJson() {
    var jsonMap = {};
    RecipeUtil.addIfNotNull(jsonMap, "title",      title);
    RecipeUtil.addIfNotNull(jsonMap, "caption",    caption);
    RecipeUtil.addIfNotNull(jsonMap, "assetName",  assetName);

    RecipeUtil.addIntIfNotNull(jsonMap, "id", id);
    RecipeUtil.addIntIfNotNull(jsonMap, "version", version);
    return jsonMap;
  }

  Category.fromJson(Map jsonMap)
  {
    if (jsonMap['id'] != null)      this.id      = jsonMap['id'];
    if (jsonMap['version'] != null) this.version = jsonMap['version'];
    if (jsonMap['title'] != null)      this.title = jsonMap['title'];
    if (jsonMap['caption'] != null)    this.caption = jsonMap['caption'];
    if (jsonMap['assetName'] != null)  this.assetName = jsonMap['assetName'];
  }

  static List<Category> fromList(List<Map> jsonList) {
    var returnList = <Category>[];
    if (jsonList is List) {
      jsonList.forEach((map) => returnList.add(new Category.fromJson(map)));
    }

    return returnList;
  }
}
