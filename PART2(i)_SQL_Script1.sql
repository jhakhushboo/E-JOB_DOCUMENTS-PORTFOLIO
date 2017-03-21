# create schema
CREATE SCHEMA IF NOT EXISTS StockPriceAndTransaction;

# create table stock
Create Table StockPriceAndTransaction.STOCK(
      Ticker VarChar(10) Not Null,
      Stock_Exchange VarChar(10),
      CONSTRAINT Ticker_pk PRIMARY KEY (Ticker)
      );
      
# insert values
INSERT INTO StockPriceAndTransaction.STOCK
			(Ticker, Stock_Exchange)
	   VALUES
			('AAPL', 'NASDAQ'),
            ('GOOG', 'NASDAQ'),
            ('MSFT', 'NASDAQ'),
            ('IBM',   'NYSE');

# create table PRICE
Create Table StockPriceAndTransaction.PRICE(
      Ticker VarChar(10) Not Null,
      Date datetime,
      Close decimal(6,2),
      CONSTRAINT Price_pk PRIMARY KEY (Ticker, Date)
      );

# insert values
INSERT INTO StockPriceAndTransaction.PRICE
			(Ticker, Date, Close)
	   VALUES
			('AAPL', '2016-03-14', '100'),
			('AAPL', '2016-03-15', '101.5'),
			('AAPL', '2016-03-16', '102.5'),
			('GOOG', '2016-03-14', '87'),
			('GOOG', '2016-03-15', '88'),
			('GOOG', '2016-03-16', '86.5'),
			('MSFT', '2016-03-14', '186.5'),
			('MSFT', '2016-03-15', '188.5'),
			('MSFT', '2016-03-16', '189'),
			('IBM ', '2016-03-14', '72'),
			('IBM ', '2016-03-15', '70'),
			('IBM ', '2016-03-16', '69');
            

#create table BUYnSELL     
Create Table StockPriceAndTransaction.BUYnSELL( 
      Ticker VarChar(10) Not Null,
      Buy_Sell VarChar(4) Not Null,
      Date datetime,
      Time time,
      Price decimal(6,2),
      Num_of_Shares numeric(10),
      CONSTRAINT Price_pk PRIMARY KEY (Ticker, Date, Time)
      );

# insert values
INSERT INTO StockPriceAndTransaction.BUYnSELL
			(Ticker, Buy_Sell, Date, Time, Price, Num_of_Shares)
	   VALUES
			('AAPL', 'BUY ', '2016-03-14', '10:01:00', '99   ','1000'),
			('AAPL', 'BUY ', '2016-03-14', '11:22:00', '99.5 ','1000'),
			('AAPL', 'BUY ', '2016-03-15', '14:22:00', '100  ','1000'),
			('AAPL', 'SELL', '2016-03-16', '14:42:00', '103  ','3000'),
			('GOOG', 'BUY ', '2016-03-14', '12:22:00', '86   ','2200'),
			('GOOG', 'SELL', '2016-03-14', '14:00:00', '87   ','1000'),
			('GOOG', 'SELL', '2016-03-15', '10:22:00', '87.5 ','1000'),
			('GOOG', 'BUY ', '2016-03-15', '13:28:00', '87   ','800'),
			('GOOG', 'SELL', '2016-03-16', '11:45:00', '86   ','500'),
			('MSFT', 'BUY ', '2016-03-14', '11:45:00', '186  ','1500'),
			('MSFT', 'SELL', '2016-03-15', '10:45:00', '188  ','1000'),
			('MSFT', 'BUY ', '2016-03-16', '12:03:00', '187  ','2500'),
			('IBM ', 'BUY ', '2016-03-14', '11:55:00', '73   ','1500'),
			('IBM ', 'BUY ', '2016-03-15', '10:45:00', '71   ','2000'),
			('IBM ', 'SELL', '2016-03-16', '12:09:00', '70.5 ','2500');

#i. Find the tickers and closing prices of all stocks in the `NASDAQ' exchange on `3/15/2016'.
SELECT DISTINCT P.Ticker, P.Close 
  FROM StockPriceAndTransaction.PRICE P, 
       StockPriceAndTransaction.stock S
 WHERE S.Ticker         = P.Ticker 
   AND S.Stock_Exchange = 'NASDAQ' 
   AND P.Date           = '2016-03-15';

