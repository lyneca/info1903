# INFO1903 Project
## Section I: Data analysis
### Domain Situation
For this project, I wanted to analyse state rainfall data
alongside road fatalities, with the primary aim of finding
a correlation between the two.

### Data Sources
#### Online Sources
- [The Australian Road Deaths Database](http://data.gov.au/dataset/australian-road-deaths-database/resource/ca07c8e3-672f-4826-a6e5-83fd7127ae0b)) which contains information about the crashes and the fatalities.
- [The Bureau of Meteorology's Daily Rainfall Data](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_nccObsCode=136&p_display_type=dailyDataFile&p_startYear=&p_c=&p_stn_num=086039) for the station of Flemington in Victoria.

#### Download Links:
- [Crash database](https://bitre.gov.au/statistics/safety/files/Fatal_Crashes_Feb2017.csv) (csv)
- [Crash database legend](https://bitre.gov.au/statistics/safety/files/ARDD_Dictionary_V3.pdf) (pdf)
- [Rain database](http://www.bom.gov.au/jsp/ncc/cdio/weatherData/av?p_display_type=dailyZippedDataFile&p_stn_num=086039&p_c=-1480557288&p_nccObsCode=136&p_startYear=2017) (csv)

### Analysis

After setting up the data, I first graphed the rainfall over time and the crashes over time to see if I could spot any trends among the separate graphs:

#### Car Crashes per Month
[![Graph of car crashes in Victoria over time][graph1]][graph1]

---
This graph shows that the average number of fatal car crashes per month has
decreased since 1989, something which I expected to see.

The spike at the start is because of the Kempsey Bus Crash, cited as the most
deadly road accident in Australia's history.
([Wikipedia Article](https://en.wikipedia.org/wiki/Kempsey_bus_crash))

#### Monthly Rainfall
[![Graph of rainfall in Victoria over time][graph2]][graph2]

---
There is an outlier around 2005, a heavy rain event.
([BOM report](https://bom.gov.au/climate/annual_sum/2005/page13-15.pdf))

#### Crashes and Rainfall over Time

After having graphed the data separately, I graphed them on top of each other to get a better idea at a correlation:

[![Graph of car crashes and rainfall in Victoria over time][graph3]][graph3]

---
This final graph is the same data but in a different style: the data points are the
fatalities per month, but the rainfall is instead represented as the colour of the points.

I thought that this would help visualise the correlation, but it doesn't really work.

[![Graph of car crashes in Victoria over time with rainfall colourmap][graph4]][graph4]


***TODO***: actually do some analysis

[graph1]: assets/crashes_over_time.png
[graph2]: assets/rainfall_over_time.png
[graph3]: assets/rainfall_vs_deaths.png
[graph4]: assets/fatalities_vs_date.png

## Section II: Data Generation
### Getting the data
The website had two datasets available: one for each crash, and one for each fatality.
I chose to use the one per crash, as I was not interested in statistics such as gender
or age. However, the process required to obtain and store this data is available with the
methods for the other files.

---
Due to the nature of the weather, I decided that getting the "total national rainfall"
was not precise enough. Because the crash data sorted by state (and did not give a
precise location), I decided to pick a state and use only crash data from that state.

The BOM data provides rainfall data for every weather station back to the 19th century.
As my crash data location had state-level precision, I reasoned that if I chose a weather
station in the middle of a state, it would give me the best approximate for "average
statewide weather".

I chose Victoria, as it is a small state with a weather station (Flemington station)
somewhat near both the center of the state and the capital city, where I reasoned the
most crashes would occur.

### Storing in PostgreSQL
#### Database Schema
##### `crashes`

| Column | Type | Description |
| --- | --- | --- |
| `crashid` | `character(13)` | Internal crash ID |
| `state` | `character varying(3)` | State that the crash occured in |
| `day` | `integer` | Day of the crash |
| `month` | `character varying(10)` | Month of the crash (long name format) |
| `year` | `integer` | Year of the crash |
| `hour` | `integer` | Hour of the crash |
| `minute` | `integer` | Minute of the crash |
| `crashtype` | `character` varying(16) | Internal type of the crash |
| `fatalities` | `integer` | Number of fatalities |
| `bus` | `boolean` | Was a bus involved? |
| `heavytruck` | `boolean` | Was a heavy truck involved? |
| `articulatedtruck` | `boolean` | Was an articulated truck involved? |
| `speedlimit` | `integer` | The speed limit of the crash |

##### `rainfall`

| Column | Type | Description |
| --- | --- | --- |
| `year` | `integer` | Year of the measurement |
| `month` | `integer` | Month of the measurement (in integer form) |
| `day` | `integer` | Day of the measurement |
| `rainfall` | `double precision` | Amount of rainfall |
| `period` | `integer` | Period measured |
| `quality` | `character(1)` | Quality of data |

#### Issues
##### Date Formatting
Looking at the above schema, you might notice: the `month` field of the rainfall table is
an `integer` type, but `crashes.month` is a `varchar(10)`. `crashes.month` is a long month
name, e.g. `January`, `February`.

This was a problem. I had two different formats of data that were needed to do an
SQL JOIN. Luckily, PostgreSQL has a very good set of date formatting commands.

I decided to leave the tables as they were, and convert the data on the fly when doing the
SQL JOIN. The following SQL functions will convert a date in long format to an integer:
```postgres
extract(MONTH from to_date(concat(crashes.month, ' 2000'), 'Month YYYY'))
```

### Querying
#### Issues
### Graphing
#### Issues
### Notebook
[Here](https://nbviewer.jupyter.org/github/lyneca/info1903/blob/gh-pages/INFO1903.ipynb)
is the Jupyter Notebook that contains code for querying and visualising the data.
