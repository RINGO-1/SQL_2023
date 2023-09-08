-- ���տ���� : ������(UNION), ������(MINUS), ������(INTERSECT)
-- ������ ������ ���
-- ������ �ֹ����� ���� ���� �̸�

select name from customer;

select name from customer
where custid in (select custid from orders);

-- ������ ������ ���
select name from customer
minus
select name from customer
where custid in (select distinct custid from orders);

-- ���տ����� �̻��
select name from customer
where custid not in (select distinct custid from orders);

-- EXISTS: ���������� ����� �����ϴ� ��쿡 TRUE
-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ���
-- in �����ڸ� ����� ���
select name, address from customer
where custid in (select distinct custid from orders); 

-- �������ΰ� �ߺ��� ����
select name, address from customer c, orders o
where c.custid = o.custid ;

-- Exists ����� ���
select name, address from customer c
where exists(select * from orders o
                            where c.custid = o.custid);
                    
-- 1-5
select count(distinct publisher) from book b
where b.bookid in(select bookid from orders o, customer c where o.custid = c.custid and c.name ='������');
;;;;;
-- 1-6
select bookname, price, price - saleprice from customer c, orders o, book b
where (c.custid = o.custid) and (b.bookid = o.bookid) and (c.custid = 1);

-- 1-7
select name, sum(saleprice) from orders o, customer c
where o.custid = c.custid group by name;

-- ������ ���ݰ� �ǸŰ����� ���̰� ���� ū �ֹ�
select * from book b, orders o
where b.bookid = o.bookid
and price - saleprice = (select max(price - saleprice)
                                    from book sb, orders so
                                    where sb.bookid = so.bookid);
                                    
-- DDL(Date Defination Language) : ������ ���Ǿ�
-- vreate table/alter table/drop table
-- ���̺� ���� ���� 
create table newbook1(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- ���̺� ���� ���� 2
-- primary key ���� ��� 1
create table newbook2(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookid)
    );
    
-- primary key ���� ��� 2
create table newbook3(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
    );
    
-- bookname �÷�: null�� �����
-- publisher �÷�: ������ ���� ���� �� ����
-- price �÷�: �⺻�� 10000, �ּҰ� 1000�ʰ�
-- bookname, publisher �÷��� ����Ű�� ����
create table newbook4(
    bookname varchar2(20) not null ,
    publisher varchar2(20) unique,
    price number default 10000 check (price > 1000),
    
    primary key (bookname, publisher)
    );