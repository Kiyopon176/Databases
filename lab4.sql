create database lab4;

create table Warehouses (
    code integer,
    location varchar(255),
    capacity integer
);

create table Boxes (
    code varchar(4),
    contents varchar(255),
    value real,
    warehouse integer
);

insert into Warehouses values (1, 'Chicago', 3),
                              (2, 'Chicago', 4),
                              (3, 'New York', 7),
                              (4, 'Los Angeles', 2),
                              (5, 'San-Francisco', 8);

insert into Boxes values ('OMN7', 'Rocks', 180, 3),
                         ('4H8P', 'Rocks', 250, 1),
                         ('4RT3', 'Scissors', 190, 4),
                         ('7G3H', 'Rocks', 200, 1),
                         ('8JN6', 'Papers', 75, 1),
                         ('8Y6U', 'Papers', 50, 3),
                         ('9J6F', 'Papers', 175, 2),
                         ('LL08', 'Rocks', 140, 4),
                         ('P0H6', 'Scissors', 125, 1),
                         ('P2T6', 'Scissors', 150, 2),
                         ('TU55', 'Papers', 90, 5);

select * from warehouses;

select * from boxes
where value > 150;

select distinct contents, count(contents)from boxes
group by contents;

select warehouse, count(*) from boxes
group by warehouse
order by warehouse;

SELECT warehouse, COUNT(*)
FROM Boxes
GROUP BY warehouse
HAVING COUNT(*) > 2;

insert into warehouses values (6, 'New York', 3);

insert into boxes values ('H5RT', 'Papers', 200, 2);

update boxes
set value = value * 0.85
where code = (
    select code
    from boxes
    order by value desc
    limit 1 offset 2
);

delete from boxes
where value < 150;

delete from boxes
where warehouse in (
    select code
    from warehouses
    where location = 'New York'
)
returning *;