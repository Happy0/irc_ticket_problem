-- you want to buy public transit tickets for the upcoming months
-- you know what days you will be travelling on
-- a month has 30 days and there are three types of ticket
-- 1 day ticket, costs 2
-- 7 day ticket, costs 7
-- 30 day ticket, costs 25
-- you want to pay as little as possible
-- you are given a sorted array A of dates you will be travelling
-- i.e.
-- [1, 2, 4, 5, 7, 29, 30]

module Main where

  import Data.List

  data Ticket = Day | Week | Month

  instance Show Ticket where
    show Day = "Day ticket"
    show Week = "Week ticket"
    show Month = "Month ticket"

  type MonthDay = Int

  ticketCost :: Ticket -> Int
  ticketCost Day = 2
  ticketCost Week = 7
  ticketCost Month = 25

  groupIntoCalendarWeeks :: [MonthDay] -> [[MonthDay]]
  groupIntoCalendarWeeks = groupBy hasSameQuotientDiv7
    where
      hasSameQuotientDiv7 num1 num2 = (num1 `div` 7) == (num2 `div` 7)

  findCheapestForWeek :: [MonthDay] -> [Ticket]
  findCheapestForWeek days = if numberOfDays >= 4 then weekTicket else dayTickets
    where
      numberOfDays = length days
      weekTicket = [Week]
      dayTickets = replicate numberOfDays Day

  findCheapestTicketCombination :: [MonthDay] -> [Ticket]
  findCheapestTicketCombination days
    | numberOfDays >= 23 = monthTicket
    | otherwise =
        let groupedByWeek = groupIntoCalendarWeeks days
        in concat (map findCheapestForWeek groupedByWeek)

    where
      numberOfDays = length days
      monthTicket = [Month]

  main :: IO ()
  main = do
    let daysTraveling = [1, 2, 4, 5, 7, 29, 30]
    let ticketsNeeded = findCheapestTicketCombination daysTraveling

    mapM_ (putStrLn . show) ticketsNeeded
