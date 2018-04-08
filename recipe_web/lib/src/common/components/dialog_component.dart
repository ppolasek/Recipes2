// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/recipe/recipe_tag_component.dart';

/// Form component to enter a new recipe.
@Component(
  selector: 'my-dialog',
  styleUrls: const ['dialog_component.css'],
  templateUrl: 'dialog_component.html',
  directives: const [
    COMMON_DIRECTIVES,
    RecipeTagComponent,
  ],
  providers: const [],
)
class DialogComponent implements OnInit {
  final Recipes2Logger _log;

  @Input()
  String heading = '';

  @Input()
  String buttonLabel = '';

  @ViewChild('openButton')
  ElementRef openButton;

  @ViewChild('closeButton')
  ElementRef closeButton;

  DialogComponent(this._log) {
    _log.loggerName = 'DialogComponent';
  }

  ngOnInit() {
    _log.fine('ngOnInit()');
    _log.finest('ngOnInit() heading = $heading');
    _log.finest('ngOnInit() buttonLabel = $buttonLabel');
  }

  void open() {
    openButton.nativeElement.click();
  }

  void close() {
    closeButton.nativeElement.click();
  }
}
