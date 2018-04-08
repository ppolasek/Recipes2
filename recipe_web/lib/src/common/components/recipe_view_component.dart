// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';

import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/common/recipes2_app_events.dart';
import 'package:recipe_web/src/logger/logger.dart';

@Component(
  selector: 'recipe-view',
  styleUrls: const ['recipe_view_component.css'],
  templateUrl: 'recipe_view_component.html',
  directives: const [
    CORE_DIRECTIVES,
  ],
  providers: const [
  ],
)
class RecipeViewComponent implements OnInit {
  final Recipes2Logger _log;
  final RecipesAppEvents _recipeEvents;

  @Input()
  Recipe recipe;

  RecipeViewComponent(this._log, this._recipeEvents);

  ngOnInit() {
    _log.loggerName = 'RecipeViewComponent';
  }

  void onEditClick() {
    _recipeEvents.editRecipe(recipe);
  }

  void onDeleteClick() {
    _recipeEvents.deleteRecipe(recipe.id);
  }
}
