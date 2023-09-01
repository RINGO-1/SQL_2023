select * from book;

-- book ���̺��� �����̶�� ���ڿ��� �����ϰ� ���������� 15000�� �̻�
SELECT * from book where price>=15000 and bookname like '%����%';

-- book ���̺��� ���ǻ簡 �½����� �Ǵ� ��ũ�ν��� ����
SELECT * from book where publisher='�½�����' or publisher='��ũ�ν�';

-- ���� ������ in �����ڸ� ����ϵ��� ����
SELECT * from book where publisher in('�½�����','��ũ�ν�');

-- book ���̺��� ����������� �˻�
SELECT * from book order by bookname;

-- book ���̺��� ������ȣ������ �˻�
SELECT * from book order by bookid;
    
-- book ���̺��� ���ݼ����� �˻�, ���� �����̸� �̸��� �˻�
SELECT * from book order by price, bookname;

-- book ���̺��� ������ ������������ �˻�, ���� �����̸� ���ǻ� �������� �˻�
SELECT * from book order by price DESC, bookname ASC;

-- order ���̺��� ���� �ֹ��� ������ �� �Ǹž�
-- �����Լ� ���(�հ�: sum)
SELECT * from orders;

SELECT sum(saleprice) as ���Ǹž� from orders;

-- orders ���̺��� ����ȣ�� 1�� ���� �ֹ��� ������ �� �Ǹž�
SELECT sum(saleprice) from orders where custid=1;

-- order ���̺��� �Ǹž��� ��, ���, �ּ�, �ִ밪
SELECT sum(saleprice) as ���Ǹűݾ�, avg(saleprice) as �Ǹž����, min(saleprice) ������, max(saleprice) �ְ� from orders; 

-- orders �����ÿ��� �Ǹ��� ������ ����
SELECT count(*) from orders;

-- orders ���̺��� ���������� 13000�� �̻��� ���� ����
SELECT count(*) from orders where saleprice >= 13000;

-- orders ���̺��� ����ȣ�� 1�Ǵ� 3�� ���� �ֹ� ����
select count(*) from orders where custid = 1 or custid = 3;

-- orders ���̺��� ���ݺ� �ֹ��� ������ ������ ���հ�
-- �׷�ȭ (�κ���: group by)
SELECT custid, COUNT(*) �ֹ�����, sum(saleprice) �ֹ��Ѿ� from orders  group by custid order by custid;

-- orders ���̺��� �ǸŰ����� 8000�� �̻��� ������ ������ ���� �ֹ������� �� ����
-- 2���̻� ������ ���� ���
SELECT custid, COUNT(*) as �������� from orders where saleprice>=8000 group by custid having count(*) >= 2 order by custid; 

--1 
select bookname from book where bookid = 1;

--2
select bookname from book where price >= 20000;

--3 
select sum(saleprice) from orders where custid = 1;

--4
select count(*) from orders where custid =1;

--1
select count(*) from book;

--2
select count(distinct publisher) ���ǻ� from book;

--3
select name, address from customer;

--4
SELECT orderid FROM orders WHERE orderdate BETWEEN '2023-07-04' AND '2023-07-07';

--5
SELECT orderid FROM orders WHERE orderdate not BETWEEN '2023-07-04' AND '2023-07-07';

--6
select name, address from customer where name like '%��%';

--7
select name, address from customer where name like '%��%' and name like '%��%';

