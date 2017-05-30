-- Where rainfall > 0
select count(crashes.crashID)
  from crashes, rainfall
 where rainfall.year = crashes.year
   and rainfall.month = extract(MONTH from to_date(concat(crashes.month, ' 2000'), 'Month YYYY'))
   and rainfall.day = crashes.day 
   and rainfall.rainfall is not null
   and rainfall.rainfall > 0
   and crashes.state = 'VIC'
;
-- Where rainfall == 0
select count(crashes.crashID)
  from crashes, rainfall
 where rainfall.year = crashes.year
   and rainfall.month = extract(MONTH from to_date(concat(crashes.month, ' 2000'), 'Month YYYY'))
   and rainfall.day = crashes.day 
   and rainfall.rainfall is not null
   and rainfall.rainfall = 0
   and crashes.state = 'VIC'
;
