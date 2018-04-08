// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/platform/browser.dart';
import 'package:angular2/angular2.dart';
import 'package:http/browser_client.dart';
import 'package:logging/logging.dart';

import 'package:recipe_web/recipes2_app_component.dart';
import 'package:recipe_web/src/common/model.dart';

void main() {
  print('main.main()');

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.time} ${rec.level.name} ${rec.loggerName} ${rec.message}');
  });

//  const serverUrl = 'http://localhost:9191';
//  const contextPath = '/Recipes2';
//  const servletPath = '/services';

  bootstrap(Recipes2AppComponent, [
    provide(BrowserClient, useFactory: () => new BrowserClient(), deps: []),
    provide(Recipes2AppConfig,
        useFactory: () => new Recipes2AppConfig('http://localhost:9191',
            '/Recipes2',
            '/services'),
        deps: [])
  ]);
}
