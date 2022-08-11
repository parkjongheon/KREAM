create table board2 (
	boIdx int not null auto_increment primary key,
	bo_memIdx int not null,
	bo_prdIdx int default 0,
	bo_fName varchar(200) not null,
	bo_content varchar(200) not null,
	bo_tag varchar(150),
	bo_date dateTime default now(),
	bo_likeCnt int default 0,
	bo_val int default 0,
	foreign key(bo_memIdx) references member2(idx)
);
select msg.msg_memIdx from msgbox2 as msg where msg_memIdx = 2;

create table tagBox2(
	tagIdx int not null auto_increment primary key,
	tagName varchar(50) not null,
	tagCnt int default 0
);

select * from board2 as bo inner join member2 as m on bo.bo_memIdx = m.idx where bo.boIdx = 1;
drop table board2;

select * from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx inner join product2 as p on prdIdx = bo_prdIdx
		   where bo.boIdx = 1;
drop table boardReply2;
create table boardReply2(
	boReIdx int not null auto_increment primary key,
	boRe_boIdx int not null,
	boRe_memIdx int not null,
	boRe_boReIdx int not null,
	boRe_coment varchar(100) not null,
	boRe_date dateTime default now(),
	boRe_forMem varchar(100) default null,
	boRe_forMemIdx int default 0,
	boRe_val int default 0,
	boRe_index int default 0,
	foreign key(boRe_boIdx) references board2(boIdx),
	foreign key(boRe_memIdx) references member2(idx)
); 
select kprdName as brand,sellCount as cnt from product2 order by sellCount desc limit 5;
select ebrName as brand,sellCount as cnt from product2 order by sellCount desc limit 5;
select * from ordersub2 as os inner join product2 as p on os.order_prdIdx = p.prdIdx orderI by os.order_prdIdx;

drop table declaration2;

create table declaration2(
	d_Idx int not null auto_increment primary key,
	d_memIdx int not null,
	d_boIdx int not null,
	d_status varchar(20) not null,	
	d_content varchar(50) not null,
	d_decDate dateTime default now(),
	d_coment varchar(100) null,
	foreign key(d_boIdx) references board2(boIdx),
	foreign key(d_memIdx) references member2(idx)
);
create table inquiry2(
	
);
select * from declaration2 as d inner join member2 as m on d.d_memIdx = m.idx;
select * from declaration2 as d inner join board2 as b on d.d_boIdx = b.boIdx inner join member2 as m on d.d_memIdx = m.idx where d_Idx = 1;

create table boardLike2(
	blIdx int not null auto_increment primary key,
	bl_memIdx int not null,
	bl_boardIdx int,
	foreign key(bl_memIdx) references member2(idx)
);
select *,(select count(*) from boardreply2 as br where br.boRe_boIdx = bo.boIdx) as reCnt from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx LEFT join product2 as p on p.prdIdx = bo.bo_prdIdx
		  where bo_val = 0 limit 0,16;

select * from tagbox2 order by tagCnt desc,tagIdx desc limit 10;
select *,(select count(*) from boardreply2 as br where br.boRe_boIdx = bo.boIdx) as reCnt from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx inner join product2 as p on p.prdIdx = bo.bo_prdIdx
		   where bo.bo_memIdx = 1;
select * from boardreply2 as re inner join member2 as m on re.boRe_memIdx = m.idx where re.boRe_boIdx = 4 order by re.boRe_boReIdx desc,re.boReIdx,re.boRe_index;
select * from boardreply2 as re inner join member2 as m on re.boRe_memIdx = m.idx where re.boRe_boIdx = 4 order by re.boRe_boReIdx,re.boReIdx,re.boRe_index;

select *,(select count(*) from boardreply2 as br where br.boRe_boIdx = bo.boIdx) as reCnt from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx left join product2 as p on p.prdIdx = bo.bo_prdIdx
		  where bo_val = 0 order by bo.bo_likeCnt, reCnt, bo.boIdx desc;

select *,(select count(*) from boardreply2 as br where br.boRe_boIdx = bo.boIdx) as reCnt from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx left join product2 as p on p.prdIdx = bo.bo_prdIdx inner join follow2 f on m.idx = f.for_Idx
		  where bo_val = 0 and bo.bo_memIdx = f.for_Idx and f.who_Idx = 1 order by bo.boIdx desc;
		  
select count(*) from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx left join product2 as p on p.prdIdx = bo.bo_prdIdx inner join follow2 f on m.idx = f.for_Idx
		  where bo_val = 0 and bo.bo_memIdx = f.for_Idx and f.who_Idx = 1;
		  
		  
select count(*) from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx left join product2 as p on p.prdIdx = bo.bo_prdIdx
		  where bo.bo_val = 0 and bo.bo_tag LIKE CONCAT("%", '나이키', "%");		

select *,(select count(*) from boardreply2 as br where br.boRe_boIdx = bo.boIdx) as reCnt from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx left join product2 as p on p.prdIdx = bo.bo_prdIdx
		  where bo.bo_val = 0 and bo.bo_tag LIKE CONCAT("%", '나이키', "%") order by bo.boIdx desc limit #{startIndexNo},#{pageSize};

		  select * from member2 where idx = (select for_Idx from follow2 where who_Idx = 1);  
		  select who_Idx from follow2 where for_Idx = 1
		  select * from member2 where idx = (select who_Idx from follow2 where for_Idx = 1); 
		  
				  
		  select * from member2 as m inner join follow2 as f on m.idx = f.who_Idx where f.for_Idx = 1 and m.userDel = 'NO';
		  
		  select * from member2 as m inner join follow2 as f on m.idx = f.for_Idx where f.who_Idx = 1 and m.userDel = 'NO';