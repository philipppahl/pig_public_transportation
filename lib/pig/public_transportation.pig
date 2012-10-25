REGISTER /home/philipp/projects/pig_public_transportation/lib/udf/ruby/public_transportation_eval.rb using jruby as public_transportation_eval;


log = LOAD '$INPUT' USING PigStorage(';') AS (address:chararray, city:chararray, charge:chararray, no_idea:chararray, plate:chararray, lng:double, lat:double, vin:chararray, time:chararray);

filtered_log = FILTER log BY (city == 'Hamburg') ;

location = FOREACH filtered_log GENERATE
  public_transportation_eval.hour(time) AS hour,
  public_transportation_eval.round(lng, 2) AS longitude,
  public_transportation_eval.round(lat, 2) AS latitude;

grouped = GROUP location BY (hour, longitude, latitude);

result = FOREACH grouped GENERATE
  group.hour AS hour,
  group.longitude AS longitude,
  group.latitude  AS latitude,
  COUNT(location) AS num_cars;

DUMP result;