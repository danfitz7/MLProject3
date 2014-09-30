library(fImport);
library(tseries);
tckk <- c("AAPL", "ABT", "ACN", "AEP", "ALL", "AMGN", "AMZN", "APA", "APC", "AXP", "BA", "BAC", "BAX", "BHI", "BK", "BMY", "BRK/B", "C", "CAT", "CL", "CMCSA", "COF", "COP", "COST", "CSCO", "CVS", "CVX", "DD", "DELL", "DIS", "DOW", "DVN", "EBAY", "EMC", "EMR", "EXC", "F", "FCX", "FDX", "GD", "GE", "GILD", "GOOG", "GS", "HAL", "HD", "HNZ", "HON", "HPQ", "IBM", "INTC", "JNJ", "JPM", "KO", "LLY", "LMT", "LOW", "MA", "MCD", "MDLZ", "MDT", "MET", "MMM", "MO", "MON", "MRK", "MS", "MSFT", "NKE", "NOV", "NSC", "NWSA", "ORCL", "OXY", "PEP", "PFE", "PG", "PM", "QCOM", "RTN", "SBUX", "SLB", "SO", "SPG", "T", "TGT", "TWX", "TXN", "UNH", "UNP", "UPS", "USB", "UTX", "V", "VZ", "WAG", "WFC", "WMB", "WMT", "XOM")
numtk <- length(tckk);
ustart <- "2013-01-01";
uend <- "2014-09-15";
all_dat <- list();
for (i in 1:numtk){
  all_dat[[i]] <- xxx <- get.hist.quote(instrument=tckk[i], start=ustart, end=uend, quote = c("AdjClose"), provider="yahoo")
}

