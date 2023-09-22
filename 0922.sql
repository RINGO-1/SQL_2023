-- ���� ���ڿ��� ���̸� �� 15���� ���ߴµ� ������ �μ��� �ִ� ���ڿ��� ���ʺ��� ä���.
select lpad('page 1', 15, '* .') from dual;

-- ���� �̸��� ��ȭ��ȣ�� ����Ͻÿ�. (��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ���)
select name �̸�, phone ��ȭ��ȣ from customer;
select name �̸�, nvl(phone, '����ó����') ��ȭ��ȣ from customer;

-- ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �θ� ����Ͻÿ�.
select rownum ����, custid, name, phone from customer;
select rownum ����, custid, name, phone from customer
where rownum <= 2;

-- mybook ���̺� ����
create table mybook(
    bookid number not null primary key,
    price number 
);

-- ������ �� ����
insert into mybook values(1, 10000);
insert into mybook values(2, 10000);
insert into mybook(bookid) values(3);

select * from mybook;

select *
from mybook;

select bookid, nvl(price,0)
from mybook;

select * 
from mybook
where price is null;

select *
from mybook;

select bookid,price+100
from mybook;

select sum(price),avg(price),count(*)
from mybook
where bookid>=4;

select sum(price), avg(price)
from mybook;

select * from book where rownum <= 5;

select * from book where rownum <= 5 order by price;

select * from (select * from book order by price) b where rownum <= 5;

select * from (select * from book where rownum <= 5) b order by price;

select * from (select * from book where rownum <= 5 order by price) b;

-- ����Ǹűݾ� ������ �ֹ��� ���� �ֹ���ȣ�� �ݾ��� ����Ͻÿ�.
select orderid, saleprice
from orders
where saleprice <= (
    select avg(saleprice) from orders
);
    
-- �� ���� ����Ǹűݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ��� �ֹ���ȣ, ����ȣ, �Ǹűݾ��� ����Ͻÿ�
select orderid �ֹ���ȣ, custid ����ȣ, saleprice �Ǹűݾ� from orders;

select orderid �ֹ���ȣ, custid ����ȣ, saleprice �Ǹűݾ� from orders mo
where saleprice > (
    select avg(saleprice) from orders so where mo.custid = so.custid
);

-- ���￡ �����ϴ� ������ �Ǹ��� ������ ���Ǹűݾ��� ����Ͻÿ�
select sum(saleprice) ���Ǹűݾ� from orders;

-- ���￡ �����ϴ� ����� ����ȣ
select custid from customer
where address like '%����%';

select sum(saleprice) ���Ǹűݾ� from orders
where custid in(select custid from customer
where address like '%����%');

-- ���￡ �������� �ʴ� ������ �Ǹ��� ������ ���Ǹűݾ��� ����Ͻÿ�
select sum(saleprice) ���Ǹűݾ� from orders
where custid not in(select custid from customer
where address like '%����%');

-- 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ����Ͻÿ�
select orderid �ֹ���ȣ, saleprice �Ǹűݾ� from orders;

select orderid �ֹ���ȣ, saleprice �Ǹűݾ� from orders
where saleprice > all(select saleprice from orders where custid=3);

select saleprice from orders where custid=3;

-- ���￡ �����ϴ� ������ �Ǹ��� ������ ���Ǹž� (EXIST ����� ���)
select sum(saleprice) ���Ǹž� from orders mo
where exists(
    select * from customer c 
    where address like '%����%' 
    and mo.custid = c.custid
);

-- ���� �Ǹűݾ��� �հ踦 ����Ͻÿ� (����ȣ, �Ǹ��հ�)
select custid ����ȣ, sum(saleprice) �Ǹ��հ� from orders
group by custid;

select (
    select name from customer c
    where c.custid = o.custid) ����,
    sum(saleprice) �Ǹ��հ� from orders o
group by custid;

-- �ֹ���Ͽ� å�̸��� ������ �� �ִ� �÷��� �߰��Ͻÿ�.
alter table orders add bookname varchar2(40);

update orders o set bookname = (select bookname from book b where b.bookid = o.bookid) ;

-- ����ȣ�� 2������ ����ȣ�� �̸��� ����Ͻÿ�.
select custid ����ȣ, name �̸� from customer
where custid <= 2;

-- ����ȣ�� 2������ ���� �Ǹűݾ��� ����Ͻÿ� (���̸��� ���� �Ǹž� ���)
select name ���̸�, sum(saleprice) �Ǹ��հ�
from (select custid, name from customer
where custid <= 2) c, orders o 
where c.custid = o.custid
group by name;

-- �� �ּҺ� �� �Ǹž�
select custid, (
select address
from customer c
where c.custid = o.custid) address, sum(saleprice) total
from orders o
group by o.custid;