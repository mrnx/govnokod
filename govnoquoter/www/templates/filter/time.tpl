Время: {$timer->getPeriod()|round:4} сек. Запросов к БД {$timer->getQueriesNum()}+{$timer->getPreparedNum()}: {$timer->getQueriesTime()|number_format:4} сек.