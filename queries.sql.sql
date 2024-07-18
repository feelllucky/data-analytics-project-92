select count(*) as customers_count from customers
-- данный запрос считает общее количество покупателей из таблицы customers
;

select concat(e.first_name, ' ', e.last_name) as seller,
count(s.sales_person_id) as operations,
sum(s.quantity*p.price) as income
from employees e 
left join sales s 
on e.employee_id = s.sales_person_id 
left join products p 
on s.product_id = p.product_id 
group by e.first_name, e.last_name
order by income desc nulls last
limit 10
--запрос на получение данных о продавце, суммарной выручке с проданных товаров и количестве проведенных сделок, отсортированных по убыванию выручки
;

select concat(e.first_name, ' ', e.last_name) as seller,
round(avg(s.quantity*p.price), 0) as avrega_income
from employees e 
left join sales s 
on e.employee_id = s.sales_person_id 
left join products p 
on s.product_id = p.product_id 
group by e.first_name, e.last_name
having round(avg(s.quantity*p.price), 0) < (select round(avg(s.quantity*p.price), 0)
from sales s 
inner join products p 
on s.product_id = p.product_id)
order by avrega_income asc
--запрос на получение данных о продавцах, чья средняя выручка за сделку меньше средней выручки за сделку по всем продавцам, отсортированных по возрастанию выручки
;

select 
	concat(e.first_name, ' ', e.last_name) as seller,
	to_char(s.sale_date, 'Day') as day_of_week,
	round(sum(s.quantity*p.price), 0) as income
from employees e 
left join sales s 
on e.employee_id = s.sales_person_id 
left join products p 
on s.product_id = p.product_id
group by e.first_name, e.last_name, s.sale_date
order by EXTRACT(DOW FROM sale_date), seller
-- запрос на получение данных о выручке по дням недели, отсортированных по порядковому номеру дня недели и продавцу 
;
