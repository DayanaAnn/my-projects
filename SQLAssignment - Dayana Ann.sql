 /*Creating Schema*/
create schema Assignment;

 /*Initialising Schema*/
use Assignment;

/*1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)*/
 
/*Bajaj1 Table*/
update `bajaj auto` set `Date` = str_to_date(`Date`,'%d-%M-%Y');
 create table bajaj1
  as (with cte_bajaj as( select 
							Date,
							row_number() over (order by Date) RowNumber,
							`Close Price`,
							avg(`Close Price`) over (order by Date rows 19 preceding) as `20 Day MA`,
							avg(`Close Price`) over (order by Date rows 49 preceding) as `50 Day MA`
from `bajaj auto`)select Date,`Close Price`,`20 Day MA`,`50 Day MA` from cte_bajaj where RowNumber >=50);
select * from bajaj1;


/*eicher1 Table*/
update `eicher motors` set `Date` = str_to_date(`Date`,'%d-%M-%Y');
 create table eicher1
  as (with cte_eicherMotors as( select 
							Date,
							row_number() over (order by Date) RowNumber,
							`Close Price`,
							avg(`Close Price`) over (order by Date rows 19 preceding) as `20 Day MA`,
							avg(`Close Price`) over (order by Date rows 49 preceding) as `50 Day MA`
from `eicher motors`)select Date,`Close Price`,`20 Day MA`,`50 Day MA` from cte_eicherMotors where RowNumber >=50);
select * from eicher1;


/*hero1 Table*/
update `hero motocorp` set `Date` = str_to_date(`Date`,'%d-%M-%Y');
 create table hero1
  as (with cte_heroMotocorp as( select 
							Date,
							row_number() over (order by Date) RowNumber,
							`Close Price`,
							avg(`Close Price`) over (order by Date rows 19 preceding) as `20 Day MA`,
							avg(`Close Price`) over (order by Date rows 49 preceding) as `50 Day MA`
from `hero motocorp`)select Date,`Close Price`,`20 Day MA`,`50 Day MA` from cte_heroMotocorp where RowNumber >=50);
select * from hero1;


/*infosys1 Table*/
update infosys set `Date` = str_to_date(`Date`,'%d-%M-%Y');
 create table infosys1
  as (with cte_infosys as( select 
							Date,
							row_number() over (order by Date) RowNumber,
							`Close Price`,
							avg(`Close Price`) over (order by Date rows 19 preceding) as `20 Day MA`,
							avg(`Close Price`) over (order by Date rows 49 preceding) as `50 Day MA`
from infosys)select Date,`Close Price`,`20 Day MA`,`50 Day MA` from cte_infosys where RowNumber >=50);
select * from infosys1;


/*tcs1 Table*/
update tcs set `Date` = str_to_date(`Date`,'%d-%M-%Y');
 create table tcs1
  as (with cte_tcs as( select 
							Date,
							row_number() over (order by Date) RowNumber,
							`Close Price`,
							avg(`Close Price`) over (order by Date rows 19 preceding) as `20 Day MA`,
							avg(`Close Price`) over (order by Date rows 49 preceding) as `50 Day MA`
from tcs)select Date,`Close Price`,`20 Day MA`,`50 Day MA` from cte_tcs where RowNumber >=50);
select * from tcs1;


/*tvs1 Table*/
update `tvs motors` set `Date` = str_to_date(`Date`,'%d-%M-%Y');
 create table tvs1
  as (with cte_tvsmotors as( select 
							Date,
							row_number() over (order by Date) RowNumber,
							`Close Price`,
							avg(`Close Price`) over (order by Date rows 19 preceding) as `20 Day MA`,
							avg(`Close Price`) over (order by Date rows 49 preceding) as `50 Day MA`
from `tvs motors`)select Date,`Close Price`,`20 Day MA`,`50 Day MA` from cte_tvsmotors where RowNumber >=50);
select * from tvs1;


/*2.  Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)*/

create table mastertable as (select 
	b.Date,
    b.`Close Price` as Bajaj,
    tc.`Close Price` as TCS,
    tv.`Close Price` as TVS,
    i.`Close Price` as Infosys,
    e.`Close Price` as Eicher,
    h.`Close Price` as Hero
from bajaj1 b
inner join tcs1 tc
on b.Date = tc.Date
inner join tvs1 tv
on tc.Date = tv.Date
inner join infosys1 i
on tv.Date = i.Date
inner join eicher1 e
on i.Date = e.Date
inner join hero1 h
on e.Date = h.Date
order by Date);
select * from mastertable;

/* 3.Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.*/


/*Bajaj*/
create view bajaj2 as
(select Date,`Close Price`,
		(case
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) < (lag(`50 Day MA`,1) over (order by date)) then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) > (lag(`50 Day MA`,1) over (order by date)) then 'Sell'
		else 'Hold'	
        end) as `Signal`
from bajaj1 order by Date);
select * from bajaj2;


/*Eicher Motors*/
create view eicher2 as
(select Date,`Close Price`,
		(case
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) < (lag(`50 Day MA`,1) over (order by date)) then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) > (lag(`50 Day MA`,1) over (order by date)) then 'Sell'
		else 'Hold'	
        end) as `Signal`
from eicher1 order by Date);
select * from eicher2;


/*Hero Motocorp*/
create view hero2 as
(select Date,`Close Price`,
		(case
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) < (lag(`50 Day MA`,1) over (order by date)) then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) > (lag(`50 Day MA`,1) over (order by date)) then 'Sell'
		else 'Hold'	
        end) as `Signal`
from hero1 order by Date);
select * from hero2;


/*Infosys*/
create view infosys2 as
(select Date,`Close Price`,
		(case
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) < (lag(`50 Day MA`,1) over (order by date)) then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) > (lag(`50 Day MA`,1) over (order by date)) then 'Sell'
		else 'Hold'	
        end) as `Signal`
from infosys1 order by Date);
select * from infosys2;


/*TCS*/
create view tcs2 as
(select Date,`Close Price`,
		(case
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) < (lag(`50 Day MA`,1) over (order by date)) then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) > (lag(`50 Day MA`,1) over (order by date)) then 'Sell'
		else 'Hold'	
        end) as `Signal`
from tcs1 order by Date);
select * from tcs2;


/*TVS Motors*/
create view tvs2 as
(select Date,`Close Price`,
		(case
		when `20 Day MA` > `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) < (lag(`50 Day MA`,1) over (order by date)) then 'Buy'
		when `20 Day MA` < `50 Day MA` and (lag(`20 Day MA`,1) over (order by date)) > (lag(`50 Day MA`,1) over (order by date)) then 'Sell'
		else 'Hold'	
        end) as `Signal`
from tvs1 order by Date);
select * from tvs2;

/*4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.*/

/*User defined function for Bajaj*/
create function SignalStatusforBajaj(d date)
returns char(4) deterministic
return (select `Signal` from bajaj2 where date=d);
select * from bajaj2;

/*Checking the Trade Signal using USD for Bajaj*/
select SignalStatusforBajaj('2015-05-18') as tradeSignal;