/* Copyright 2017 Philip Polasek. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */
package com.sandbox.recipe.repository;

import com.sandbox.recipe.domain.LogRecord;
import org.springframework.data.repository.CrudRepository;

/**
 * --- TODO: Class comments go here ---
 *
 * <b><pre>
 * Copyright 2017 Philip Polasek.
 * All rights reserved.
 * </pre></b>
 *
 * @author ppolasek
 */
public interface LoggerRepository extends CrudRepository<LogRecord, Long>  {
        // This will be AUTO IMPLEMENTED by Spring into a Bean called logRecordRepository
        // CRUD refers Create, Read, Update, Delete
}
