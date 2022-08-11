create table order2(
	orderIdx int not null auto_increment primary key,
	memIdx int not null,
	pay_marchantId varchar(100) not null,
	pay_price int not null,
	pay_setPoint int default 0,
	pay_getName varchar(20) not null,
	pay_getTel varchar(50) not null,
	pay_getPost varchar(50) not null,
	pay_getAddress varchar(100) not null,
	pay_getPostMsg varchar(50) not null,
	pay_orderDate dateTime default now(),
	indexcnt int default 0,
	foreign key(memIdx) references member2(idx)
);
drop table order2;
drop table orderSub2;
create table orderSub2(
	order_subIdx int not null auto_increment primary key,
	order_memIdx int not null,
	orderIdx int not null,
	order_prdIdx int not null,
	order_prdCount int not null,
	order_prdPrice int not null,
	order_prdOption varchar(20) not null,
	order_prdPoint int not null,
	order_val int default 0,
	foreign key(orderIdx) references order2(orderIdx),		
	foreign key(order_memIdx) references member2(idx),		
	foreign key(order_prdIdx) references product2(prdIdx)		
);
update subcategory2 set order_lastdate = now() where order_subIdx = 18;

select sum(order_prdCount * order_prdPrice) as totals,
sum(p.rPrice * order_prdCount) as rtot,
sum((order_prdCount * order_prdPrice)-(p.rPrice * order_prdCount)) as stot
from ordersub2 as os inner join order2 as o on os.orderIdx = o.orderIdx
inner join product2  as p on p.prdIdx = os.order_prdIdx
where pay_orderDate between date('2022-07-01') and date('2022-07-30');

select count(*) from returnsub2 as res inner join return2 as r on res.resub_reIdx = r.reIdx where r.mem_Idx = 1;

select count(*) from returnsub2 as res inner join return2 as r on res.resub_reIdx = r.reIdx
where r.return_status LIKE CONCAT("%", '취소', "%")   and r.mem_Idx = 1 and res.return_val = 0;

select count(*) from returnsub2 as res inner join return2 as r on res.resub_reIdx = r.reIdx
where r.return_status LIKE CONCAT("%", '환불', "%")   and r.mem_Idx = 1 and res.return_val = 0;

select count(*) from returnsub2 as res inner join return2 as r on res.resub_reIdx = r.reIdx
where r.mem_Idx = 1 and res.return_val = 1;



select * from boardreply2 as re inner join member2 as m on re.boRe_memIdx = m.idx where re.boRe_boIdx = 4 order by re.boRe_boReIdx,re.boReIdx,re.boRe_index;

select * from return2 as re inner join returnsub2 as res on re.reIdx = res.resub_reIdx where mem_Idx = 1 and res.return_val =0;
select count(*) from ordersub2 as o inner join product2 as p on o.order_prdIdx = p.prdIdx inner join order2 on o.orderIdx = order2.orderIdx inner join member2 on order2.memIdx = member2.idx and order2.memIdx = 1;
select *from order2 where memIdx = 1;
select * from ordersub2 as o product2 as p where o.order_prdIdx = p.prdIdx;
select * from ordersub2 as o inner join product2 as p on o.order_prdIdx = p.prdIdx;
select count(*) from ordersub2 as o inner join product2 as p on o.order_prdIdx = p.prdIdx inner join order2 on o.orderIdx = order2.orderIdx inner join member2 on order2.memIdx = member2.idx; 
select * from ordersub2 as o inner join product2 as p on o.order_prdIdx = p.prdIdx inner join order2 on o.orderIdx = order2.orderIdx inner join member2 on order2.memIdx = member2.idx 
where 1 > TIMESTAMPDIFF(DAY,order2.pay_orderDate,CURDATE());
select * from ordersub2 as o inner join product2 as p on o.order_prdIdx = p.prdIdx inner join order2 on o.orderIdx = order2.orderIdx inner join member2 on order2.memIdx = member2.idx 
where order2.pay_orderDate between date('2022-07-01') and date('2022-07-16')+1;
select * from ordersub2 as o inner join product2 as p on o.order_prdIdx = p.prdIdx inner join order2 on o.orderIdx = order2.orderIdx inner join member2 on order2.memIdx = member2.idx where o.orderIdx = 10 and o.order_prdCount != 0;