#ii. Find the tickers of all stocks that closed higher than `IBM' on `3/15/2016'.
SELECT DISTINCT P.Ticker 
  FROM StockPriceAndTransaction.PRICE P
 WHERE P.Date  = '2016-03-15'
   AND P.Close > (SELECT Close 
                    FROM StockPriceAndTransaction.PRICE 
				   WHERE Ticker ='IBM' 
                     AND Date   = '2016-03-15');

#iii. Find the tickers of all stocks whose closing price on `3/15/2016' was either strictly below $20 or above $100

SELECT DISTINCT P.Ticker 
  FROM StockPriceAndTransaction.PRICE P
 WHERE P.Close < 20
    OR P.CLose > 100
   AND P.Date  = '2016-03-15';


#iv. Find the tickers of all stocks in `NYSE' whose closing price on `3/15/2016' was either strictly
# below $20 or above $100

SELECT DISTINCT P.Ticker
  FROM StockPriceAndTransaction.price P, StockPriceAndTransaction.stock S 
 WHERE P.Date = '2016-03-15'
   AND P.Close < 20
    OR P.Close > 100
   AND P.Ticker = S.Ticker
   AND S.Stock_Exchange = 'NYSE';


#v. Find the dates where the total price (i.e. price times num of shares) of `AAPL' the firm
#(i.e. the trading firm which is using this database) sold was higher than what the firm
#bought in `NASDAQ'.

## I HAVE USED HERE SELF JOIN BECAUSE IT IS NOT POSSIBLE TO COMPARE ONE RECORD (ROW) TO ANOTHER RECORD(ROW) 
# AT A TIME. WE CAN COMPARE ONE COLUMN TO ANOTHER COLUMN AT A TIME. SO BY INNER JOIN I DECOMPOSE TABLE INTO TWO 
# SUB TABLES AND THEN COMPARE.

## ALSO THERE ARE NO RECORDS FOR 'AAPL', ASKED QUESTION WILL GIVE RESULT ONLY FOR 'GOOG' FOR THE GIVEN DATA 
SELECT DISTINCT D.DATE_C
  FROM (
		SELECT DISTINCT B.Ticker as TICKER_B,(B.PRICE*B.NUM_OF_SHARES) AS AMOUNT_B,B.Price AS PRICE_B,B.Num_of_Shares AS SHR_QTY_B,
               B.Buy_Sell AS BUY_SELL_B,C.DATE AS DATE_C,C.Buy_Sell AS BUY_SELL_C,C.Num_of_Shares SHR_QTY_C,
               C.Price AS PRICE_C,(C.PRICE*C.NUM_OF_SHARES) AS AMOUNT_C
		  FROM StockPriceAndTransaction.BUYnSELL B, 
			   StockPriceAndTransaction.BUYnSELL C
		 WHERE B.Ticker   = 'APPL' 
		   AND B.Ticker   = C.Ticker 
		   AND B.Buy_Sell = 'SELL'
		   AND C.Buy_Sell = 'BUY' 
		   AND B.Date     = C.Date
		   AND B.Price*B.Num_of_Shares > C.Price*C.Num_of_Shares
		) D; 



#vi. Find the tickers of the stocks whose closing price showed the highest increase between
#`3/15/2016' and `3/16/2016' in `NYSE'
#(we are asking for \all stocks" since there may be more than one with the same increase)

# THERE IS NO SUCH RECORD AS IBM TRADES ON NYSE, AND BETWEEN 15 AND 16 MARCH THERE IS DECREASE IN CLOSE PRICE, NOT INCREASE 
SELECT DISTINCT kj1.ticker 
FROM(

		(	
            SELECT k1.ticker,j2.date,j2.close 
			  FROM StockPriceAndTransaction.stock AS k1,StockPriceAndTransaction.PRICE AS j2
			 WHERE j2.date = '2016-03-15' 
               AND k1.Stock_Exchange = 'NYSE' 
               AND k1.ticker = j2.ticker
		) AS kj1,

		(	
			SELECT k1.ticker,j2.date,j2.close 
			  FROM StockPriceAndTransaction.stock AS k1, StockPriceAndTransaction.price AS j2
			 WHERE j2.date = '2016-03-16' 
               AND   k1.Stock_Exchange = 'NYSE'
               AND k1.ticker = j2.ticker
		) AS kj2
	)

 WHERE kj1.TICKER = kj2.ticker 
   AND kj2.close  > kj1.close
HAVING MAX(kj2.close - kj1.close);
