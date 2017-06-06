copy ( select crashes.crashID,
       crashes.year,
       -- Convert month names (January, Feburary etc) into month numbers (1, 2 etc)
       extract(MONTH from to_date(concat(crashes.month, ' 2000'), 'Month YYYY')) as month,
       crashes.day,
       crashes.fatalities,
       rainfall.rainfall
  from crashes, rainfall
 where rainfall.year = crashes.year
   and rainfall.month = extract(MONTH from to_date(concat(crashes.month, ' 2000'), 'Month YYYY'))
   and rainfall.day = crashes.day 
   and rainfall.rainfall is not null
 order by rainfall.rainfall desc
) to '/home/lyneca/cleaned.csv' (format csv);
