use javagreen_pjh;

create table addressbox2 (
	idx int not null auto_increment primary key,
	memIdx int not null,
	boxName varchar(50) not null,
	reUser varchar(20) not null,
	reTel varchar(50) not null,
	rePost varchar(50) not null,
	reAddress varchar(150) not null,
	foreign key(memIdx) references member2(idx)
);