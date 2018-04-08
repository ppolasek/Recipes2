// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';

import 'package:recipe_web/src/common/components/dialog_component.dart';
import 'package:recipe_web/src/common/components/recipe_view_component.dart';
import 'package:recipe_web/src/common/components/selector_directive.dart';
import 'package:recipe_web/src/common/model.dart';
import 'package:recipe_web/src/common/recipes2_app_events.dart';
import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/logger/logger_service.dart';
import 'package:recipe_web/src/category/category_service.dart';
import 'package:recipe_web/src/category/category_list_component.dart';
import 'package:recipe_web/src/cookbook/cookbook_service.dart';
import 'package:recipe_web/src/history/history_service.dart';
import 'package:recipe_web/src/recipe/added_recently_component.dart';
import 'package:recipe_web/src/recipe/default_view_component.dart';
import 'package:recipe_web/src/recipe/most_viewed_component.dart';
import 'package:recipe_web/src/recipe/recipe_form_component.dart';
import 'package:recipe_web/src/recipe/recipe_service.dart';
import 'package:recipe_web/src/recipe/recipe_tag_component.dart';
import 'package:recipe_web/src/recipe/search_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'recipes-app',
  styleUrls: const ['recipes2_app_component.css'],
  templateUrl: 'recipes2_app_component.html',
  directives: const [
    CORE_DIRECTIVES,
    CategoryListComponent,
    RecipeFormComponent,
    RecipeTagComponent,
    RecipeViewComponent,
    AddedRecentlyComponent,
    MostViewedComponent,
    RecipeSearchComponent,
    DefaultViewComponent,
    DialogComponent,
  ],
  providers: const [const Provider(CategoryService, useClass: WebCategoryService),
                    const Provider(CookbookService, useClass: WebCookbookService),
                    const Provider(HistoryService, useClass: WebHistoryService),
                    const Provider(RecipeService, useClass: WebRecipeService),
                    const Provider(LoggerService, useClass: WebLoggerService),
                    const Provider(Recipes2Logger, useClass: Recipes2Logger),
                    const Provider(RecipesAppEvents, useClass: RecipesAppEvents),
                    const Provider(SelectorDirective, useClass: SelectorDirective),
                   ],
)
class Recipes2AppComponent implements OnInit {

  RecipeTag sampleTag = new RecipeTag.fromValues('Mexican');

  @ViewChild('addRecipeDialog')
  DialogComponent addRecipeDialogComp;

//  @ViewChild('editRecipeDialog')
//  DialogComponent editRecipeDialogComp;

  Recipe recipe;
  Recipe viewableRecipe;
  bool editRecipe = false;
  String get recipeDialogTitle => editRecipe ? 'Edit Recipe' : 'New Recipe';
  bool showSearch = true;
  bool showDefaultView = false;

  final Recipes2Logger _log;
  final RecipesAppEvents _recipeEvents;
  final RecipeService _recipeService;

  Recipes2AppComponent(this._log, this._recipeEvents, this._recipeService) {
    _log.loggerName = 'Recipes2AppComponent';
  }

  ngOnInit() {
    _log.fine('ngOnInit()');
    _recipeEvents.recipeStream.listen((event) => _handleRecipeAppEvents(event));
  }

  void onAddClick() {
    recipe = new Recipe();
    editRecipe = false;
    _openRecipeFormDialog();
  }

  void onSearchClick() {
    viewableRecipe = null;
    showSearch = true;
    showDefaultView = false;
  }
//
//  void onEditRecipeClick() {
//    recipe = new Recipe();
//    _openEditRecipeDialog();
//  }

  void onFormEvent(var event) {
    _log.fine('onFormEvent() event = $event');

    _closeRecipeFormDialog();
  }

  void _openRecipeFormDialog() {
    addRecipeDialogComp.open();
  }
//
//  void _openEditRecipeDialog() {
//    editRecipeDialogComp.open();
//  }

  void _closeRecipeFormDialog() {
    addRecipeDialogComp.close();
  }
//
//  void _closeEditRecipeDialog() {
//    editRecipeDialogComp.close();
//  }

  void onRecipeSelected(event) {
    _log.fine('onRecipeSelected() event = $event');
  }

  Future<Null> _handleRecipeAppEvents(var event) async {
    _log.fine('_handleRecipeAppEvents() event = $event');

    switch (event[RecipeEvents.key_event_type]) {
      case RecipeEvents.type_hover_recipe:
        // this is just hovering over a recipe, which does not update the viewing history
        if (event[RecipeEvents.key_recipe_id] != null && event[RecipeEvents.key_recipe_id] > 0) {
          _recipeService.getRecipe(event[RecipeEvents.key_recipe_id])
              .then((updatedRecipe) => viewableRecipe = updatedRecipe);
        }

        break;

      case RecipeEvents.type_view_recipe:
        // this is clicking on a recipe, which updates the viewing history
        if (event[RecipeEvents.key_recipe_id] != null && event[RecipeEvents.key_recipe_id] > 0) {
          _recipeService.getRecipeWithHistory(event[RecipeEvents.key_recipe_id])
              .then((updatedRecipe) {
            viewableRecipe = updatedRecipe;
            _recipeEvents.recipeViewed(event[RecipeEvents.key_recipe_id]);
          });

        }

        break;

      case RecipeEvents.type_edit_recipe:
        recipe = event[RecipeEvents.key_recipe];
        editRecipe = true;
        _openRecipeFormDialog();

        break;

      case RecipeEvents.type_delete_recipe:
        _recipeService.deleteRecipe(event[RecipeEvents.key_recipe_id])
            .then((success) {
          if (success) _recipeEvents.recipeDeleted(event[RecipeEvents.key_recipe_id]);
        });

        break;

      case RecipeEvents.type_recipe_added:
        _closeRecipeFormDialog();

        // after adding a recipe automatically display it
        _recipeService.getRecipe(event[RecipeEvents.key_recipe_id])
            .then((updatedRecipe) => viewableRecipe = updatedRecipe);

        break;

      case RecipeEvents.type_recipe_updated:
        _closeRecipeFormDialog();
        if (viewableRecipe != null && viewableRecipe.id == event[RecipeEvents.key_recipe_id]) {
          // the recipe being viewed was updated, so need to update it
          _recipeService.getRecipe(event[RecipeEvents.key_recipe_id])
              .then((updatedRecipe) => viewableRecipe = updatedRecipe);
        }

        break;

      case RecipeEvents.type_recipe_deleted:
        if (viewableRecipe != null && viewableRecipe.id == event[RecipeEvents.key_recipe_id]) {
          // the recipe being viewed was deleted, so need to null it out to clear the screen
          viewableRecipe = null;
        }

        break;

      case RecipeEvents.type_close_search:
        showSearch = false;

        if (viewableRecipe == null) {
          showDefaultView = true;
        }

        break;
    }
  }
}
