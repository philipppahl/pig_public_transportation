REGISTER $JRUBY/public_transportation_eval.rb using jruby as public_transportation_eval;


log = LOAD '$INPUT' USING PigStorage(';') AS (address:chararray, city:chararray, charge:chararray, no_idea:chararray, plate:chararray, lng:double, lat:double, vin:chararray, time:long);

-- filtered_log = FILTER log BY (city == 'Hamburg') ;

plates = FOREACH log GENERATE
  plate,
  time;

g = GROUP plates BY (plate);

results = FOREACH g GENERATE
  group AS plate,
  public_transportation_eval.rides(plates.time) AS rides;
  
  
counts = FOREACH results GENERATE
  plate,
  (SUM(rides.duration)) AS win,
  COUNT(rides) AS count;

counts = FOREACH counts GENERATE plate, win / 60 * 0.29 AS win, count;

ordered = ORDER counts BY count;

-- DUMP ordered;

group_all = GROUP counts ALL;

total = FOREACH group_all GENERATE
  SUM(counts.win);

DUMP total;

