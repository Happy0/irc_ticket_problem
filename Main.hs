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
  import Data.List.Split

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

  groupIntoWithinSameWeek :: [MonthDay] -> [[MonthDay]]
  groupIntoWithinSameWeek [] = [[]]
  groupIntoWithinSameWeek days =
    let (currentWeek, rest) = splitDaysInSameWeek days
    in (currentWeek : groupIntoWithinSameWeek rest)
    where
      splitDaysInSameWeek :: [MonthDay] -> ([MonthDay], [MonthDay])
      splitDaysInSameWeek [] = ([], [])
      splitDaysInSameWeek days@(firstDay : rest) = partition (isWithinWeekOf firstDay) days

      isWithinWeekOf :: MonthDay -> MonthDay -> Bool
      isWithinWeekOf day1 day2 = (day2 - day1) < 7



  findCheapestForWeek :: [MonthDay] -> [Ticket]
  findCheapestForWeek days = if numberOfDays >= 4 then weekTicket else dayTickets
    where
      numberOfDays = length days
      weekTicket = [Week]
      dayTickets = replicate numberOfDays Day

  findCheapestTicketCombination :: [MonthDay] -> [Ticket]
  findCheapestTicketCombination days =
        let groupedByWeek = groupIntoWithinSameWeek days
        in let tickets = concat (map findCheapestForWeek groupedByWeek)
        in
          if (costTickets tickets) >= (ticketCost Month)
             then monthTicket
             else tickets

    where
      numberOfDays = length days
      monthTicket = [Month]

  costTickets :: [Ticket] -> Int
  costTickets tickets = sum (map ticketCost tickets)

  parseDaysFromString :: String -> [MonthDay]
  parseDaysFromString input = map read (splitOn ", " input)

  main :: IO ()
  main = do
    daysTraveling <- fmap parseDaysFromString getLine
    let tickets = findCheapestTicketCombination daysTraveling
    let price = costTickets tickets
    putStrLn (show price)
