// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';

import 'package:recipe_web/src/common/components/recipe_list_component.dart';
import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/common/recipes2_app_events.dart';
import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/recipe/recipe_service.dart';

/// Display a list of the most-viewed recipes.
@Component(
  selector: 'most-viewed',
  styleUrls: const ['most_viewed_component.css'],
  templateUrl: 'most_viewed_component.html',
  directives: const [
    CORE_DIRECTIVES,
    RecipeListComponent,
  ],
  providers: const [
  ],
)
class MostViewedComponent implements OnInit {
  final Recipes2Logger _log;
  final RecipeService _recipeService;
  final RecipesAppEvents _recipeEvents;

  @Input()
  int listSize;

  List<Recipe> recipes;

  MostViewedComponent(this._log, this._recipeService, this._recipeEvents);

  ngOnInit() {
    _log.loggerName = 'MostViewedComponent';
    _log.finer('ngOnInit() listSize = $listSize');

    fetchRecipes();
    _recipeEvents.recipeStream.listen((event) => _handleRecipeAppEvents(event));
  }

  Future<Null> _handleRecipeAppEvents(var event) async {
    _log.fine('_handleRecipeAppEvents() event = $event');

    switch (event[RecipeEvents.key_event_type]) {
      case RecipeEvents.type_recipe_viewed:
        // A recipe is viewed, so refresh the viewed list
        fetchRecipes();

        break;

      case RecipeEvents.type_recipe_deleted:
        if (recipes != null && recipes.isNotEmpty) {
          var recipe = recipes.firstWhere((temp) => temp.id = event[RecipeEvents.key_recipe_id]);
          if (recipe != null) {
            // the delete recipe was in the list, so call to reload them
            fetchRecipes();
          }
        }

        break;
    }
  }

  Future<Null> fetchRecipes() async {
    recipes = await _recipeService.findMostViewed(listSize);
  }
}
