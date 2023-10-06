set serveroutput on;
exec interest;

create table book_log(
    bookid_1 number,
    bookname_1 varchar2(40),
    publisher_1 varchar2(40),
    price_1 number
    );
    
insert into book values(15, '과학 좋아요', '과학미디어', 25000);

select * from book where bookdid = 15;

select * from book_log where bookid_1 =15;

-- 실행할 때 블럭설정하고 실행
select custid, orderid, saleprice,func_interest(saleprice) from orders;

exec insertcustomer(6, '박현경', '서울시 용산구 한남동', '010-1222-0341');
create or replace procedure insertcustomer(
    p_custid in number,
    p_name in varchar2,
    p_address in varchar2,
    p_phone in varchar2)
    
as

begin 
    insert into customer(custid, name, address, phone)
    values(p_custid, p_name, p_address, p_phone);
end;

exec insertcustomer(6, '박현경', '서울시 용산구 한남동', '010-1222-0341');

create or replace procedure interest
as
    myInterest numeric;
    price numeric;
    cursor interestCursor is select saleprice from orders;
begin
    myInterest := 0.0;
    open interestCursor;
    loop
        fetch interestCursor into price;
        exit when interestCursor%notfound;
        if price >= 30000 then
            myInterest := myInterest + price*0.1;
        else
            myInterest := myInterest + price*0.5;
        end if;
    end loop;
    close interestCursor;
    dbms_output.put_line('전체 이익금액 = ' || round(myInterest,3));
end;

create or replace trigger afterinsertbook
after insert on book for each row
declare
averager number;
begin
    insert into book_log
    values(:new.bookid, :new.bookname, :new.publisher, :new.price);
    dbms_output.put_line('삽입 행을 book_log 테이블에 백업했습니다.');
end;


