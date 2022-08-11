
create table return2(
	reIdx int not null auto_increment primary key,
	mem_Idx int not null,
	order_Idx int not null,
	return_marchantId varchar(100) not null,
	return_totalprice int not null,
	return_point int default 0,
	return_date dateTime default now(),
	return_type varchar(20) not null,
	return_content varchar(100) not null,
	return_status varchar(50) not null,
	return_indexcnt int default 0,
	foreign key(mem_Idx) references member2(idx),
	foreign key(order_Idx) references order2(orderIdx)
);
drop table return2;
drop table returnsub2;

create table returnsub2(
	resubIdx int not null auto_increment primary key, 
	resub_reIdx int not null,
	resub_subIdx int not null,
	resub_prdIdx int not null,
	resub_option varchar(20) not null,
	resub_price int not null,
	resub_count int not null,
	resub_delPoint int not null,
	return_val int default 0,
	foreign key(resub_reIdx) references return2(reIdx),
	foreign key(resub_subIdx) references ordersub2(order_subIdx),
	foreign key(resub_prdIdx) references product2(prdIdx)
);
select count(*) from return2 as re inner join returnsub2 as res where re.reIdx = res.resub_reIdx and res.return_val =0;
select * from return2 as re inner join returnsub2 as res where re.reIdx = res.resub_reIdx;
select count(*) from order2 as o inner join ordersub2 os on o.orderIdx = os.orderIdx where o.memIdx = 1 and o.pay_price != 0;
select count(*) from order2 as o inner join ordersub2 os on o.orderIdx = os.orderIdx where memIdx = 1 and pay_price != 0;
select count(*) from order2 as o inner join ordersub2 os on o.orderIdx = os.orderIdx where o.memIdx = 1 and o.pay_price != 0 and os.order_val = 4;

select count(*) from order2 as o 
		inner join ordersub2 os 
		on o.orderIdx = os.orderIdx inner join returnsub2 as rs on os.order_subIdx = rs.resub_subIdx
		where o.memIdx = 1 and rs.return_val = 1;
