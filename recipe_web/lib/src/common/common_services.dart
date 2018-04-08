// Copyright (c) 2017, ppolasek. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'package:recipe_web/src/logger/logger.dart';
import 'package:recipe_web/src/common/model.dart';

// -------------------- WebService methods -------------------- //
//
/// Base class for all webservices
///
class WebService {
  final Recipes2Logger _log;

  final BrowserClient _http;

  final Recipes2AppConfig _config;

  static final _headers = {'Content-Type': 'application/json'};

  WebService(this._log, this._http, this._config) {
    _log.loggerName = 'WebService';
  }

  Future<Object> makeTheCall(String method, Object payload) async {
//    _log.fine('makeTheCall() _config.serverUrl = ${_config.serverUrl}');
//    _log.fine('makeTheCall() _config.contextPath = ${_config.contextPath}');
//    _log.fine('makeTheCall() _config.servletPath = ${_config.servletPath}');
    var theUrl = _config.serverUrl + _config.contextPath + _config.servletPath + '/' + method;
    _log.fine('makeTheCall() theUrl = $theUrl');
    var encodedPayload = JSON.encode(payload);
    _log.finest('makeTheCall() encodedPayload = $encodedPayload');

    try {
      Response response;
      if (payload != null) {
        response = await _http.post(theUrl, headers: _headers, body: encodedPayload);
      } else {
        response = await _http.post(theUrl, headers: _headers);
      }
      _log.finest('makeTheCall() response = $response');
      _log.fine('makeTheCall() response.body = ${response.body}');
      _log.finest('makeTheCall() response.contentLength = ${response.contentLength}');
      final decoded = _extractData(response);
      return decoded;
    } catch (e, stackTrace) {
      _handleError(theUrl, encodedPayload, e, stackTrace);
      return null;
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body);
//  dynamic _extractData(Response resp) => JSON.decode(resp.body)['data'];

  _handleError(String theUrl, Object encodedPayload, Error e, StackTrace stackTrace) {
    _log.severe('_handleError() Error invoking $theUrl with $encodedPayload.\ne = $e\nstackTrace = $stackTrace', e, stackTrace);
  }
}
