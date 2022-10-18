use dataset;

-- count number of rows into our dataset
      SELECT 
    COUNT(*)
FROM
    dataset1;

-- select all data
	select * from dataset1;

-- sel specific row
     select * 
     from dataset1
	 where state in ('jharkhand' , 'bihar');


-- to  the total number of a row     
      select sum(sex_ratio) from dataset1 ;  


-- to  the total averge data(if the number is percentage than 100 should be multiply
	select avg(growth)*100 as avg_growth from dataset1  ;


-- to  the averge of ecah individual state
      SELECT 
           state, AVG(growth) * 100 AS avg_growth
        FROM
          dataset1
      GROUP BY state;

     
-- average sex ration in round figure + big number to low number (by doing desc)
          SELECT 
               district, ROUND(AVG(sex_ratio), 0) AS sex_avg_gowth
          FROM
               dataset1
          GROUP BY district
          ORDER BY sex_avg_gowth DESC;



-- find the litercy avrg rate which is greater than 90

            SELECT 
                 state, ROUND(AVG(literacy), 0) AS literacy_avg
			FROM
				dataset1
			GROUP BY state
			HAVING ROUND(AVG(literacy), 0)>90
			ORDER BY literacy_avg DESC ;
            
-- top 3 state showing highest growth ratio            
			SELECT state, AVG(growth) * 100 AS avg_growth
			FROM dataset1
			GROUP BY state
			order by avg_growth desc limit 3 ;
            

-- Bottom 3 state showing lowest sex ration
       SELECT 
               state, ROUND(AVG(sex_ratio), 0) AS sex_avg_gowth
          FROM
               dataset1
          GROUP BY state
          ORDER BY sex_avg_gowth asc limit 3 ;



-- top and bottom 3 states in literacy state in seperate table          
drop table if exists topstates;          
CREATE TABLE topstates
( state nvarchar(255),
  topstate float

  );
  
insert into topstates 
select state,round(avg(literacy),0) avg_literacy_ratio from dataset1 
group by state order by avg_literacy_ratio desc;  
select * from topstates order by topstates.topstate desc limit 3;



drop table if exists bottomstates;
create table bottomstates
( state nvarchar(255),
  bottomstate float

  );

insert into bottomstates
select state,round(avg(literacy),0) avg_literacy_ratio from dataset1 
group by state order by avg_literacy_ratio asc;

select * from bottomstates order by bottomstates.bottomstate asc limit 3;

-- union opertor (where we can combine both topsate and bottomstate)

SELECT 
    *
FROM
    (SELECT 
        *
    FROM
        topstates
    ORDER BY topstates.topstate DESC
    LIMIT 3) a 
UNION SELECT 
    *
FROM
    (SELECT 
        *
    FROM
        bottomstates
    ORDER BY bottomstates.bottomstate ASC
    LIMIT 3) b ;



-- states starting with specefic letter like letter a
select distinct state from dataset1 where lower(state) like 'b%' or lower(state) like 'a%';
select distinct state from dataset1 where lower(state) like 'a%' and lower(state) like '%m';



-- joining table from same database(here database is dataset)
SELECT 
    a.district, a.state, a.sex_ratio, b.population
FROM
    dataset1 a
        INNER JOIN
    dataset2 b ON a.district = b.district;
    


-- join multiple table from same database
SELECT 
    a.district,
    a.state,
    b.population,
    c.topstate AS top_population
FROM
    dataset1 a
        JOIN
    dataset2 b ON a.district = b.district
        JOIN
    topstates c ON a.state = c.state ;



















