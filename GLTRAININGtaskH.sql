--6)write a query  to display customer id and customer name ,num of times movie  issued to customer in comedy movie category
--display only customers who has issude more than once
select distinct cm.customer_id, cm.customer_name ,COUNT(cm.customer_name) "NO. Of Times "
from customer_master cm inner join customer_issue_details cid 
on  cm.customer_id=cid.customer_id 
inner join movies_master mm on cid.movie_id=mm.movie_id
where  mm.movie_category='COMEDY' 
GROUP BY cm.customer_id,cm.customer_name having  COUNT(cm.customer_name)>1;

--7) write a query  to display customerid,cusname,contactno,num of movies issued to  customer based on category and category
--display the customer who has issude for more than one movie from that  caregory.display phone num as "+91-987-654-3210".
select cm.customer_id, cm.customer_name, count(mm.movie_id) as "No. of movies",
('+91-'||substr(cm.contact_no,1,3)||'-'||substr(cm.contact_no,4,3)||'-'||substr(cm.contact_no,7))  as "Phone_Number"
from Customer_Master cm join Customer_Issue_Details cid on cm.customer_id = cid.customer_id
join Movies_Master mm  on cid.movie_id = mm.movie_id
group by cm.customer_id, cm.customer_name,cm.contact_no
having count(mm.movie_id)>1;

--8)display customer name in perfect order i.e 1st letter in ucase remaining lcase

select concat(upper(substr(customer_name,1,1)),lower(substr(customer_name,2,5)) ) as Name
from customer_master;

select initcap(customer_name) from customer_master;
--9) display id,name & total rent of customers for movie issued
select cm.customer_id,cm.customer_name,sum(mm.rent_cost) "TOTAL RENT"
 from customer_master cm inner join customer_issue_details cid on cid.customer_id=cm.customer_id
 inner join movies_master mm on mm.movie_id = cid.movie_id
 group by cm.customer_id,cm.customer_name,mm.rent_cost;
 
--10) display id,name of customers who dont have library card but still have issued the movie

select c.customer_id,customer_name 
from customer_issue_details i,customer_master c
where i.customer_id = c.customer_id and i.customer_id not in (select customer_id from customer_card_details);

--11) display the no.of customers who have paid fine i.e actual return date is greater than return date
select count(b.customer_id) count from 
(select customer_id from customer_issue_details where return_date > actual_date_return 
group by customer_id) b,customer_master c
where b.customer_id = c.customer_id;

--12) display customer name,customer id who have issued max no. of movies issued

select cm.customer_id, cm.customer_name
from Customer_Master cm join Customer_Issue_Details cid on cm.customer_id = cid.customer_id
join Movies_Master mm  on cid.movie_id = mm.movie_id 
group by cm.customer_id, cm.customer_name  order by  count(mm.movie_id) desc fetch first 1 row only;    
         
--13) display customer details and movie id for those who issued same  movie more than one time 

Select cm.*,movie_id
from customer_master cm inner join
(select distinct customer_id,movie_id from customer_issue_details group by movie_id,customer_id having count(issue_id)>1)t
on cm.customer_id = t.customer_id;
 
--14) display total revenue spent on videos by each customer

Select customer_id,sum(rent_cost) as "Revenue" from customer_issue_details cid
inner join movies_master mm on cid.movie_id = mm.movie_id
group by customer_id;

--15) count how many times a movie issued and arrange them in desc order and display 0 for the movie not issued.

select nvl(count(cid.movie_id),0) as Count from  movies_master mm left join customer_issue_details cid 
on mm.movie_id = cid.movie_id
group by cid.movie_id
order by Count desc;