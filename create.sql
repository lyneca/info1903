CREATE TABLE crashes (
    crashid char(13) PRIMARY KEY,
    state varchar(3),
    day integer,
    month varchar(10),
    year integer,
    hour integer,
    minute integer,
    crashtype varchar(16),
    fatalities integer,
    bus boolean,
    heavytruck boolean,
    articulatedtruck boolean,
    speedlimit integer
);

CREATE TABLE fatalities (
    crashid char(13),
    state varchar(3),
    day integer,
    month varchar(10),
    year integer,
    hour integer,
    minute integer,
    crashtype varchar(16),
    bus boolean,
    heavytruck boolean,
    articulatedtruck boolean,
    speedlimit integer,
    roaduser varchar(30),
    gender varchar(6),
    age integer
);


CREATE TABLE rainfall (
    productcode char(11),
    stationno integer,
    year integer,
    month integer,
    day integer,
    rainfall float,
    period integer,
    quality char(1)
);

-- You'll need to change these absolute paths if you want to run this code
\copy fatalities from '/path/to/fatalities.csv' with csv header;
\copy crashes from '/path/to/crashes.csv' with csv header;
\copy rainfall from '/path/to/rainfall.csv' with csv header;
