-- 원본 문자열의 길이를 총 15개로 맞추는데 마지막 인수에 있는 문자열로 왼쪽부터 채운다.
select lpad('page 1', 15, '* .') from dual;

-- 고객의 이름과 전화번호를 출력하시오. (단, 전화번호가 없는 고객은 '연락처없음'으로 출력)
select name 이름, phone 전화번호 from customer;
select name 이름, nvl(phone, '연락처없음') 전화번호 from customer;

-- 고객목록에서 고객번호, 이름, 전화번호를 앞의 두명만 출력하시오.
select rownum 순번, custid, name, phone from customer;
select rownum 순번, custid, name, phone from customer
where rownum <= 2;

-- mybook 테이블 생성
create table mybook(
    bookid number not null primary key,
    price number 
);

-- 데이터 행 삽입
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

-- 평균판매금액 이하의 주문에 대해 주문번호와 금액을 출력하시오.
select orderid, saleprice
from orders
where saleprice <= (
    select avg(saleprice) from orders
);
    
-- 각 고객의 평균판매금액보다 큰 금액의 주문 내역에 대해서만 주문번호, 고객번호, 판매금액을 출력하시오
select orderid 주문번호, custid 고객번호, saleprice 판매금액 from orders;

select orderid 주문번호, custid 고객번호, saleprice 판매금액 from orders mo
where saleprice > (
    select avg(saleprice) from orders so where mo.custid = so.custid
);

-- 서울에 거주하는 고객에게 판매한 도서의 총판매금액을 출력하시오
select sum(saleprice) 총판매금액 from orders;

-- 서울에 거주하는 사람의 고객번호
select custid from customer
where address like '%서울%';

select sum(saleprice) 총판매금액 from orders
where custid in(select custid from customer
where address like '%서울%');

-- 서울에 거주하지 않는 고객에게 판매한 도서의 총판매금액을 출력하시오
select sum(saleprice) 총판매금액 from orders
where custid not in(select custid from customer
where address like '%서울%');

-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 출력하시오
select orderid 주문번호, saleprice 판매금액 from orders;

select orderid 주문번호, saleprice 판매금액 from orders
where saleprice > all(select saleprice from orders where custid=3);

select saleprice from orders where custid=3;

-- 서울에 거주하는 고객에게 판매한 도서의 총판매액 (EXIST 연산사 사용)
select sum(saleprice) 총판매액 from orders mo
where exists(
    select * from customer c 
    where address like '%서울%' 
    and mo.custid = c.custid
);

-- 고객별 판매금액의 합계를 출력하시오 (고객번호, 판매합계)
select custid 고객번호, sum(saleprice) 판매합계 from orders
group by custid;

select (
    select name from customer c
    where c.custid = o.custid) 고객명,
    sum(saleprice) 판매합계 from orders o
group by custid;

-- 주문목록에 책이름을 저장할 수 있는 컬럼을 추가하시오.
alter table orders add bookname varchar2(40);

update orders o set bookname = (select bookname from book b where b.bookid = o.bookid) ;

-- 고객번호가 2이하인 고객번호와 이름을 출력하시오.
select custid 고객번호, name 이름 from customer
where custid <= 2;

-- 고객번호가 2이하인 고객의 판매금액을 출력하시오 (고객이름과 고객별 판매액 출력)
select name 고객이름, sum(saleprice) 판매합계
from (select custid, name from customer
where custid <= 2) c, orders o 
where c.custid = o.custid
group by name;

-- 각 주소별 총 판매액
select custid, (
select address
from customer c
where c.custid = o.custid) address, sum(saleprice) total
from orders o
group by o.custid;