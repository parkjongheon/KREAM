use javagreenS_pjh;

drop table brand2;
drop table category2;
drop table subcategory2;

create table brand2(
	brIdx int not null auto_increment primary key,
	kbrName varchar(80) not null,
	ebrName varchar(80) not null unique,
	brfName varchar(150) default 'noImage.jpg'
);
create table category2(
	idx int not null auto_increment primary key,
	category varchar(50) not null unique
);
create table subcategory2(
	idx int not null auto_increment primary key,
	category varchar(50) not null,
	subcategory varchar(50) not null,
	foreign key(category) references category2(category)
);

drop table product2;
ALTER TABLE cart2 AUTO_INCREMENT = 1;

create table product2(
	prdIdx int not null auto_increment primary key,
	ebrName varchar(80) not null,
	kprdName varchar(80) not null,
	eprdName varchar(80) not null,
	prdNum varchar(80) not null,
	prdCategory varchar(50) not null,
	prdSubCategory varchar(50) not null,
	prdRdate varchar(100) not null,
	color varchar(50) not null,
	sPrice int not null,
	rPrice int not null,
	prdfName varchar(200) not null,
	prdContent text,
	sellCount int default 0,
	sellStop int default 0,
	wishCount int default 0,
	prdSale int default 0,
	foreign key(ebrName) references brand2(ebrName)
);

drop table prdOption2;

create table prdOption2(
	opIdx int not null auto_increment primary key,
	prdIdx int not null,
	size varchar(50) not null,
	count int not null,
	indexCount int not null,
	foreign key(prdIdx) references product2(prdIdx)
);

create table cart2(
	idx int not null auto_increment primary key,
	memIdx int not null,
	prdIdx int not null,
	prdoption varchar(20),
	prdCount int not null,
	foreign key(memIdx) references member2(idx),
	foreign key(prdIdx) references product2(prdIdx)	
);

select count(*) from product2 as p inner join brand2 as b on b.ebrName = p.ebrName where b.brIdx = 1;


create table wishList2(
	wIdx int not null auto_increment primary key,
	memIdx int not null,
	prdIdx int not null,
	foreign key(memIdx) references member2(idx),
	foreign key(prdIdx) references product2(prdIdx)	
);
select * from wishlist2 as w inner join product2 as p on w.prdIdx = p.prdIdx where w.memIdx = 1;

select *,(select memIdx,prdIdx from whisList2 where prdIdx = prduct2.prdIdx) from product2;

select * from cart2 as ct , product2 as pro where memIdx = 1 and ct.prdIdx = 14 and ct.prdIdx = pro.prdIdx and ct.prdoption = 250;

select * from product2 p inner join category2 as c on p.prdCategory = c.category where c.idx = 1;
select * from product2 p inner join subcategory2 as s on p.prdSubCategory = s.subcategory where s.idx = 1;

select * from prdOption2 as op , product2 as pro where op.prdIdx = pro.prdIdx and pro.prdIdx = 7 order by op.indexCount;

select *,(select count(*) from boardreply2 as br where br.boRe_boIdx = bo.boIdx) as reCnt from board2 as bo
		 inner join member2 as m
		  on bo.bo_memIdx = m.idx left join product2 as p on p.prdIdx = bo.bo_prdIdx
		  where bo_val = 0 and p.prdIdx = 2;